import argparse
from decryptor.Decryptor import Decryptor
from encryptor.Encryptor import Encryptor


def main():

    parser = argparse.ArgumentParser(
        description="Encrypt or Decrypt a message using the Playfair cipher.")

    parser.add_argument('-e', '--encrypt',
                        action='store_true', help="Encrypt the text")
    parser.add_argument('-d', '--decrypt',
                        action='store_true', help="Decrypt the text")
    parser.add_argument('-l', '--language_code', required=True,
                        help="Language code for the alphabet (e.g., 'en' for English, 'ro' for Romanian)")
    parser.add_argument('-k', '--key', required=True, help="Encryption key")
    parser.add_argument('-t', '--text', required=True,
                        help="Text to encrypt or decrypt")

    args = parser.parse_args()

    encryptor = Encryptor()
    decryptor = Decryptor()

    if args.encrypt:

        encrypted_text = encryptor.encrypt(
            text=args.text, key=args.key, language_code=args.language_code)
        print(f"Encrypted text: {encrypted_text}")

    elif args.decrypt:

        decrypted_text = decryptor.decrypt(
            text=args.text, key=args.key, language_code=args.language_code)
        print(f"Decrypted text: {decrypted_text}")

    else:
        print("You must specify either -e for encryption or -d for decryption.")


if __name__ == "__main__":
    main()
