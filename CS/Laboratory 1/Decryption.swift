//
//  Decryption.swift
//  CS
//
//  Created by Dragomir Mindrescu on 08.10.2024.
//

import Foundation

func Decryption() {
    
    print("Please enter a key (1-25) for decryption: ", terminator: "")
    guard let keyInput = readLine(), let key = Int(keyInput), key >= 1 && key <= 25 else {
        print("Invalid key. Key range is from 1 to 25.")
        return
    }
    
    print("Please enter the message to decrypt (only letters and spaces): ", terminator: "")
    guard let messageInput = readLine(), isValidMessage(messageInput) else {
        print("Invalid input. Don't you dare using symbols again here.")
        return
    }
    
    let message = messageInput.uppercased().replacingOccurrences(of: " ", with: "")
    
    let decryptedMessage = decryptMessage(message, withKey: key)
    
    print("Decrypted message: \(decryptedMessage)")
}

func decryptMessage(_ message: String, withKey key: Int) -> String {
    var decrypted = ""
    
    for character in message {
        if let index = upperCaseAlphabet.firstIndex(of: character) {
            let newIndex = upperCaseAlphabet.distance(from: upperCaseAlphabet.startIndex, to: index) - key
            let wrappedIndex = (newIndex + 26) % 26
            decrypted.append(upperCaseAlphabet[upperCaseAlphabet.index(upperCaseAlphabet.startIndex, offsetBy: wrappedIndex)])
        } else {
            decrypted.append(character)
        }
    }
    
    return decrypted
}
