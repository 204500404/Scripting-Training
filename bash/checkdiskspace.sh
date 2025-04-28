#!/bin/bash

# Définition des couleurs
GREEN="\e[32m"
RED="\e[31m"
NC="\e[0m"

# Vérification des droits root
if [ "$UID" -ne 0 ]; then
    echo -e "${RED}Vous devez exécuter ce script en tant que root (sudo).${NC}" >&2
    exit 1
fi

echo -e "${GREEN}Vous exécutez bien votre script en tant que root, début du script...${NC}"

# Variables
LineNbr=$(df -P | wc -l)
UsefulLineNbr=$((LineNbr -1))
Seuil=80  # Seuil d'alerte en pourcentage (%)

echo -e "Nombre de systèmes de fichiers analysés : ${UsefulLineNbr}"

# Lecture de df -P une seule fois pour être plus efficace
df -P > /tmp/df_output.txt

compteur=2  # On commence à la deuxième ligne (premier filesystem réel)
while [ "$compteur" -le "$LineNbr" ]; do
    FS=$(awk -v line="$compteur" 'NR==line {print $1}' /tmp/df_output.txt)  # Nom du système de fichier
    USAGE=$(awk -v line="$compteur" 'NR==line {gsub("%", "", $5); print $5}' /tmp/df_output.txt)  # Usage disque en pourcentage sans %

    echo -e "Système de fichier : ${FS} - Occupation : ${USAGE}%"

    # Comparaison : si l'usage dépasse le seuil
    if [ "$USAGE" -ge "$Seuil" ]; then
        echo -e "${RED}ALERTE : ${FS} est utilisé à ${USAGE}% !${NC}"
    else
        echo -e "${GREEN}ETAT BON : ${FS} a une utilisation normale (${USAGE}%).${NC}"
    fi

    ((compteur++))
done

# Nettoyage du fichier temporaire
rm /tmp/df_output.txt
