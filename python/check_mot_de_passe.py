def mdp_checkglobal():
    def mdp_check_1():
        while True:
            mot_de_passe = input("Entrez votre nouveau mot de passe : ")
            confirm_mot_de_passe = input("Confirmez votre mot de passe : ")
            if mot_de_passe == confirm_mot_de_passe:
                print("Mot de passe enregistré avec succès !")
                break
            else:
                yes_or_no = input("Les mots de passe ne correspondent pas. Réessayer ? (Y/N)")  
                if yes_or_no.upper() == "N" :
                    print("Opération annulée")
                    break
                elif yes_or_no.upper() != "Y" :
                    print("Choix invalide. Opération annulée.")
                    break
    mdp_check_1()
mdp_checkglobal()