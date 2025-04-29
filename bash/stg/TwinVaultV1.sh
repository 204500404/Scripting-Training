#!/bin/bash

# Chemin du dossier source (o?? sont tes fichiers actuels)
SOURCE_DIR="/System/Volumes/Data/Users/x/Documents/SAUVEGARDES"  # <-- Corrige : suppression du $ inutile
mkdir -p "$SOURCE_DIR"

# Chemin du dossier de destination (ton disque dur externe mont??)
DESTINATION_DIR="/Volumes/ExternalDiskName/SAUVEGARDES"

# Creation du dossier de destination s'il n'existe pas
mkdir -p "$DESTINATION_DIR"

# Dossier pour stocker les logs
LOG_DIR="/System/Volumes/Data/Users/x/Documents/LOGS"
mkdir -p "$LOG_DIR"

# Fichier de log
LOG_FILE="$LOG_DIR/sauvegarde_log.txt"
touch "$LOG_FILE"

# Date et Heure du lancement
echo "----------------------------------------" >> "$LOG_FILE"
echo "Sauvegarde lancee le : $(date)" >> "$LOG_FILE"

# Commande de sauvegarde rsync
rsync -avh --delete "$SOURCE_DIR/" "$DESTINATION_DIR/" >> "$LOG_FILE" 2>&1

# Fin
echo "Sauvegarde terminee le : $(date)" >> "$LOG_FILE"
echo "----------------------------------------" >> "$LOG_FILE"


