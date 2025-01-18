
### **Laboratory Work Report**

**Subject:**  Cryptography and Security  
**Laboratory Title:**  DES Block Encryption and Hexadecimal Representation  
**Objective:**  
The goal of this laboratory work is to encrypt a specific block of a message using the DES algorithm, based on a provided key, and represent the encrypted block in hexadecimal format.

----------

### **Introduction**

The  **Data Encryption Standard (DES)**  is a symmetric key algorithm that encrypts data in 64-bit (8-byte) blocks. It is a block cipher that transforms plaintext into ciphertext using a secret key. This laboratory focuses on encrypting a single block from a message using DES in Swift.

Key aspects of this task include:

1.  Splitting the message into blocks.
2.  Encrypting the specified block using DES.
3.  Converting the encrypted output into hexadecimal format for better representation.

----------

### **Steps**

#### 1.  **Message Splitting into Blocks**

Since DES encrypts data in fixed-sized blocks of 8 bytes, the first step involves dividing the input message into these fixed-sized blocks. If the input message is not a multiple of 8 bytes, it is padded accordingly.

**Code Example:**
```
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
``` 

**Output Example:**  For the input message:
`"The Data Encryption Standard"` 

The blocks would be:
`Block 1: "The Data"
Block 2: " Encrypt"
Block 3: "ion Stan"` 

----------

#### 2.  **Encrypting the Block**

Using the  **`desEncrypt`**  method provided in the Swift extension, the selected block is encrypted. DES uses the provided key to scramble the data securely.

**Code Example:**
```
func encryptBlockWithDES(message: String, blockIndex: Int, key: String) -> String? {
    let blockSize = 8 // DES operates on 64-bit (8-byte) blocks
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
``` 

**Example Execution:**  If the block is  `" Encrypt"`  and the key is  `"12345678"`, the encrypted output might be:
`Base64 Encrypted Block: QzFzP0Ae2qw=` 

----------

#### 3.  **Convert Encrypted Data to Hexadecimal**

Encrypted data is often represented in hexadecimal format. This step converts the Base64 result into a hexadecimal string.

**Code Example:**

`func base64ToHex(base64String: String) -> String? {
    guard let data = Data(base64Encoded: base64String) else { return nil }
    return data.map { String(format: "%02x", $0) }.joined()
}` 

**Example Execution:**  The Base64 string  `"QzFzP0Ae2qw="`  is converted to:

`Hexadecimal: 4331733f401edaac` 

----------

### **Results**

The program prints the results of the encryption process:

1.  **Original Message:**  The input message.
2.  **Key:**  The secret key used for DES encryption.
3.  **Block Index:**  The block number that was encrypted.
4.  **Base64 Encrypted Block:**  The encrypted output in Base64 format.
5.  **Hexadecimal Encrypted Block:**  The encrypted output in hexadecimal format.

**Example Output:**

`Original Message: The Data Encryption Standard
Key: 12345678
Block Index: 1
Encrypted Block in Base64: QzFzP0Ae2qw=
Encrypted Block in Hexadecimal: 4331733f401edaac` 

----------

### **Conclusion**

This laboratory demonstrated how to:

1.  Split a plaintext message into 8-byte blocks for DES encryption.
2.  Encrypt a specific block using a secret key.
3.  Represent the encrypted data in hexadecimal format.

DES encryption is an essential part of understanding cryptography and data security. The Swift implementation highlights the practical application of DES and how cryptographic principles can be applied programmatically.
