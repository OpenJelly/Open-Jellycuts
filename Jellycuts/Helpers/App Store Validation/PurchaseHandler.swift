//
//  PurchaseHandler.swift
//  Jellycuts
//
//  Created by Zachary Lineman on 2/8/23.
//

import Foundation
import StoreKit
import HydrogenReporter

public typealias ProductIdentifier = String
public typealias ProductsRequestCompletionHandler = (_ success: Bool, _ products: [SKProduct]?) -> Void

class PurchaseHandler: NSObject {
    enum JellycutsProduct: String, CaseIterable {
        static let tips: [JellycutsProduct] = [.Tier1_Tip, Tier2_Tip, Tier3_Tip, Tier4_Tip, Tier5_Tip]
        static let pro: [JellycutsProduct] = [.Tier1_Pro, Tier2_Pro, Tier3_Pro, Tier4_Pro, Tier5_Pro]

        case Tier5_Tip = "massivetip"
        case Tier4_Tip = "gianttip"
        case Tier3_Tip = "largetip"
        case Tier2_Tip = "mediumtip"
        case Tier1_Tip = "smalltip"
        
        case Tier5_Pro = "com.zlineman.Jellyfish.tier.5.pro"
        case Tier4_Pro = "com.zlineman.Jellyfish.tier.4.pro"
        case Tier3_Pro = "com.zlineman.Jellyfish.tier.3.pro"
        case Tier2_Pro = "com.zlineman.Jellyfish.tier.2.pro"
        case Tier1_Pro = "com.zlineman.Jellyfish.tier.1.pro"

    }
    
    static var shared: PurchaseHandler = PurchaseHandler()
    
    private var productsRequest: SKProductsRequest?
    private var productsRequestCompletionHandler: ProductsRequestCompletionHandler?
    private var purchasedProductIdentifiers: Set<ProductIdentifier> = []

    static var verificationURL: String {
        get {
            switch Config.appConfiguration {
            case .Debug:
                return "https://actuallyhome.herokuapp.com/API/verification/sandbox/jellycuts"
            case .TestFlight:
                return "https://actuallyhome.herokuapp.com/API/verification/sandbox/jellycuts"
            case .AppStore:
                return "https://actuallyhome.herokuapp.com/API/verification/jellycuts"
            }
        }
    }

    static var keychainValue: String {
        get {
            switch Config.appConfiguration {
            case .Debug:
                return KeychainValues.hasSubscribed.rawValue + "-debug"
            case .TestFlight:
                return KeychainValues.hasSubscribed.rawValue + "-debug"
            case .AppStore:
                return KeychainValues.hasSubscribed.rawValue
            }
        }
    }
    
    static var isProMode: Bool {
        get {
            guard let purchaseStatus = SharedDataStorageManager.keychain.getBool(keychainValue) else {
                return false
            }
            return purchaseStatus
        }
        set(value) {
            SharedDataStorageManager.keychain.set(value, forKey: PurchaseHandler.keychainValue)
        }
    }

    private override init() {
        for productIdentifier in JellycutsProduct.pro.map({$0.rawValue}) {
            let purchased = SharedDataStorageManager.keychain.getBool(productIdentifier) ?? false
            if purchased {
                purchasedProductIdentifiers.insert(productIdentifier)
                LOG("Previously Purchased: \(productIdentifier)")
            } else {
                LOG("Not Purchased: \(productIdentifier)")
            }
        }
        
        super.init()
        SKPaymentQueue.default().add(self)
    }
            
    static func verifyIAP(purchasedID: String) async throws -> VerificationResult {
        let url = URL(string: verificationURL)!
        let publicKey = ""
        
        guard let verifier = IAPReceiptVerifier(url: url, base64EncodedPublicKey: publicKey) else {
            throw VerificationResult.invalidSettings
        }
        
        let receipt = try await verifier.verify()
        guard let status = receipt["status"] as? Int else { throw VerificationResult.unauthorized }
        
        if status != 0 {
            if status == 21003 {
                throw VerificationResult.unauthorized
            }
            throw VerificationResult.error(status: status)
        } else {
            guard let localReceipt = receipt["receipt"] as? [String: AnyObject] else { throw VerificationResult.incompleteReceipt }
            guard let receipts = localReceipt["in_app"] as? [AnyObject] else { throw VerificationResult.incompleteReceipt }

            for receipt in receipts {
                guard let receipt = receipt as? [String: AnyObject] else { throw VerificationResult.incompleteReceipt }
                guard let id = receipt["product_id"] as? String else { throw VerificationResult.incompleteReceipt }
                
                if id == purchasedID {
                    return .validReceipt
                }
            }
        }
        
        return VerificationResult.unauthorized
    }
}

// MARK: Product Status
extension PurchaseHandler {
    public func requestProducts(_ completionHandler: @escaping ProductsRequestCompletionHandler) {
        productsRequest?.cancel()
        productsRequestCompletionHandler = completionHandler
        
        productsRequest = SKProductsRequest(productIdentifiers: Set(JellycutsProduct.allCases.compactMap({$0.rawValue})))
        productsRequest!.delegate = self
        productsRequest!.start()
    }
    
    public func buyProduct(_ product: SKProduct) {
        LOG("Buying \(product.productIdentifier)...", level: .working)
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    public func isProductPurchased(_ productIdentifier: ProductIdentifier) -> Bool {
        return purchasedProductIdentifiers.contains(productIdentifier)
    }
    
    public class func canMakePayments() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
    
    public func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}

// MARK: SKProductsRequestDelegate
extension PurchaseHandler: SKProductsRequestDelegate {
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        LOG("Loaded list of products", level: .success)
        let products = response.products
        productsRequestCompletionHandler?(true, products)
        clearRequestAndHandler()
        
        for p in products {
            LOG("Found product: \(p.productIdentifier) \(p.localizedTitle) \(p.price.floatValue)", level: .success)
        }
    }
    
    public func request(_ request: SKRequest, didFailWithError error: Error) {
        LOG("Failed to load list of products. Error: \(error)", level: .error)
        productsRequestCompletionHandler?(false, nil)
        clearRequestAndHandler()
    }
    
    private func clearRequestAndHandler() {
        productsRequest = nil
        productsRequestCompletionHandler = nil
    }
}

// MARK: SKPaymentTransactionObserver
extension PurchaseHandler: SKPaymentTransactionObserver {
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        for transaction in queue.transactions {
            switch (transaction.transactionState) {
            case .purchased:
                complete(transaction: transaction)
                break
            case .failed:
                fail(transaction: transaction)
                break
            case .restored:
                restore(transaction: transaction)
                break
            case .deferred:
                break
            case .purchasing:
                break
            @unknown default:
                NotificationCenter.default.post(name: .purchaseErrorNotification, object: "Unknown Purchase Error")
            }
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        NotificationCenter.default.post(name: .purchaseErrorNotification, object: error)
    }
    
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch (transaction.transactionState) {
            case .purchased:
                complete(transaction: transaction)
                break
            case .failed:
                fail(transaction: transaction)
                break
            case .restored:
                restore(transaction: transaction)
                break
            case .deferred:
                break
            case .purchasing:
                break
            @unknown default:
                NotificationCenter.default.post(name: .purchaseErrorNotification, object: "Unknown Purchase Error")
            }
        }
    }
    
    private func complete(transaction: SKPaymentTransaction) {
        LOG("Transaction Complete", level: .success)

        deliverPurchaseNotificationFor(identifier: transaction.payment.productIdentifier)
        SKPaymentQueue.default().finishTransaction(transaction)
    }

    private func restore(transaction: SKPaymentTransaction) {
        if let transactionError = transaction.error as NSError?,
           let localizedDescription = transaction.error?.localizedDescription,
           transactionError.code != SKError.paymentCancelled.rawValue {
            LOG("Transaction Error: \(localizedDescription)", level: .error)

            NotificationCenter.default.post(name: .purchaseErrorNotification, object: transactionError)
            return
        }
        
        LOG("Restoring... \(transaction.payment.productIdentifier)", level: .working)
        deliverPurchaseNotificationFor(identifier: transaction.payment.productIdentifier)
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func fail(transaction: SKPaymentTransaction) {
        if let transactionError = transaction.error as NSError?,
           let localizedDescription = transaction.error?.localizedDescription,
           transactionError.code != SKError.paymentCancelled.rawValue {
            LOG("Transaction Error: \(localizedDescription)", level: .error)

            NotificationCenter.default.post(name: .purchaseErrorNotification, object: transactionError)
        }
        
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func deliverPurchaseNotificationFor(identifier: String) {
        LOG("Purchased \(identifier)", level: .working)
        purchasedProductIdentifiers.insert(identifier)
        SharedDataStorageManager.defaults.set(true, forKey: identifier)
        NotificationCenter.default.post(name: .purchaseNotification, object: identifier)
    }
}

