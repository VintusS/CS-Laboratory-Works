//
//  Utils.swift
//  Laboratory 3
//
//  Created by Dragomir Mindrescu on 18.01.2025.
//

public extension String {
    subscript(i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }
}

protocol Cipher {
    var alphabet: String { get }
    var alphabetSize: Int { get }
    var key: String { get set }
    var keySize: Int { get }
    
    func encrypt(plainText: String) -> String
    func decrypt(encryptedText: String) -> String 
}
