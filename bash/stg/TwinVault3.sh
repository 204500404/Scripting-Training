#!/bin/bash

# Chemin du dossier source
SOURCE_DIR="/System/Volumes/Data/Users/x/Documents/SAUVEGARDES"

# Destination 1 : Disque externe
DESTINATION_DIR_EXTERNAL="/Volumes/ExternalDiskName/SAUVEGARDES"

# Destination 2 : Google Drive
DESTINATION_DIR_GDRIVE="/Users/x/Library/CloudStorage/GoogleDrive-example@gmail.com/BACKUP001"

# Dossier pour logs
LOG_DIR="/System/Volumes/Data/Users/x/Documents/LOGS"
mkdir -p "$DESTINATION_DIR_EXTERNAL" "$DESTINATION_DIR_GDRIVE" "$LOG_DIR" "$SOURCE_DIR"

# Fichier de log
LOG_FILE="$LOG_DIR/sauvegarde_log.txt"
touch "$LOG_FILE"

# Date et Heure du lancement
echo "----------------------------------------" >> "$LOG_FILE"
echo "Sauvegarde lancee le : $(date)" >> "$LOG_FILE"
echo "Sauvegarde lancee le : $(date)"

# -------- Sauvegarde vers disque externe --------
echo "Sauvegarde vers disque externe..."
echo "Sauvegarde vers disque externe..." >> "$LOG_FILE"
if rsync -avh --delete "$SOURCE_DIR/" "$DESTINATION_DIR_EXTERNAL/" >> "$LOG_FILE" 2>&1; then
    echo "-- Sauvegarde disque externe reussie."
else
    echo "-- Erreur sauvegarde disque externe !" | tee -a "$LOG_FILE"
    osascript -e 'display notification "Erreur de sauvegarde vers disque externe" with title "Sauvegarde echouee"'
    exit 1
fi

# -------- Sauvegarde vers Google Drive --------
echo "Sauvegarde vers Google Drive..."
echo "Sauvegarde vers Google Drive..." >> "$LOG_FILE"
if rsync -avh --delete "$SOURCE_DIR/" "$DESTINATION_DIR_GDRIVE/" >> "$LOG_FILE" 2>&1; then
    echo "-- Sauvegarde Google Drive reussie."
else
    echo "-- Erreur sauvegarde Google Drive !" | tee -a "$LOG_FILE"
    osascript -e 'display notification "Erreur de sauvegarde vers Google Drive" with title "Sauvegarde echoue"'
    exit 1
fi

# -------- Fin de sauvegarde --------
echo "Sauvegarde terminee le : $(date)" | tee -a "$LOG_FILE"
echo "----------------------------------------" >> "$LOG_FILE"

# Notification de succes
osascript -e '-- display notification "Sauvegarde complete reussie !" with title "Sauvegarde Terminee --"'
