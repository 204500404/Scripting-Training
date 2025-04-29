#!/bin/bash

# Chemin du dossier source (où sont tes fichiers actuels)
SOURCE_DIR="/System/Volumes/Data/Users/x/Documents/SAUVEGARDES"
mkdir -p "$SOURCE_DIR"
# Chemin du premier dossier de destination (disque dur externe)
DESTINATION_DIR_EXTERNAL="/Volumes/ExternalDiskName/SAUVEGARDES"

# Chemin du second dossier de destination (Google Drive par exemple)
DESTINATION_DIR_GDRIVE="/Users/x/Library/CloudStorage/GoogleDrive-example@gmail.com/BACKUP001"

# Création des dossiers de destination s'ils n'existent pas
mkdir -p "$DESTINATION_DIR_EXTERNAL"
mkdir -p "$DESTINATION_DIR_GDRIVE"

# Dossier pour stocker les logs
LOG_DIR="/System/Volumes/Data/Users/x/Documents/LOGS"
mkdir -p "$LOG_DIR"

# Fichier de log
LOG_FILE="$LOG_DIR/sauvegarde_log.txt"
touch "$LOG_FILE"

# Date et Heure du lancement
echo "----------------------------------------" >> "$LOG_FILE"
echo "Sauvegarde lancée le : $(date)" >> "$LOG_FILE"

# Sauvegarde vers disque externe
echo "Sauvegarde vers disque externe..." >> "$LOG_FILE"
rsync -avh --delete "$SOURCE_DIR/" "$DESTINATION_DIR_EXTERNAL/" >> "$LOG_FILE" 2>&1

# Sauvegarde vers Google Drive
echo "Sauvegarde vers Google Drive..." >> "$LOG_FILE"
rsync -avh --delete "$SOURCE_DIR/" "$DESTINATION_DIR_GDRIVE/" >> "$LOG_FILE" 2>&1

# Fin
echo "Sauvegarde terminée le : $(date)" >> "$LOG_FILE"
echo "----------------------------------------" >> "$LOG_FILE"
