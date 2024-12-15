class AlphabetMatrix:
    def __init__(self) -> None:
        pass

    def _determine_matrix_size(self, alphabet: str) -> tuple:
        alphabet_length = len(alphabet)
        print(f"Alphabet length: {alphabet_length} letters")
        min_columns = 5
        rows = alphabet_length // min_columns
        if alphabet_length % min_columns > rows:
            rows += 1
        print(f"Matrix will have size {rows}x{min_columns}")
        return min_columns, rows

    def _prepare_alphabet(self, alphabet: str, normalied_key: str) -> str:
        prepared_alphabet = alphabet.replace("J", "I")
        filtered_alphabet = self._remove_duplicates(prepared_alphabet)
        return normalied_key + filtered_alphabet

    def _get_empty_matrix(self, x: int, y: int) -> list:
        return [['' for _ in range(x)] for _ in range(y)]

    def _remove_duplicates(self, text: str) -> str:
        seen = set()
        return ''.join([c for c in text if not (c in seen or seen.add(c))])

    def _fill_matrix(self, alphabet: str = None, empty_matrix: list[list[str]] = None, normalized_key: str = None) -> list:
        matrix = empty_matrix
        current_row = 0
        current_col = 0
        used_characters = set()
        matrix_rows = len(matrix)
        matrix_columns = len(matrix[0])

        for char in normalized_key:
            if char not in used_characters:
                matrix[current_row][current_col] = char
                used_characters.add(char)
                current_col += 1
                if current_col == matrix_columns:
                    current_col = 0
                    current_row += 1
                if current_row == matrix_rows:
                    break

        for char in alphabet:
            if char not in used_characters:
                matrix[current_row][current_col] = char
                used_characters.add(char)
                current_col += 1
                if current_col == matrix_columns:
                    current_col = 0
                    current_row += 1
                if current_row == matrix_rows:
                    break

        return matrix

    def create(self, alphabet: str, normalized_key: str) -> list:
        x, y = self._determine_matrix_size(alphabet=alphabet)
        empty_matrix = self._get_empty_matrix(x, y)
        prepared_alphabet = self._prepare_alphabet(
            alphabet=alphabet, normalied_key=normalized_key)
        matrix = self._fill_matrix(
            alphabet=prepared_alphabet, empty_matrix=empty_matrix, normalized_key=normalized_key)

        return matrix
