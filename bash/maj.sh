#!/bin/bash

GREEN="\e[32m"
RED="\e[31m"
NC="\e[0m" #Nocolor

if [ "$UID" -ne 0 ]; then
	echo "${RED}Erreur : Ce script doit être éxecuter en tant que root (sudo).${NC}" >&2
	exit 1
fi


echo "${GREEN}Vous executez bien ce script en tant que root le script peut commencer${NC}"

LOGFILE="/var/log/maj_systeme.log"

if [ ! -f "$LOGFILE" ]; then
	touch "$LOGFILE" && chmod 600 "$LOGFILE"

fi

mkdir -p /var/log/maj_system.log

echo -e "${GREEN}Verification de la connexion...${NC}"

ping -c 4 8.8.8.8 > /dev/null 2>&1
if [ $? -ne 0 ]; then
	echo -e "${RED} Connexion réseau absente, Abandon du script. ${NC}" >&2
	exit 1
fi

echo -e "${GREEN}Mise à jour du système en cours...${NC}"

echo "Début de Mise à jour : $(date "+%A %d/%m/%Y %H:%M:%S")" >> "$LOGFILE"


apt update >> "$LOGFILE" 2>&1
apt upgrade -y >> "$LOGFILE" 2>&1

apt autoremove -y >> "$LOGFILE"  2>&1
apt clean >> "$LOGFILE" 2>&1

echo "Mise à jour terminée avec succès"
