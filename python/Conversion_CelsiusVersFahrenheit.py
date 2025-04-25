try:
    valeur_celsius = float(input("Entrez une température en degrés Celsius : "))
    facteur, diviseur, offset = 9, 5, 32
    valeur_fahrenheit = facteur/diviseur * valeur_celsius + offset
    print (f"{valeur_celsius:.2f}°C équivaut à {valeur_fahrenheit:.2f}°F")
except ValueError:
    print("Veuillez entrer un nombre valide.")