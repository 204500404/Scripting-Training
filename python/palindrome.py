def palindrome_or_not():
    sentence = input("Entrez un mot ou une phrase : ")
    nombre_carac, compteur, lettres_inversees = len(sentence), 1, ""
    while compteur <= nombre_carac:
        lettres_inversees += sentence[-compteur] #inverse la chaine
        compteur+=1
    if lettres_inversees == sentence:
        print(f"{sentence} est un palindrome !")
    else:
        print(f"{sentence} n'est pas un palindrome !")
palindrome_or_not()