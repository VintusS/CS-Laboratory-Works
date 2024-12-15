from alphabets.AlphabetFactory import AlphabetFactory
from alphabets.AlphabetMatrix import AlphabetMatrix
from preparator.Preparator import Preparator

import re
from collections import deque


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

    def _get_matrix(self, language_code: str = None, key: str = None):
        alphabet = AlphabetFactory().create(language_code=language_code)
        print(f"Alphabet: '{alphabet}'")
        matrix_creator = AlphabetMatrix()
        matrix = matrix_creator.create(alphabet=alphabet, normalized_key=key)
        print(f"Matrix:")
        for row in matrix:
            print(row)
        return matrix

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
