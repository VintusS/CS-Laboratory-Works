//
//  main.swift
//  Laboratory 4
//
//  Created by Dragomir Mindrescu on 18.01.2025.
//

import Foundation

func splitMessageIntoBlocks(_ message: String, blockSize: Int) -> [String] {
    var blocks: [String] = []
    let messageData = message.data(using: .utf8)!
    let blockCount = Int(ceil(Double(messageData.count) / Double(blockSize)))
    for i in 0..<blockCount {
        let startIndex = i * blockSize
        let endIndex = min(startIndex + blockSize, messageData.count)
        let blockData = messageData.subdata(in: startIndex..<endIndex)
        if let blockString = String(data: blockData, encoding: .utf8) {
            blocks.append(blockString)
        }
    }
    return blocks
}

func encryptBlockWithDES(message: String, blockIndex: Int, key: String) -> String? {
    let blockSize = 8
    let blocks = splitMessageIntoBlocks(message, blockSize: blockSize)

    guard blockIndex < blocks.count else {
        print("Block index out of range.")
        return nil
    }
    
    let blockToEncrypt = blocks[blockIndex]
    if let encryptedBlock = blockToEncrypt.desEncrypt(key: key) {
        return encryptedBlock
    } else {
        print("Failed to encrypt the block.")
        return nil
    }
}

func base64ToHex(base64String: String) -> String? {
    guard let data = Data(base64Encoded: base64String) else { return nil }
    return data.map { String(format: "%02x", $0) }.joined()
}

func performDESEncryption(message: String, blockIndex: Int, key: String) {
    print("Original Message: \(message)")
    print("Key: \(key)")
    print("Block Index: \(blockIndex)")

    if let encryptedBase64 = encryptBlockWithDES(message: message, blockIndex: blockIndex, key: key),
       let encryptedHex = base64ToHex(base64String: encryptedBase64) {
        print("Encrypted Block in Base64: \(encryptedBase64)")
        print("Encrypted Block in Hexadecimal: \(encryptedHex)")
    } else {
        print("Encryption failed.")
    }
}

let message = """
The Data Encryption Standard (DES) specifies two FIPS approved cryptographic algorithms as required by FIPS 140-1. When used in conjunction with American National Standards Institute (ANSI) X9.52 standard, this publication provides a complete description of the mathematical algorithms for encrypting (enciphering) and decrypting (deciphering) binary coded information. Encrypting data converts it to an unintelligible form called cipher. Decrypting cipher converts the data back to its original form called plaintext. The algorithms described in this standard specifies both enciphering and deciphering operations which are based on a binary number called a key.
"""
let blockIndex = 1
let key = "12345678"


performDESEncryption(message: message, blockIndex: blockIndex, key: key)


