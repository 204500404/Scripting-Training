#!/bin/bash

# Definition des couleurs pour l'affichage
RED='\e[31m'
GREEN='\e[32m'
NC='\e[0m'

#!/bin/bash

LISTE="DaemonsList.txt"

# Verification de l'existence du fichier
if [ ! -f "$LISTE" ]; then
    echo -e "${RED}ERREUR: Le fichier $LISTE n'existe pas.${NC}" >&2
    exit 1
fi

echo "Verification des services listes dans $LISTE..."
echo "-----------------------------------------------"
# Boucle sur chaque ligne du fichier
while read -r DAEMON || [ -n "$DAEMON" ]; do
    # Ignorer les lignes vides ou les commentaires (lignes commencant par #)
    [[ -z "$DAEMON" || "$DAEMON" =~ ^# ]] && continue

    echo -n "Service :  $DAEMON : "
 # Verifie si le service est actif
    if systemctl is-active --quiet "$DAEMON"; then
        echo -e "${GREEN} CONFIRMATION : Actif ${NC}"
    else
        echo -e "${RED} ATTENTION : Inactif ${NC}"
        # Redemarrage automatique (optionnel) :
        systemctl restart "$DAEMON" && echo "Redemarre"
    fi
done < "$LISTE"

echo "-----------------------------------------------"
echo "Verification terminee."

