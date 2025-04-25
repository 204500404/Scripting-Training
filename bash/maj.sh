#!/bin/bash

GREEN="\e[32m"
RED="\e[31m"
NC="\e[0m" # Nocolor

if [ "$UID" -ne 0 ]; then
    echo -e "${RED}Erreur : Ce script doit être exécuté en tant que root (sudo).${NC}" >&2
    exit 1
fi

echo -e "${GREEN}Vous exécutez bien ce script en tant que root, le script peut commencer.${NC}"

LOGFILE="/var/log/maj_systeme.log"

if [ ! -f "$LOGFILE" ]; then
    touch "$LOGFILE" && chmod 600 "$LOGFILE"
fi

echo -e "${GREEN}Mise à jour du système en cours...${NC}"
echo "Début de mise à jour : $(date '+%a %d/%m/%Y %H:%M:%S')" >> "$LOGFILE"

apt update >> "$LOGFILE" 2>&1
apt upgrade -y >> "$LOGFILE" 2>&1
apt autoremove -y >> "$LOGFILE" 2>&1
apt clean >> "$LOGFILE" 2>&1

echo -e "${GREEN}Mise à jour terminée avec succès${NC}"
