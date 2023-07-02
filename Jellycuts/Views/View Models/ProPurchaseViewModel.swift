//
//  ProPurchaseViewModel.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/9/23.
//

import SwiftUI
import StoreKit

@MainActor
class ProPurchaseViewModel: ObservableObject {
    @Published var products: [SKProduct] = []
    @Published var selectedPurchase: PurchaseHandler.JellycutsProduct = PurchaseHandler.JellycutsProduct.Tier2_Pro
    
    @Published var errorMessage: String = ""
    @Published var presentErrorView: Bool = false
    
    @Published var confettiCounter: Int = 0
    @Published var isPurchasing: Bool = false

    init() {
        PurchaseHandler.shared.requestProducts { success, products in
            if success {
                if let products {
                    DispatchQueue.main.async {
                        self.products = products.filter({self.productFilter($0)}).sorted(by: {self.productSort($0, $1)})
                    }
                } else {
                    self.errorMessage = "No Products Were Found"
                    self.presentErrorView = true
                }
            } else {
                self.errorMessage = "An Error Occurred While Loading Products"
                self.presentErrorView = true
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(observePayment), name: .purchaseNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(paymentError), name: .purchaseErrorNotification, object: nil)
    }
    
    func productSort(_ lhs: SKProduct, _ rhs: SKProduct) -> Bool {
        return Double(truncating: lhs.price) < Double(truncating: rhs.price)
    }
    
    func productFilter(_ product: SKProduct) -> Bool {
        return PurchaseHandler.JellycutsProduct.pro.contains { prod in
            return prod.rawValue == product.productIdentifier
        }
    }

    func restorePurchases() {
        isPurchasing = true
        PurchaseHandler.shared.restorePurchases()
    }
    
    func purchaseSelectedItem() {
        isPurchasing = true
        if let product = products.first(where: { product in
            return product.productIdentifier == selectedPurchase.rawValue
        }) {
            PurchaseHandler.shared.buyProduct(product)
        } else {
            self.errorMessage = "Unable to find the selected purchase option"
            self.presentErrorView = true
            self.isPurchasing = false
        }
    }
}

extension ProPurchaseViewModel {
    @objc func paymentError(notif: NSNotification) {
        if let error = notif.object as? NSError {
            if error.code == SKError.paymentCancelled.rawValue {
                self.isPurchasing = false
                return
            }
            self.errorMessage = "Transaction Error: \(error.localizedDescription)"
        } else {
            self.errorMessage = "An unknown error has occurred. Please try again."
        }

        self.presentErrorView = true
        self.isPurchasing = false
    }
    
    @objc func observePayment(notif: NSNotification) {
        if let id = notif.object as? String {
            Task {
                do {
                    let result = try await PurchaseHandler.verifyIAP(purchasedID: id)
                    if result == .validReceipt {
                        PurchaseHandler.isProMode = true
                        self.isPurchasing = false
                        self.confettiCounter += 1
                        NotificationCenter.default.post(Notification(name: .finishedPurchasing))
                    } else {
                        self.errorMessage = "Invalid Receipt Detected. Please make sure you have purchased a tip, if you are jailbroken please disable tweaks and restore purchases."
                        
                        self.presentErrorView = true
                        self.isPurchasing = false
                    }
                } catch {
                    self.errorMessage = error.localizedDescription
                    self.presentErrorView = true
                    self.isPurchasing = false
                }

            }
        } else {
            self.errorMessage = "Unable to find the purchase. Please try again."
            self.presentErrorView = true
            self.isPurchasing = false
        }
        self.isPurchasing = false
    }
}
