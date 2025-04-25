import re

def palindrome_or_not():
    sentence = input("Entrez un mot ou une phrase : ").lower()
    # Suppression des espaces et des caractères non alphabétiques
    cleaned_sentence = re.sub(r'[^a-zA-Z0-9]', '', sentence)
    
    # Vérification du palindrome
    if cleaned_sentence == cleaned_sentence[::-1]:
        print(f"'{sentence}' est un palindrome !")
    else:
        print(f"'{sentence}' n'est pas un palindrome !")

palindrome_or_not()
