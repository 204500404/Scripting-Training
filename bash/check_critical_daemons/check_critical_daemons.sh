#!/bin/bash

RED='\e[31m'
GREEN='\e[32m'
NC='\e[0m'

#!/bin/bash

LISTE="DaemonsList.txt"

if [ ! -f "$LISTE" ]; then
    echo -e "${RED}ERREUR: Le fichier $LISTE n'existe pas.${NC}" >&2
    exit 1
fi

echo "Vérification des services listes dans $LISTE..."
echo "-----------------------------------------------"

while read -r DAEMON || [ -n "$DAEMON" ]; do
    # Ignorer les lignes vides et les commentaires
    [[ -z "$DAEMON" || "$DAEMON" =~ ^# ]] && continue

    echo -n "Service :  $DAEMON : "

    if systemctl is-active --quiet "$DAEMON"; then
        echo -e "${GREEN} CONFIRMATION : Actif ${NC}"
    else
        echo -e "${RED} ATTENTION : Inactif ${NC}"
        # Redémarrage automatique (optionnel) :
        systemctl restart "$DAEMON" && echo "Redemarre"
    fi
done < "$LISTE"

echo "-----------------------------------------------"
echo "✔️ Vérification terminee."

