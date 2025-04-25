from faker import Faker
import random

fake = Faker()

def generate_fake_email():
    """
    Génère une adresse email réaliste à partir d'un prénom et d'un nom aléatoires.
    On ajoute un nombre aléatoire entre 100 et 999 à la fin pour garantir l'unicité.
    L'email se termine par @gmail.com.
    """
    first = fake.first_name().lower()
    last = fake.last_name().lower()
    number = random.randint(100, 999)
    email = f"{first}.{last}{number}@gmail.com"
    return email

def main():
    try:
        count = int(input("Combien d'adresses email voulez-vous générer ? "))
    except ValueError:
        print("Veuillez entrer un nombre valide.")
        return

    emails = [generate_fake_email() for _ in range(count)]
    
    print("\nAdresses email générées :")
    for email in emails:
        print(email)
        
    # Sauvegarde dans un fichier texte
    with open("fake_emails.txt", "w", encoding="utf-8") as f:
        f.write("\n".join(emails))
    
    print("\nLes adresses email ont été enregistrées dans le fichier 'fake_emails.txt'.")

if __name__ == "__main__":
    main()
