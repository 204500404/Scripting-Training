def what_table():
    tablewanted = int(input("Quelle table souhaitez vous connaître ? : "))
    tablestop = 10
    multipliercoefficient = 0
    print(f"\nVoici la table de {tablewanted} : \n8")
    while multipliercoefficient <= tablestop:
        resultat = tablewanted*multipliercoefficient
        print(f"{tablewanted}*{multipliercoefficient} = {resultat}")
        multipliercoefficient +=1
    print("")
what_table()
