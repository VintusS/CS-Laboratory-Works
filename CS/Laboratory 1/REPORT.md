# Caesar\'s cipher

### Course: Security and Cryptography

### Author: Mindrescu Dragomir

----
## Introduction:

This project implements a Caesar cipher with an additional permutation layer to enhance encryption strength. The Caesar cipher is a simple encryption technique where each letter in the plaintext is shifted by a fixed number of positions down the alphabet. By introducing a permutation key, we further complicate the decryption process, making it more resistant to brute-force attacks.

##  Task 1.1:

### Overview

The Caesar cipher is a substitution cipher where each letter in the plaintext is replaced by a letter a fixed number of positions down the alphabet. To enhance its security, this implementation combines the Caesar cipher with a permutation of the alphabet based on a provided keyword.

### Key Steps

1. Input Handling:
    -Prompt for the Caesar key (a number between 1 and 25).
    -Prompt for the plaintext message.
2. Encrypting the Message:
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

##  Task 1.2:

### Overview

The decryption process reverses the encryption, using the same permutation and Caesar keys. The function HardModeDecryption takes no parameters and handles all inputs internally.

##  Implementation
                                                                                
The decryption function follows similar steps as the encryption process:

1. Input Handling: The user is prompted to enter the encrypted message, permutation key, and Caesar key.
2. Creating the Permuted Alphabet: It generates the permuted alphabet using the same method as in the encryption function.
3. Decrypting the Message: Each letter of the encrypted message is shifted back according to the Caesar key.

### Usage
                                                                                
```swift
func HardModeDecryption() {
    // Input handling and encryption logic here
}
```

Call the function, and follow the prompts to enter the necessary data for decryption.
                                                                            
### Conclusion
                                                                            
This project successfully implements the Caesar cipher with a permutation layer, demonstrating a more complex encryption method. Both encryption and decryption functions allow for user input and handle various edge cases, ensuring robustness.

