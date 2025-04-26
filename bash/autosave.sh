#!/bin/bash

GREEN="\e[32m"
RED="\e[31m"
NC="\e[0m"

#Verifie si le script est exectuer en tant que root (sudo).
if [ "$UID" -ne 0 ]; then
        echo -e "#$RED} Erreur : Ce script doit être éxecuter en tant que root (sudo). ${NC}" >&2
        exit 1
fi

echo -e "${GREEN} Début du script...${NC}"

#Demander à l'utilisateur le chemin du repertoire à sauvegarder

read -p "Entrez le chemin du repertoire à sauvegarder : " chemin_repo

echo "Vous avez saisi : $chemin_repo"

#Verifie si le fichier existe
if [ ! -d "$chemin_repo" ]; then
        echo "Erreur : Le fichier '$chemin_repo' n'existe pas. " >&2
        exit 1
fi

#Récupérer uniquement le nom du fichier

FILENAME=$(basename "$chemin_repo")

echo -e "${GREEN} Traitement en cours du répertoire : ${FILENAME} ${NC}"

#Créer le repertoire de sauvegarde si nécessaire

BACKUP_DIR="/home/BACKUP_REPOSITORY"

mkdir -p "$BACKUP_DIR"

#Créer l'archive compressée directement dans le fichier de sauvegarder

tar -czvf "$BACKUP_DIR/${FILENAME}.tar.gz" -C "$(dirname "$chemin_repo")" "$FILENAME"

#Message de confirmation pour l'utilisateur

echo -e "${GREEN}Le repertoire $FILENAME a bien été compressé et sauvegardé dans le repertoire de sauvegarde ${BACKUP_DIR}! ${NC}"
