#!/bin/bash

# Définir les couleurs
GREEN="\e[32m"
RED="\e[31m"
NC="\e[0m"

# Vérifier si le script est exécuté en tant que root
if [ "$UID" -ne 0 ]; then
    echo -e "${RED}Erreur : Ce script doit être exécuté en tant que root (sudo).${NC}" >&2
    exit 1
fi

echo -e "${GREEN}Début du script...${NC}"

# Demander à l'utilisateur le chemin du répertoire à sauvegarder
read -p "Entrez le chemin du répertoire à sauvegarder : " chemin_repo
echo "Vous avez saisi : $chemin_repo"

# Vérifier si le répertoire existe
if [ ! -d "$chemin_repo" ]; then
    echo -e "${RED}Erreur : Le répertoire '$chemin_repo' n'existe pas.${NC}" >&2
    exit 1
fi

# Récupérer uniquement le nom du dossier
FILENAME=$(basename "$chemin_repo")

# Ajouter la date au format YYYY-MM-DD
DATE=$(date +%F)

# Définir le dossier de sauvegarde
BACKUP_DIR="/home/BACKUP_REPOSITORY"
mkdir -p "$BACKUP_DIR"

# Définir le chemin complet de l'archive
ARCHIVE_PATH="$BACKUP_DIR/${FILENAME}_${DATE}.tar.gz"

# Créer l'archive compressée
tar -czf "$ARCHIVE_PATH" -C "$(dirname "$chemin_repo")" "$FILENAME"

# Vérifier si la sauvegarde a réussi
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Le répertoire '${FILENAME}' a été compressé et sauvegardé dans : ${ARCHIVE_PATH}${NC}"
else
    echo -e "${RED}Erreur lors de la création de l'archive.${NC}" >&2
    exit 1
fi

# Écrire un log
LOG_FILE="/var/log/backup_script.log"
mkdir -p "$(dirname "$LOG_FILE")"
echo "$(date '+%Y-%m-%d %H:%M:%S') - Sauvegarde de '$chemin_repo' vers '$ARCHIVE_PATH'" >> "$LOG_FILE"
