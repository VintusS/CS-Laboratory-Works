# Laboratory Report: Block Ciphers - DES Algorithm

### Elaborated: Mindrescu Dragomir, FAF-221,
### Checked: asist.univ. Dumitru Nirca,

## Task Description

Create an internal PKI using the OpenSSL tool. The following steps are required:
1. Generate the root private key.
2. Initialize a Certificate Authority (CA).
3. Create a self-signed certificate for the CA.
4. Issue and revoke private keys for users.
5. Generate digital signatures that users/entities can use to sign and verify documents/files.

The use of any programming or scripting language is allowed, including Bash, PowerShell, zsh, etc.

---

## Theoretical Notes

Creating self-signed certificates and keys with OpenSSL is a common task for secure communication, especially in development or testing environments where a trusted Certificate Authority (CA) is not necessary. OpenSSL is a widely-used open-source toolkit for working with SSL/TLS protocols.

### Steps to Create Self-Signed Certificates:
1. **Install OpenSSL**: Ensure OpenSSL is installed on your system. You can download it from the [official OpenSSL website](https://www.openssl.org) or use your operating system's package manager.
2. **Generate a Private Key**: Use the OpenSSL command to generate a private key.
3. **Create a Certificate Signing Request (CSR)**: Generate a CSR using the private key.
4. **Sign the CSR**: Use the CA's private key to sign the CSR, producing a certificate for the user.

---

## Implementation

The implementation is automated using a Bash script, which performs the following tasks:

### Bash Script for PKI Creation and Signature Verification

\`\`\`bash
#!/bin/bash

PATH_TO_PKI="/path/to/your/directory"

mkdir -p "$PATH_TO_PKI"

# 1. Generate a private key using RSA Algorithm with 4096 bits
openssl genpkey -algorithm RSA -out "$PATH_TO_PKI/private_key.pem" -pkeyopt rsa_keygen_bits:4096

# 2. Generate an X.509 Certificate for the CA
openssl req -new -x509 -days 3650 -key "$PATH_TO_PKI/private_key.pem" -out "$PATH_TO_PKI/root_cert.pem"

# 3. Generate a Private Key for the User
openssl genpkey -algorithm RSA -out "$PATH_TO_PKI/user_private_key.pem" -pkeyopt rsa_keygen_bits:2048

# 4. Create a Certificate Signing Request (CSR) for the User
openssl req -new -key "$PATH_TO_PKI/user_private_key.pem" -out "$PATH_TO_PKI/user_cert_req.csr"

# 5. Sign the User's CSR with the CA's Private Key
openssl x509 -req -in "$PATH_TO_PKI/user_cert_req.csr" -CA "$PATH_TO_PKI/root_cert.pem" -CAkey "$PATH_TO_PKI/private_key.pem" -CAcreateserial -out "$PATH_TO_PKI/user_cert.crt" -days 365

# 6. Sign a text file with the User's Private Key
openssl dgst -sha256 -sign "$PATH_TO_PKI/user_private_key.pem" -out "$PATH_TO_PKI/signature.txt" "$PATH_TO_PKI/user_text.txt"

# 7. Extract the Public Key from the Certificate
openssl x509 -in "$PATH_TO_PKI/user_cert.crt" -pubkey -noout > "$PATH_TO_PKI/public_key.pem"

# 8. Verify the Signature
openssl dgst -sha256 -verify "$PATH_TO_PKI/public_key.pem" -signature "$PATH_TO_PKI/signature.txt" "$PATH_TO_PKI/user_text.txt"
\`\`\`

---

## Observations and Results

1. The script generates a private key and a self-signed certificate for the CA.
2. The user certificate is signed by the CA.
3. A text file is signed using the user's private key, and the signature is verified using the corresponding public key.
4. Any modification to the signed file results in a failed verification, ensuring the file's integrity.

---

## Conclusion

This laboratory work demonstrates the implementation of a PKI system using OpenSSL. The script automates the creation of private keys, certificates, and digital signatures, providing a practical approach to understanding cryptography and security concepts.