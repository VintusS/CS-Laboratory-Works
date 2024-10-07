//
//  Encryption.swift
//  CS
//
//  Created by Dragomir Mindrescu on 08.10.2024.
//

import Foundation

func Encryption() {
    print("Enter the key (1-25): ", terminator: "")
    guard let keyInput = readLine(), let key = Int(keyInput), key >= 1 && key <= 25 else {
        print("Invalid key. Key range is from 1 to 25.")
        return
    }

    print("Enter the message to encrypt (only letters and spaces): ", terminator: "")
    guard let messageInput = readLine(), isValidMessage(messageInput) else {
        print("Invalid input. Don't use symbols.")
        return
    }
    
    let message = messageInput.uppercased().replacingOccurrences(of: " ", with: "")
    
    let encryptedMessage = encryptMessage(message, withKey: key)
    
    print("Encrypted message: \(encryptedMessage)")
}

func encryptMessage(_ message: String, withKey key: Int) -> String {
    var encrypted = ""
    
    for character in message {
        if let index = upperCaseAlphabet.firstIndex(of: character) {
            let newIndex = upperCaseAlphabet.distance(from: upperCaseAlphabet.startIndex, to: index) + key
            let wrappedIndex = newIndex % 26
            encrypted.append(upperCaseAlphabet[upperCaseAlphabet.index(upperCaseAlphabet.startIndex, offsetBy: wrappedIndex)])
        } else {
            encrypted.append(character)
        }
    }
    
    return encrypted
}
