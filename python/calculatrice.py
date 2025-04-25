first_value = float(input("Entrez une première valeur : "))
symbol = input("Entrez un symbole (+, -, *, /) : ")
second_value = float(input("Entrez une deuxième valeur : "))

# Calcul initial
if symbol == "+":
    resultat = first_value + second_value
elif symbol == "-":
    resultat = first_value - second_value
elif symbol == "*":
    resultat = first_value * second_value
elif symbol == "/":
    if second_value != 0:
        resultat = first_value / second_value
    else:
        print("Erreur : division par zéro")
        exit()
else:
    print("Symbole non valide.")
    exit()

# Boucle pour ajouter d'autres opérations
while True:
    next_symbol = input("Entrez un symbole pour continuer ou '=' pour terminer : ")
    
    if next_symbol == "=":
        break
    
    new_value = float(input("Entrez une nouvelle valeur : "))

    if next_symbol == "+":
        resultat += new_value
    elif next_symbol == "-":
        resultat -= new_value
    elif next_symbol == "*":
        resultat *= new_value
    elif next_symbol == "/":
        if new_value != 0:
            resultat /= new_value
        else:
            print("Erreur : division par zéro")
            exit()
    else:
        print("Symbole non reconnu.")
        exit()

print(f"Résultat final : {resultat}")
