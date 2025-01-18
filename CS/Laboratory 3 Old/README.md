# Playfair Cipher
The Playfair cipher is a digraph substitution cipher invented by Charles Wheatstone and popularized by Sir Albert F. W. Playfair in 1854. 
It encrypts pairs of letters using a 5x5 matrix generated from a keyword, offering more security than simpler ciphers like the Caesar cipher. 
The matrix is constructed with the alphabet (usually omitting one letter, often 'J'), and encryption depends on the position of the letter pairs within the matrix. 
Despite its historical use, the Playfair cipher is vulnerable to modern cryptanalysis techniques.

## Implementation
It is easy to implement the Playfair Cipher using Python. 
This implementation provides a CLI tool to allow encryption and decryption with different languages.

### Text preparation
To implement text preparation, we can use a utility class, named `Preparator`
```python
class Preparator:
    def __init__(self):
        self.filler_letters = ['X', 'Y', 'Z', 'W', 'Q']

    def _uppercase(self, text):
        return text.upper()

    def _substitute(self, text):
        return text.replace('J', 'I')

    def _clean(self, text):
        return ''.join([c for c in text if c.isalpha()])
```
First, the text is transformed to uppercase and cleaned of all punctuation and spaces. It then replaces all 'J' letters with 'I' letters.
Then it has to be split into combinations of 2 letters. It has to avoid cases when there are combinations that have the same 2 letters, and for that it will split that combination and add some less often encountered letters of the alphabet between them.

```python
    def _separate_digraphs(self, text):
            digraphs = self._split(text)
            return digraphs

    def _split(self, text):
        digraphs = []
        text = self._substitute(text)
        text = self._uppercase(text)

        i = 0
        while i < len(text):
            if i + 1 < len(text) and text[i] == text[i + 1]:
                filler = random.choice(self.filler_letters)
                digraphs.append(text[i] + filler)
                i += 1
            else:
                digraphs.append(text[i:i+2])
                i += 2

        if len(digraphs[-1]) == 1:
            filler = random.choice(self.filler_letters)
            digraphs[-1] += filler

        return digraphs
```
Then we can have a public method for text preparation:
```python
    def prepare_text(self, text):
        text = self._uppercase(text)
        text = self._clean(text)
        text = self._substitute(text)
        text = self._separate_digraphs(text)
        return text
```
And also in the same class have logic for the key preparation, which should also transformed to uppercase, cleaned of punctuation and remove all duplicated characters.
```python
    def _remove_duplicate_chars(self, text):
        result = ""
        for i in range(len(text)):
            if text[i] not in result:
                result += text[i]
        return result

    def prepare_key(self, key):
        key = self._uppercase(key)
        key = self._clean(key)
        key = self._remove_duplicate_chars(key)
        return key
```
### Encryption
To encrypt a text using the Playfair cipher, we have to follow the rules for each combination of 2 letters:
We will use this matrix for the example
```
F I R S T
A M E N D
B C G H K
L O P Q U
V W X Y Z
```
1. **Different row and column**
If the letters are in different columns and rows, each letter will be replaced with the letter on the same row, but of the column of the other. The pair of `N(2,4)P(4,3)` will be transfomed: `N(2,4) -> E(2,3)`, `P(4,3) -> Q(4,4)`  
2. **Same row**
If the letters are on the same row, each letter is replaced by the next letter in the row. The last letter in the row is replaced by the first letter of the same row. For example, the pair `I(4,4) T(1,3)` would be encrypted as `RF`.
3. **Same column**
If the letters are in the same column, each letter is replaced by the letter directly below it. The last letter in the column is replaced by the first letter of the same column. For example, the pair `C(3,2)W(5,2)` would be encrypted as `OI` (since W is at the bottom of the column, it wraps to the top).
This is implemented using an `Encryptor` class:
```python
from alphabets.AlphabetFactory import AlphabetFactory
from preparator.Preparator import Preparator
from alphabets.AlphabetMatrix import AlphabetMatrix


class Encryptor:
    def __init__(self):
        pass

    def encrypt(self, text: str = None, key: str = None, language_code: str = None) -> str:
        preparator = Preparator()
        print(f"""Encrypting text: \n'{text}' \nwith key: '{
              key}' and language code: '{language_code}'""")
        prepared_key = preparator.prepare_key(key=key)
        print(f"Prepared key: '{prepared_key}'")
        prepared_text = preparator.prepare_text(text=text)
        print(f"Prepared text pair: '{prepared_text}'")
        matrix = self._get_matrix(
            language_code=language_code, key=prepared_key)

        encrypted_text = self._encrypt_text(
            prepared_text=prepared_text, matrix=matrix)
        return encrypted_text


    def _get_letter_position(self, letter: str = None, matrix: list = None):
        for i, row in enumerate(matrix):
            for j, char in enumerate(row):
                if char == letter:
                    return i, j
        print(f"Letter '{letter}' not found in the matrix")

    def _encrypt_text(self, prepared_text: list = None, matrix: list = None) -> str:
        encrypted_text = ""
        for pair in prepared_text:
            char1, char2 = pair

            row1, col1 = self._get_letter_position(char1, matrix)
            row2, col2 = self._get_letter_position(char2, matrix)

            if row1 is None or col1 is None:
                raise ValueError(
                    f"Character '{char1}' not found in the matrix")
            if row2 is None or col2 is None:
                raise ValueError(
                    f"Character '{char2}' not found in the matrix")

            if row1 != row2 and col1 != col2:
                encrypted_text += matrix[row1][col2] + matrix[row2][col1]
            elif row1 == row2:
                encrypted_text += matrix[row1][(col1 + 1) % len(
                    matrix[row1])] + matrix[row2][(col2 + 1) % len(matrix[row2])]
            elif col1 == col2:
                encrypted_text += matrix[(row1 + 1) % len(matrix)
                                         ][col1] + matrix[(row2 + 1) % len(matrix)][col2]

        return encrypted_text
```
### Decryption
For decryption, the same rules as encryption are applied with the following adjustments:
1. **Different row and column**  
If the letters are in different rows and columns, decryption is done exactly as encryption.
2. **Same row**  
If the letters are on the same row, each letter is replaced by the previous letter in the row. The first letter in the row is replaced by the last letter of the same row.
3. **Same column**  
If the letters are in the same column, each letter is replaced by the letter directly above it. The first letter in the column is replaced by the last letter of the same column.
This is implemented using the `Decryptor` class:
```python
from alphabets.AlphabetFactory import AlphabetFactory
from alphabets.AlphabetMatrix import AlphabetMatrix
from preparator.Preparator import Preparator


class Decryptor:
    def __init__(self):
        pass

    def decrypt(self, text: str = None, key: str = None, language_code: str = None) -> str:
        preparator = Preparator()
        print(f"""Decrypting text: \n'{text}' \nwith key: '{
              key}' and language code: '{language_code}'""")
        prepared_key = preparator.prepare_key(key=key)
        print(f"Prepared key: '{prepared_key}'")
        prepared_text = preparator.prepare_text(text=text)
        print(f"Prepared text pair: '{prepared_text}'")
        matrix = self._get_matrix(
            language_code=language_code, key=prepared_key)

        decrypted_text = self._decrypt_text(
            prepared_text=prepared_text, matrix=matrix)
        return decrypted_text

   def _decrypt_text(self, prepared_text: list = None, matrix: list = None) -> str:
        decrypted_text = ""
        for pair in prepared_text:
            char1, char2 = pair
            row1, col1 = self._get_letter_position(char1, matrix)
            row2, col2 = self._get_letter_position(char2, matrix)

            if row1 != row2 and col1 != col2:
                decrypted_text += matrix[row1][col2] + matrix[row2][col1]
            elif row1 == row2:
                decrypted_text += matrix[row1][(col1 - 1) % len(
                    matrix[row1])] + matrix[row2][(col2 - 1) % len(matrix[row2])]
            elif col1 == col2:
                decrypted_text += matrix[(row1 - 1) % len(matrix)
                                         ][col1] + matrix[(row2 - 1) % len(matrix)][col2]

        return decrypted_text

    def _get_letter_position(self, letter: str = None, matrix: list = None):
        for i, row in enumerate(matrix):
            for j, char in enumerate(row):
                if char == letter:
                    return i, j
        print(f"Letter '{letter}' not found in the matrix")
```
## Result
The algorithm is encapsulated as a CLI tool, where the steps of execution are also logged. 
```bash
usage: playfair.py [-h] [-e] [-d] -l LANGUAGE_CODE -k KEY -t TEXT

Encrypt or Decrypt a message using the Playfair cipher.

options:
  -h, --help            show this help message and exit
  -e, --encrypt         Encrypt the text
  -d, --decrypt         Decrypt the text
  -l LANGUAGE_CODE, --language_code LANGUAGE_CODE
                        Language code for the alphabet (e.g., 'en' for English, 'ro' for Romanian)
  -k KEY, --key KEY     Encryption key
  -t TEXT, --text TEXT  Text to encrypt or decrypt
```
So we can encrypt with:
```bash 
python playfair.py -e -l ro -k MYSUPERSTRONGKEYOUCANTGUESS -t "Mă bucur că ai venit!"
Encrypting text: 
'Mă bucur că ai venit!' 
with key: 'MYSUPERSTRONGKEYOUCANTGUESS' and language code: 'ro'
Prepared key: 'MYSUPERTONGKCA'
Prepared text pair: '['MĂ', 'BU', 'CU', 'RC', 'ĂA', 'IV', 'EN', 'IT']'
Alphabet: 'ABCDEFGHIJKLMNOPQRSTUVWXYZĂÂÎȘȚ'
Alphabet length: 31 letters
Matrix will have size 6x5
Matrix:
['M', 'Y', 'S', 'U', 'P']
['E', 'R', 'T', 'O', 'N']
['G', 'K', 'C', 'A', 'B']
['D', 'F', 'H', 'I', 'L']
['Q', 'V', 'W', 'X', 'Z']
['Ă', 'Â', 'Î', 'Ș', 'Ț']
Encrypted text: EMAPASTKȘGFXREHO
```
And decrypt the text with:
```bash
python playfair.py -d -l ro -k MYSUPERSTRONGKEYOUCANTGUESS -t "EMAPASTKȘGFXREHO"
Decrypting text: 
'EMAPASTKȘGFXREHO' 
with key: 'MYSUPERSTRONGKEYOUCANTGUESS' and language code: 'ro'
Prepared key: 'MYSUPERTONGKCA'
Prepared text pair: '['EM', 'AP', 'AS', 'TK', 'ȘG', 'FX', 'RE', 'HO']'
Alphabet: 'ABCDEFGHIJKLMNOPQRSTUVWXYZĂÂÎȘȚ'
Alphabet length: 31 letters
Matrix will have size 6x5
Matrix:
['M', 'Y', 'S', 'U', 'P']
['E', 'R', 'T', 'O', 'N']
['G', 'K', 'C', 'A', 'B']
['D', 'F', 'H', 'I', 'L']
['Q', 'V', 'W', 'X', 'Z']
['Ă', 'Â', 'Î', 'Ș', 'Ț']
Decrypted text: MĂBUCURCĂAIVENIT
```
## Conclusion
The Playfair cipher, though historically significant, offers a basic form of encryption that can be easily implemented using Python. 
By utilizing a 5x5 matrix and applying specific encryption and decryption rules, we ensure the secure handling of digraphs in a text.
However, it is no longer considered secure by modern cryptographic standards due to its vulnerability to advanced attack methods.
Despite this, the Playfair cipher remains a useful tool for understanding classical encryption techniques and exploring basic cipher principles.
