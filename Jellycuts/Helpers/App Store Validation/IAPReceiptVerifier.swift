//
//  Copyright 2016 Lionheart Software LLC
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
import UIKit
import HydrogenReporter

public typealias Receipt = [String: Any]

public enum VerificationResult: LocalizedError, Comparable {
    case unauthorized
    case error(status: Int)
    case incompleteReceipt
    case invalidSettings
    case validReceipt
    
    public var errorDescription: String? {
        switch self {
        case .unauthorized:
            return "The receipt was not valid. Please try again."
        case .error(let status):
            return "There was an error connecting to the App Store.\nError #\(status)"
        case .incompleteReceipt:
            return "The request for a receipt was not completed. Please try again."
        case .invalidSettings:
            return "The settings for verification are not valid."
        case .validReceipt:
            return "This is a valid receipt."
        }
    }
}
public struct IAPReceiptVerifier {
    var key: SecKey?
    var url: URL
    
    public init(url: URL) {
        self.url = url
    }
    
    public init?(url: URL, base64EncodedPublicKey string: String) {
        guard let keyData = Data(base64Encoded: string) else {
            return nil
        }
        
        let options: [String: Any] = [
            kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
            kSecAttrKeyClass as String: kSecAttrKeyClassPublic,
            kSecAttrKeySizeInBits as String: 2048
        ]
        
        var error: Unmanaged<CFError>?
        guard let key = SecKeyCreateWithData(keyData as CFData, options as CFDictionary, &error) else {
            return nil
        }
        
        self.key = key
        self.url = url
    }
    
    public func verify(completion: @escaping (Receipt?) -> ()) {
        guard let receiptURL = Bundle.main.appStoreReceiptURL,
              let receiptData = try? Data(contentsOf: receiptURL, options: .alwaysMapped) else {
            completion(nil)
            return
        }
        
        let encodedString = receiptData.base64EncodedString(options: [])
        let json = ["data":encodedString]
        let jsonData = try? JSONEncoder().encode(json)

        var request = URLRequest(url: url)
        request.httpBody = jsonData
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let algorithm = SecKeyAlgorithm.rsaSignatureMessagePKCS1v15SHA256
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            var error: Unmanaged<CFError>?
            
            guard let data = data,
                  let HTTPResponse = response as? HTTPURLResponse,
                  let object = try? JSONSerialization.jsonObject(with: data, options: []),
                  let json = object as? [String: Any] else {
                completion(nil)
                return
            }
            
            if let key = self.key,
               let signatureString = HTTPResponse.allHeaderFields["X-Signature"] as? String,
               let signature = Data(base64Encoded: signatureString) {
                let verified = SecKeyVerifySignature(key, algorithm, data as CFData, signature as CFData, &error)
                if !verified {
                    LOG("Failed To Verify Signature - \(error.debugDescription)", level: .error)
                }
            }
            
            completion(json)
        }
        task.resume()
    }
    
    public func verify() async throws -> Receipt {
        return try await withCheckedThrowingContinuation { continuation in
            verify { receipt in
                guard let receipt else {
                    continuation.resume(throwing: VerificationResult.incompleteReceipt)
                    return
                }
                continuation.resume(returning: receipt)
            }
        }
    }
}

