#!/bin/bash

PATH_TO_PKI="/Users/dragomirmindrescu/Desktop/University/CS/CS/Laboratory 5"

mkdir -p "$PATH_TO_PKI"

read -p "Press Enter to continue..."

echo "1. Generate a private key using RSA Algorithm with 4096 bits"
openssl genpkey -algorithm RSA -out "$PATH_TO_PKI/private_key.pem" -pkeyopt rsa_keygen_bits:4096

read -p "Press Enter to continue..."

echo "2. Generate X509 Certificate for CA"
openssl req -new -x509 -noenc -days 3650 -key "$PATH_TO_PKI/private_key.pem" -out "$PATH_TO_PKI/root_cert.pem"

read -p "Press Enter to continue..."

echo "3. Display the content of the certificate"
openssl x509 -in "$PATH_TO_PKI/root_cert.pem" -text -noout

read -p "Press Enter to continue..."

echo "4. Generate a Private Key for the User"
openssl genpkey -algorithm RSA -out "$PATH_TO_PKI/user_private_key.pem" -pkeyopt rsa_keygen_bits:2048

read -p "Press Enter to continue..."

echo "5. Generate a Certificate Signing Request for the User"
openssl req -new -key "$PATH_TO_PKI/user_private_key.pem" -out "$PATH_TO_PKI/user_cert_req.csr"

read -p "Press Enter to continue..."

echo "6. Sign the User Certificate Request"
openssl x509 -req -in "$PATH_TO_PKI/user_cert_req.csr" -CA "$PATH_TO_PKI/root_cert.pem" -CAkey "$PATH_TO_PKI/private_key.pem" -CAcreateserial -out "$PATH_TO_PKI/user_cert.crt" -days 365

read -p "Press Enter to continue..."

echo "7. Display the content of the certificate"
openssl x509 -in "$PATH_TO_PKI/user_cert.crt" -text -noout

read -p "Press Enter to continue..."

echo "8. Sign a text file with the User Private Key"
openssl dgst -sha256 -sign "$PATH_TO_PKI/user_private_key.pem" -out "$PATH_TO_PKI/signature.txt" "$PATH_TO_PKI/user_text.txt"

read -p "Press Enter to continue..."

echo "9. Verify the signature"

echo "9.1 Extract public key from the certificate"
openssl x509 -in "$PATH_TO_PKI/user_cert.crt" -pubkey -noout > "$PATH_TO_PKI/public_key.pem"

echo "9.2 Verify the signature"
openssl dgst -sha256 -verify "$PATH_TO_PKI/public_key.pem" -signature "$PATH_TO_PKI/signature.txt" "$PATH_TO_PKI/user_text.txt"

read -p "Press Enter to continue..."

echo "10. Modify the text file"
echo "This is a modified text file" > "$PATH_TO_PKI/user_text.txt"

read -p "Press Enter to continue..."

echo "11. Verify the signature again"
openssl dgst -sha256 -verify "$PATH_TO_PKI/public_key.pem" -signature "$PATH_TO_PKI/signature.txt" "$PATH_TO_PKI/user_text.txt"

read -p "Press Enter to finish..."
rm private_key.pem
rm root_cert.pem
rm user_private_key.pem
rm user_cert_req.csr
rm user_cert.crt
rm root_cert.srl
rm public_key.pem
rm signature.txt
clear