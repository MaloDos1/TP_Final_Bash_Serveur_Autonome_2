#!/bin/bash

LOG_FILE="/var/log/serveur_autonome.log"

log_message() {
    local level="$1"
    local message="$2"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $message" >> "$LOG_FILE"
}

sauvegarde_dynamique() {
    
    CIBLE="/usr/local/bin"
    
    if [ -z "$CIBLE" ]; then
        log_message "ERROR" "Répertoire cible non défini"
        return 102
    fi
    
    if [ ! -e "$CIBLE" ]; then
        log_message "ERROR" "Le répertoire $CIBLE n'existe pas"
        return 102
    fi
    
    if [ ! -d "$CIBLE" ]; then
        log_message "ERROR" "$CIBLE n'est pas un répertoire"
        return 102
    fi
    
    DEST_DIR="/mnt/sauvegardes"
    
    if [ ! -d "$DEST_DIR" ]; then
        mkdir -p "$DEST_DIR"
        if [ $? -ne 0 ]; then
            log_message "ERROR" "Impossible de créer $DEST_DIR"
            return 102
        fi
    fi
    
    NOM_REP=$(basename "$CIBLE")
    TIMESTAMP=$(date '+%Y_%m_%d_%H%M%S')
    ARCHIVE_NAME="${NOM_REP}_${TIMESTAMP}.tar.bz2"
    ARCHIVE_PATH="${DEST_DIR}/${ARCHIVE_NAME}"
    
    tar -cjf "$ARCHIVE_PATH" -C "$(dirname "$CIBLE")" "$(basename "$CIBLE")" 2>/dev/null
    
    if [ $? -eq 0 ]; then
        log_message "INFO" "Archive créée : $ARCHIVE_PATH"
    else
        log_message "ERROR" "Erreur création archive"
        return 102
    fi
    
    TEMP_DIR="/tmp/backup_verif_$$"
    mkdir -p "$TEMP_DIR"
    cp -r "$CIBLE"/* "$TEMP_DIR/" 2>/dev/null
    
    SSH_CONFIG="/etc/ssh/sshd_config"
    SSH_CONFIG_REF="/tmp/sshd_config.ref"
    
    if [ -f "$SSH_CONFIG" ]; then
        if [ -f "$SSH_CONFIG_REF" ]; then
            diff "$SSH_CONFIG" "$SSH_CONFIG_REF" > /dev/null 2>&1
            if [ $? -ne 0 ]; then
                log_message "WARNING" "Fichier $SSH_CONFIG différent de la référence"
            fi
        else
            cp "$SSH_CONFIG" "$SSH_CONFIG_REF" 2>/dev/null
        fi
    fi
    
    rm -rf "$TEMP_DIR"
    
    return 0
}

export -f sauvegarde_dynamique
export -f log_message

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    sauvegarde_dynamique
    exit $?
fi