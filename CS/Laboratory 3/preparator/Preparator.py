import random


class Preparator:
    def __init__(self):
        self.filler_letters = ['X', 'Y', 'Z', 'W', 'Q']

    def _uppercase(self, text):
        return text.upper()

    def _substitute(self, text):
        return text.replace('J', 'I')

    def _clean(self, text):
        return ''.join([c for c in text if c.isalpha()])

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

    def _separate_digraphs(self, text):
        digraphs = self._split(text)
        return digraphs

    def prepare_text(self, text):
        text = self._uppercase(text)
        text = self._clean(text)
        text = self._substitute(text)
        text = self._separate_digraphs(text)
        return text

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
