#!/bin/bash

LOG_FILE="/var/log/serveur_autonome.log"

log_message() {
    local niveau="$1"
    local texte="$2"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$niveau] $texte" >> "$LOG_FILE"
}

sauvegarde_dynamique() {
    local repertoire_source="/usr/local/bin"
    local repertoire_backup="/mnt/sauvegardes"
    
    if [ ! -d "$repertoire_source" ]; then
        log_message "ERREUR" "Le dossier $repertoire_source n'existe pas"
        return 1
    fi
    
    mkdir -p "$repertoire_backup"
    
    local nom_fichier=$(basename "$repertoire_source")
    local horodatage=$(date '+%Y-%m-%d_%H%M%S')
    local archive="${repertoire_backup}/${nom_fichier}_${horodatage}.tar.bz2"
    
    tar -cjf "$archive" -C "$(dirname "$repertoire_source")" "$nom_fichier" 2>/dev/null
    
    if [ $? -eq 0 ]; then
        log_message "INFO" "Sauvegarde créée : $archive"
        return 0
    else
        log_message "ERREUR" "Échec de la création de l'archive"
        return 1
    fi
}

export -f sauvegarde_dynamique
export -f log_message
