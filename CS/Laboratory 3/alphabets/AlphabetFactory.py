class AlphabetFactory:
    def __init__(self) -> None:
        pass

    def create(self, language_code: str) -> str:
        if language_code == "en":
            return "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        elif language_code == "es":
            return "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ"
        elif language_code == "pt":
            return "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        elif language_code == "fr":
            return "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        elif language_code == "ro":
            return "ABCDEFGHIJKLMNOPQRSTUVWXYZĂÂÎȘȚ"
        elif language_code == "de":
            return "ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜß"
        elif language_code == "it":
            return "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
