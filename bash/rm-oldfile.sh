#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
NC="\e[0m" #Nocolor

#Verifie que l'utilisateur est root
if [ "$UID" -ne 0 ]; then
        echo -e "${RED}Pour qu'il fonctionne, vous devez executer ce script en tant que root (sudo)${NC}"
        exit 1
fi
#Verifie que le repertoire /tmp existe
if [ ! -d /tmp ]; then
        echo -e "${RED}Le repertoire /tmp n'existe pas.${NC}"
        echo "Creation du repertoire /tmp..."
        mkdir -p /tmp
fi
#Verifie que le repertoire /var/log existe
if [ ! -d /var/log ]; then
        echo -e "${RED}Le repertoire /var/log n'existe pas.${NC}"
        echo "Creation du repertoire /var/log..."
        mkdir -p /var/log/
fi

echo -e "${GREEN}Vous executez bien ce script en tant que root, le script peut commencer${NC}"

#Création d'un fichier de LOG

LOGFILE="/var/log/script_rm-oldfile.log"
touch "$LOGFILE"
echo "$(date "+%Y/%m/%d %H:%M:%S") : Nettoyage effectué." >> "$LOGFILE"

#Nettoyage de /tmp

echo "Nettoyage de /tmp en cours..."
find /tmp -mindepth 1 -mtime +7 -delete

#Message de confirmation

echo -e "${GREEN}/tmp a bien été nettoyé.${NC}"