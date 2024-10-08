# Caesar\'s cipher

### Course: Security and Cryptography

### Author: Mindrescu Dragomir

----
## Introduction:

This project implements a Caesar cipher with an additional permutation layer to enhance encryption strength. The Caesar cipher is a simple encryption technique where each letter in the plaintext is shifted by a fixed number of positions down the alphabet. By introducing a permutation key, we further complicate the decryption process, making it more resistant to brute-force attacks.

##  Task 1.1:

### Overview

The encryption process involves two keys:

1. Caesar Key (k1): A number between 1 and 25 that determines the shift for the Caesar cipher.
2. Permutation Key (k2): A string of at least 7 unique alphabetical characters used to create a new order of the alphabet.

##  Implementation
                                                                                
The encryption function, HardModeEncryption, combines both keys to encrypt a given plaintext message. The steps are as follows:

1. Input Handling: The user is prompted to enter the plaintext message, permutation key, and Caesar key.
2. Creating the Permuted Alphabet: The function generates a new alphabet based on the permutation key, placing its characters first, followed by the remaining letters of the alphabet.
3. Encrypting the Message: Each letter of the plaintext is shifted according to the Caesar key using the permuted alphabet.

### Usage
                                                                                
```swift
func HardModeEncryption() {
    // Input handling and encryption logic here
}
```

Call the function, and follow the prompts to enter the necessary data for encryption.

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

## References
1. COJUHARI Irina, Duca Ludmila, Fiodorv Ion. "Formal Languages and Finite Automata: Guide for practical lessons". Technical University of Moldova
