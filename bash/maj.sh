#!/bin/bash

# Definition des couleurs
GREEN='\e[32m'
RED='\e[31m'
YELLOW='\e[33m'
NC='\e[0m' # No Color

# Verifie si le script est execute en tant que root
if [ "$UID" -ne 0 ]; then
    echo -e "${RED}ERREUR : ce script doit etre execute en tant que root (sudo).${NC}" >&2
    exit 1
fi

echo -e "${GREEN}OK : Vous etes root. Le script peut demarrer.${NC}"

# Fichier de log
LOGFILE="/var/log/maj_systeme.log"

# Creation du fichier de log si inexistant
if [ ! -f "$LOGFILE" ]; then
    touch "$LOGFILE" && chmod 600 "$LOGFILE"
    echo -e "${YELLOW}Fichier de log cree : $LOGFILE${NC}"
fi

# Verification de la connexion Internet
echo -e "${GREEN}Verification de la connexion reseau...${NC}"
if ! ping -c 2 8.8.8.8 > /dev/null 2>&1; then
    echo -e "${RED}ERREUR : Pas de connexion reseau. Arret du script.${NC}" >&2
    exit 1
fi

echo -e "${GREEN}Connexion reseau OK${NC}"

# Lancement de la mise a jour
echo -e "${GREEN}Mise a jour du systeme en cours...${NC}"
echo "======== [ $(date "+%Y-%m-%d %H:%M:%S") ] ========" >> "$LOGFILE"
echo "Debut de la mise a jour" >> "$LOGFILE"

{
    apt update
    apt upgrade -y
    apt autoremove -y
    apt clean
} >> "$LOGFILE" 2>&1

# Verification du succes
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Mise a jour terminee avec succes.${NC}"
    echo "Fin de la mise a jour : OK" >> "$LOGFILE"
else
    echo -e "${RED}ERREUR : Probleme pendant la mise a jour. Voir le fichier log.${NC}"
    echo "Fin de la mise a jour : ERREUR" >> "$LOGFILE"
fi

echo "==============================================" >> "$LOGFILE"
