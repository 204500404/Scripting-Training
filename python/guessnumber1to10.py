import random
nombre_aleatoire = random.randint(1,10)
try :
    usertry = float(input("Devinez un nombre entre 1 et 10 :  "))
    if usertry < 1:
        print("Entrez une valeur entre 1 et 10 !")
    if usertry > 10:
        print("Entrez une valeur entre 1 et 10 !")
except:
    print("Entrez une valeur correcte !")
while usertry != nombre_aleatoire:
    try :
        usertry = float(input("essayez encore ! :"))
        if usertry < 1:
            print("Entrez une valeur entre 1 et 10 !")
        if usertry > 10:
            print("Entrez une valeur entre 1 et 10 !")
    except :
        print("Entrez une valeur correcte !")


print(f"bravo trouvé la réponse était bien {nombre_aleatoire} !")