//
//  Decryption.swift
//  CS
//
//  Created by Dragomir Mindrescu on 08.10.2024.
//

import Foundation

// MARK: - Lite Mode Caesar
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

// MARK: - Hard Mode Caesar
func HardModeDecryption() {
    print("Enter the encrypted message:")
    guard let encryptedMessage = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) else {
        print("Invalid input.")
        return
    }

    print("Enter the permutation key (must contain only letters and at least 7 characters):")
    guard let permutationKey = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines), permutationKey.count >= 7,
          permutationKey.allSatisfy({ $0.isLetter }) else {
        print("Invalid permutation key.")
        return
    }
    
    print("Enter the Caesar key (1-25):")
    guard let caesarKeyInput = readLine(), let caesarKey = Int(caesarKeyInput), caesarKey >= 1, caesarKey <= 25 else {
        print("Invalid Caesar key.")
        return
    }

    var permutedAlphabet = [Character]()
    var seen = Set<Character>()

    for char in permutationKey.uppercased() {
        if char.isLetter && !seen.contains(char) {
            seen.insert(char)
            permutedAlphabet.append(char)
        }
    }

    for char in "ABCDEFGHIJKLMNOPQRSTUVWXYZ" {
        if !seen.contains(char) {
            permutedAlphabet.append(char)
        }
    }

    var decryptedMessage = ""

    for char in encryptedMessage.uppercased() {
        if let index = permutedAlphabet.firstIndex(of: char) {
            let newIndex = (index - caesarKey + 26) % 26
            decryptedMessage.append(permutedAlphabet[newIndex])
        }
    }

    print("Decrypted Message: \(decryptedMessage)")
}
