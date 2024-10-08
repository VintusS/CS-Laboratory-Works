//
//  Encryption.swift
//  CS
//
//  Created by Dragomir Mindrescu on 08.10.2024.
//

import Foundation

// MARK: - Lite Mode Caesar
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

// MARK: - Hard Mode Caesar
func HardModeEncryption() {
    print("Enter permutation key (at least 7 letters): ", terminator: "")
    let permutationKey = readLine() ?? ""
    
    guard isValidPermutationKey(permutationKey) else {
        print("Invalid permutation key. Please ensure it has at least 7 letters and contains only alphabetic characters.")
        return
    }
    
    print("Enter Caesar key (1-25): ", terminator: "")
    let caesarKeyInput = readLine() ?? ""
    guard let caesarKey = Int(caesarKeyInput), caesarKey >= 1, caesarKey <= 25 else {
        print("Invalid Caesar key. Please enter a number between 1 and 25.")
        return
    }

    print("Enter message to encrypt (only letters and spaces): ", terminator: "")
    let messageInput = readLine() ?? ""

    let permutedAlphabet = createPermutedAlphabet(from: permutationKey)
    var encrypted = ""

    for character in messageInput.uppercased() {
        if let index = permutedAlphabet.firstIndex(of: character) {
            let currentIndex = permutedAlphabet.distance(from: permutedAlphabet.startIndex, to: index)
            let newIndex = (currentIndex + caesarKey) % 26
            let newCharacter = permutedAlphabet[permutedAlphabet.index(permutedAlphabet.startIndex, offsetBy: newIndex)]
            encrypted.append(newCharacter)
        } else if character == " " {
            encrypted.append(" ")
        }
    }

    print("Encrypted Message: \(encrypted)")
}
