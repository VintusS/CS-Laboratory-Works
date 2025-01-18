//
//  main.swift
//  Laboratory 3
//
//  Created by Dragomir Mindrescu on 18.01.2025.
//

class Vigenere: Cipher {
    let alphabet: String
    let alphabetSize: Int
    var key: String
    var keySize: Int
    
    init(alphabet: String = "AĂÂBCDEFGHIÎJKLMNOPQRSȘTȚUVWXYZ", key: String) {
        self.alphabet = alphabet.uppercased()
        self.alphabetSize = alphabet.count
        self.key = key.uppercased()
        self.keySize = key.count
    }
    
    func encrypt(plainText: String) -> String {
        var encryptedText = ""
        var index = 0
        
        for character in plainText.uppercased() {
            let indexInAlphabet = indexOfAlphabet(forCharacter: character)
            
            if indexInAlphabet == -1 {
                continue // Ignore invalid characters
            }
            
            let keyToEncryptWith = key[index % keySize]
            let keyIndexInAlphabet = indexOfAlphabet(forCharacter: keyToEncryptWith)
            let encryptedLetterIndex = (indexInAlphabet + keyIndexInAlphabet + alphabetSize) % alphabetSize
            encryptedText.append(alphabet[encryptedLetterIndex])
            index += 1
        }
        
        return encryptedText
    }
    
    func decrypt(encryptedText: String) -> String {
        var decryptedText = ""
        var index = 0
        
        for character in encryptedText.uppercased() {
            let indexInAlphabet = indexOfAlphabet(forCharacter: character)
            
            if indexInAlphabet == -1 {
                continue // Ignore invalid characters
            }
            
            let keyToEncryptWith = key[index % keySize]
            let keyIndexInAlphabet = indexOfAlphabet(forCharacter: keyToEncryptWith)
            let decryptedLetterIndex = (indexInAlphabet - keyIndexInAlphabet + alphabetSize) % alphabetSize
            decryptedText.append(alphabet[decryptedLetterIndex])
            index += 1
        }
        
        return decryptedText
    }
    
    private func indexOfAlphabet(forCharacter character: Character) -> Int {
        guard let index = alphabet.firstIndex(of: character) else {
            return -1
        }
        return alphabet.distance(from: alphabet.startIndex, to: index)
    }
}
