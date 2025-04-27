#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
NC="\e[0m"

if [ "$UID" -ne 0 ]; then
        echo -e "${RED}Vous devez executer ce script en tant que root (sudo).${NC}"
        exit 1
fi
echo -e "\n${GREEN}Vous exécutez bien ce script en tant que root, le script peut commencer${NC}\n"

read -p "pour quelle interface réseau souhaitez vous réaliser un renouvellement des parametres TCP/IP ? (ens33, eth0, etc..)" INTERFACE

if ! ip link show "$INTERFACE" > /dev/null 2>&1; then
    echo -e "${RED}Erreur : l'interface réseau ${INTERFACE} n'existe pas.${NC}"
    exit 1
fi


echo -e "Liberation en cours des paramètres TCP/IP de l'interface ${INTERFACE}..."
dhclient -r "$INTERFACE"
dhclient "$INTERFACE"

echo -e "Test de la connectivite en cours..."
ping 8.8.8.8 -c 4

echo -e "Test du DNS en cours..."
ping bing.fr -c 4

echo -e "${GREEN}\nNouvelle configuration IP :${NC}"
ip -c -4 addr show "$INTERFACE"

