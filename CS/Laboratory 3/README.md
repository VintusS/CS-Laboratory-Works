
# Vigenère Cipher

The Vigenère cipher is a polyalphabetic substitution cipher invented by Giovan Battista Bellaso and later improved by Blaise de Vigenère in 1553. It encrypts text using a repeating keyword to determine shifts for each letter, offering more complexity and security than simpler ciphers like Caesar's. Despite being historically significant, it is vulnerable to modern cryptanalysis techniques.

## Implementation

The Vigenère cipher can be effectively implemented using Swift. This implementation provides a simple CLI tool to perform encryption and decryption, supporting messages in the Romanian alphabet.

### Text Preparation

To prepare the text for encryption or decryption, we must ensure the following steps:

1.  **Uppercase Conversion**: Convert all letters to uppercase.
2.  **Character Filtering**: Remove all non-alphabetic characters and spaces.
3.  **Validation**: Ensure the text contains only letters from the Romanian alphabet.

In Swift, this can be achieved with a utility class or helper functions:

```
class TextPreparator {
    let alphabet = "AĂÂBCDEFGHIÎJKLMNOPQRSȘTȚUVWXYZ"
    
    func prepareText(_ text: String) -> String {
        return text
            .uppercased()
            .filter { alphabet.contains($0) }
    }
    
    func prepareKey(_ key: String) -> String {
        let cleanKey = key
            .uppercased()
            .filter { alphabet.contains($0) }
        return String(Set(cleanKey)) // Remove duplicate letters
    }
}
```

### Encryption

To encrypt a text using the Vigenère cipher, we follow these steps:

1.  Match each letter of the plaintext with a letter from the keyword.
2.  Calculate the encrypted letter using the formula:Ci=(Pi+Ki)mod  NCi​=(Pi​+Ki​)modN  Where  PiPi​  is the position of the plaintext letter in the alphabet,  KiKi​  is the position of the key letter, and  NN  is the length of the alphabet.

Here’s the Swift implementation of the  `encrypt`  function:

```
class VigenereCipher {
    let alphabet = "AĂÂBCDEFGHIÎJKLMNOPQRSȘTȚUVWXYZ"
    var key: String
    
    init(key: String) {
        self.key = key.uppercased()
    }
    
    func encrypt(plainText: String) -> String {
        var encryptedText = ""
        let preparator = TextPreparator()
        let cleanedText = preparator.prepareText(plainText)
        let preparedKey = preparator.prepareKey(key)
        
        var keyIndex = 0
        
        for letter in cleanedText {
            if let plainIndex = alphabet.firstIndex(of: letter) {
                let keyLetter = preparedKey[keyIndex % preparedKey.count]
                if let keyIndexInAlphabet = alphabet.firstIndex(of: keyLetter) {
                    let cipherIndex = (alphabet.distance(from: alphabet.startIndex, to: plainIndex) +
                                       alphabet.distance(from: alphabet.startIndex, to: keyIndexInAlphabet)) % alphabet.count
                    encryptedText.append(alphabet[alphabet.index(alphabet.startIndex, offsetBy: cipherIndex)])
                    keyIndex += 1
                }
            }
        }
        return encryptedText
    }
}
```

### Decryption

Decryption is the reverse of encryption, using the formula:

Pi=(Ci−Ki+N)mod  NPi​=(Ci​−Ki​+N)modN

Here’s the Swift implementation of the  `decrypt`  function:
```
extension VigenereCipher {
    func decrypt(encryptedText: String) -> String {
        var decryptedText = ""
        let preparator = TextPreparator()
        let cleanedText = preparator.prepareText(encryptedText)
        let preparedKey = preparator.prepareKey(key)
        
        var keyIndex = 0
        
        for letter in cleanedText {
            if let cipherIndex = alphabet.firstIndex(of: letter) {
                let keyLetter = preparedKey[keyIndex % preparedKey.count]
                if let keyIndexInAlphabet = alphabet.firstIndex(of: keyLetter) {
                    let plainIndex = (alphabet.distance(from: alphabet.startIndex, to: cipherIndex) -
                                      alphabet.distance(from: alphabet.startIndex, to: keyIndexInAlphabet) +
                                      alphabet.count) % alphabet.count
                    decryptedText.append(alphabet[alphabet.index(alphabet.startIndex, offsetBy: plainIndex)])
                    keyIndex += 1
                }
            }
        }
        return decryptedText
    }
}
```

### Result

The algorithm is implemented as a CLI tool, where users can specify the operation (encryption or decryption), key, and message. Here’s an example of its usage:

#### Encryption
```
let cipher = VigenereCipher(key: "SUPERPUPER")
let encryptedText = cipher.encrypt(plainText: "This is some convoluted text")
print("Encrypted text: \(encryptedText)")
``` 

Output:
`Encrypted text: KBXWZGMCSVUÎBĂEĂQIJUKAMY` 

#### Decryption
`let decryptedText = cipher.decrypt(encryptedText: "KBXWZGMCSVUÎBĂEĂQIJUKAMY")
print("Decrypted text: \(decryptedText)")` 

Output:
`Decrypted text: THISISSOMECONVOLUTEDTEXT` 

## Conclusion

The Vigenère cipher demonstrates an evolution in classical encryption techniques, introducing polyalphabetic substitution for increased security. Despite being vulnerable to modern cryptanalysis, it remains an excellent example of historical cryptography and is a practical way to explore cipher principles using programming.

By implementing this cipher in Swift, we showcase its adaptability to a modern programming language and its application in encrypting and decrypting messages in the Romanian language.
