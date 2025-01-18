//
//  Laboratory_3_main.swift
//  Laboratory 3
//
//  Created by Dragomir Mindrescu on 18.01.2025.
//

func Laboratory3() {
    let alphabet = "AĂÂBCDEFGHIÎJKLMNOPQRSȘTȚUVWXYZ"
    
    print("Enter the operation (encrypt/decrypt):")
    guard let operation = readLine(), ["encrypt", "decrypt"].contains(operation.lowercased()) else {
        print("Invalid operation! Choose between 'encrypt' or 'decrypt'.")
        return
    }

    print("Enter the key (minimum 7 characters):")
    guard let key = readLine(), key.count >= 7 else {
        print("The key must have at least 7 characters.")
        return
    }

    print("Enter the message:")
    guard let inputText = readLine() else {
        print("Invalid message.")
        return
    }

    // Clean input
    let cleanedText = inputText.filter { $0 != " " }.uppercased()
    if !cleanedText.allSatisfy({ alphabet.contains($0) }) {
        print("The message contains invalid characters. Only letters from the Romanian alphabet are allowed.")
        return
    }

    let vigenere = Vigenere(alphabet: alphabet, key: key)

    if operation.lowercased() == "encrypt" {
        let encryptedText = vigenere.encrypt(plainText: cleanedText)
        print("Encrypted text: \(encryptedText)")
    } else if operation.lowercased() == "decrypt" {
        let decryptedText = vigenere.decrypt(encryptedText: cleanedText)
        print("Decrypted message: \(decryptedText)")
    }
}

Laboratory3()
