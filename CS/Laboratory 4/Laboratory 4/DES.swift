//
//  DES.swift
//  Laboratory 4
//
//  Created by Dragomir Mindrescu on 18.01.2025.
//

import Foundation
import CommonCrypto
import Security

// Extension for Symmetric Encryption and Decryption with DES, 3DES, AES algorithms
extension String {
    
    // Encrypts message with DES algorithm
    func desEncrypt(key:String) -> String? {
        
        return symetricEncrypt(key: key, blockSize: kCCBlockSizeDES, keyLength: size_t(kCCKeySizeDES), algorithm: UInt32(kCCAlgorithmDES))
    }
    
    // Encrypts a message with symmetric algorithm
    func symetricEncrypt(key:String, blockSize: Int, keyLength: size_t, algorithm: CCAlgorithm, options: Int = kCCOptionPKCS7Padding) -> String? {
        let keyData = key.data(using: String.Encoding.utf8)! as NSData
        let data = self.data(using: String.Encoding.utf8)! as NSData
        
        let cryptData = NSMutableData(length: Int(data.length) + blockSize)!

        let operation: CCOperation = UInt32(kCCEncrypt)

        var numBytesEncrypted :size_t = 0

        let cryptStatus = CCCrypt(operation,
                                  algorithm,
                                  UInt32(options),
                                  keyData.bytes, keyLength,
                                  nil,
                                  data.bytes, data.length,
                                  cryptData.mutableBytes, cryptData.length,
                                  &numBytesEncrypted)
        
        if UInt32(cryptStatus) == UInt32(kCCSuccess) {
            cryptData.length = Int(numBytesEncrypted)
            let base64cryptString = cryptData.base64EncodedString(options: .lineLength64Characters)
            return base64cryptString
        }
        else {
            return nil
        }
    }
    
    // Decrypts message with DES algorithm
    func desDecrypt(key:String) -> String? {
        
        return symetricDecrypt(key: key, blockSize: kCCBlockSizeDES, keyLength: size_t(kCCKeySizeDES), algorithm: UInt32(kCCAlgorithmDES))
    }

    // Decrypts a message with symmetric algorithm
    func symetricDecrypt(key:String, blockSize: Int, keyLength: size_t, algorithm: CCAlgorithm, options: Int = kCCOptionPKCS7Padding) -> String? {
        if let keyData = key.data(using: String.Encoding.utf8),
            let data = NSData(base64Encoded: self, options: .ignoreUnknownCharacters),
            let cryptData    = NSMutableData(length: Int((data.length)) + blockSize) {

            let operation: CCOperation = UInt32(kCCDecrypt)
            var numBytesEncrypted :size_t = 0

            let cryptStatus = CCCrypt(operation,
                                      algorithm,
                                      UInt32(options),
                                      (keyData as NSData).bytes, keyLength,
                                      nil,
                                      data.bytes, data.length,
                                      cryptData.mutableBytes, cryptData.length,
                                      &numBytesEncrypted)

            if UInt32(cryptStatus) == UInt32(kCCSuccess) {
                cryptData.length = Int(numBytesEncrypted)
                let unencryptedMessage = String(data: cryptData as Data, encoding:String.Encoding.utf8)
                return unencryptedMessage
            }
            else {
                return nil
            }
        }
        return nil
    }
}
