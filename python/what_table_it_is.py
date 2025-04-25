def What_is_tha_table():
    table_wanted = int(input("Entrez la table que vous souhaitez afficher : "))
    table_stop = int(input("Jusqu'ou voulez vous que la table s'arrête (table de 10, 20, 30...) : "))
    coefficient_multiplicateur=0
    while coefficient_multiplicateur <= table_stop:
        resultat = table_wanted*coefficient_multiplicateur
        print(f"{table_wanted}*{coefficient_multiplicateur}={resultat}")
        coefficient_multiplicateur+=1
    print("")
What_is_tha_table()