# Caesar\'s cipher

### Course: Security and Cryptography

### Author: Mindrescu Dragomir

----
## Introduction:

This project implements a Caesar cipher with an additional permutation layer to enhance encryption strength. The Caesar cipher is a simple encryption technique where each letter in the plaintext is shifted by a fixed number of positions down the alphabet. By introducing a permutation key, we further complicate the decryption process, making it more resistant to brute-force attacks.

##  Task 1.1.1: Caesar Cipher Encryption

### Overview

The Caesar cipher is a substitution cipher where each letter in the plaintext is replaced by a letter a fixed number of positions down the alphabet.

### Key Steps

1. **Input Handling**:
    -Prompt for the Caesar key (a number between 1 and 25).
    -Prompt for the plaintext message.
2. **Encrypting the Message**:
    -Remove spaces from the message and convert all letters to uppercase.
    -For each character in the message, find its position in the standard alphabet, apply the Caesar shift, and replace it with the corresponding character in the permuted alphabet.

##  Code Snippet
                                                                                
Here's a simplified version of the encryption process:
                        
```swift
// Example function structure for HardModeEncryption
func Encryption() {
    // Input handling for permutation key and Caesar key
    // Validate keys and message
    // Encrypt the message using the new alphabet and Caesar key
}
```

### Example
                
```bash
Enter the key (1-25): 5
Enter the message to encrypt (only letters and spaces): random
Encrypted message: WFSITR
```

## Task 1.1.2: Caesar Cipher Decryption

The Caesar cipher is a substitution cipher where each letter in the ciphertext is replaced by a letter a fixed number of positions up the alphabet. This method is the reverse of the encryption process.

### Key Steps

1. **Input Handling**:
   - Prompt for the Caesar key (a number between 1 and 25).
   - Prompt for the ciphertext message.

2. **Decrypting the Message**:
   - Remove spaces from the ciphertext and convert all letters to uppercase.
   - For each character in the ciphertext, find its position in the standard alphabet, apply the inverse Caesar shift, and replace it with the corresponding character in the standard alphabet.

### Code Snippet

Here's a simplified version of the decryption process:

```swift
// Example function structure for HardModeDecryption
func HardModeDecryption() {
    // Input handling for Caesar key
    // Validate keys and message
    // Decrypt the message using the standard alphabet and Caesar key
}
```

```bash
Enter the key (1-25): 5
Enter the message to decrypt (only letters and spaces): WFSITR
Decrypted message: RANDOM
```


## Task 1.2.1: Caesar Cipher Encryption with Permutation

The Hard Mode Caesar cipher enhances the traditional Caesar cipher by using a permutation of the alphabet based on a provided keyword. Each letter in the plaintext is replaced by a letter a fixed number of positions down the permuted alphabet.

### Key Steps

1. **Input Handling**:
   - Prompt for the permutation key (at least 7 unique alphabetical letters).
   - Prompt for the Caesar key (a number between 1 and 25).
   - Prompt for the plaintext message.

2. **Creating the Permuted Alphabet**:
   - Construct a new alphabet by starting with the characters from the permutation key and then appending the remaining letters of the standard alphabet (A-Z) that do not appear in the key.

3. **Encrypting the Message**:
   - Remove spaces from the message and convert all letters to uppercase.
   - For each character in the message, find its position in the standard alphabet, apply the Caesar shift, and replace it with the corresponding character in the permuted alphabet.

### Code Snippet

Here's a simplified version of the encryption process:

```swift
// Example function structure for HardModeEncryption
func HardModeEncryption() {
    // Input handling for permutation key and Caesar key
    // Validate keys and message
    // Construct the permuted alphabet
    // Encrypt the message using the new alphabet and Caesar key
}
```

```bash
Enter the permutation key (at least 7 unique letters): caesarr
Enter the key (1-25): 5
Enter the message to encrypt (only letters and spaces): Boby
Encrypted message: IVIS

```

## Task 1.2.2: Caesar Cipher Decryption with Permutation

The Hard Mode Caesar cipher decryption reverses the encryption process by replacing each letter in the ciphertext with a letter a fixed number of positions up the permuted alphabet.

### Key Steps

1. **Input Handling**:
   - Prompt for the permutation key (the same key used for encryption).
   - Prompt for the Caesar key (a number between 1 and 25).
   - Prompt for the ciphertext message.

2. **Creating the Permuted Alphabet**:
   - Use the same permutation key to construct the permuted alphabet as in the encryption process.

3. **Decrypting the Message**:
   - Remove spaces from the ciphertext and convert all letters to uppercase.
   - For each character in the ciphertext, find its position in the permuted alphabet, apply the inverse Caesar shift, and replace it with the corresponding character in the standard alphabet.

### Code Snippet

Here's a simplified version of the decryption process:

```swift
// Example function structure for HardModeDecryption
func HardModeDecryption() {
    // Input handling for permutation key and Caesar key
    // Validate keys and message
    // Construct the permuted alphabet
    // Decrypt the message using the permuted alphabet and Caesar key
}
```

```bash
Enter the permutation key (same as used for encryption): caesarr
Enter the key (1-25): 5
Enter the message to decrypt (only letters and spaces): WFSITR
Decrypted message: RANDOM
```

### Conclusion
                                                                            
This project successfully implements the Caesar cipher with a permutation layer, demonstrating a more complex encryption method. Both encryption and decryption functions allow for user input and handle various edge cases, ensuring robustness.

