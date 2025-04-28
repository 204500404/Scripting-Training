#!/bin/bash


GREEN="\e[32m"
RED="\e[31m"
NC="\e[0m"

if [ "$UID" -ne 0 ]; then
        echo -e "${RED}Vous devez executer ce script en tant que root (sudo). ${NC}" >&2
        exit 1
fi
echo -e "${GREEN}Vous executez bien votre script en tant que root, debut du script...${NC}"

LineNbr=$(df -P | wc -l)
UsefulLineNbr=$((LineNbr -1))

echo -e "${UsefulLineNbr}"

df -h | awk 'NR==2 {print $1}'

compteur=2
while [ "$compteur" -le "$LineNbr" ]; do
        FS=$(df -h | awk -v line="$compteur" 'NR==line {print $1}')
        echo "système de fichier : ${FS}"
        echo "Compteur : $compteur"
         ((compteur++))
done

