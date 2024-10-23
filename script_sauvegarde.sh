#!/bin/bash

# Configuration
BACKUP_DIR="/path/to/backup"  # Chemin du dossier de sauvegarde
WEB_DIR="/var/www/html"  # Chemin des fichiers du serveur web
DB_USER="db_user"  # Utilisateur MySQL
DB_PASSWORD="db_password"  # Mot de passe MySQL
DB_NAME="database_name"  # Nom de la base de données

# Création d'un nom de fichier pour la sauvegarde avec la date
DATE=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE="${BACKUP_DIR}/backup_${DATE}.tar.gz"

# Sauvegarde des fichiers du serveur web
echo "Sauvegarde des fichiers du serveur web..."
tar -czf ${BACKUP_DIR}/web_backup_${DATE}.tar.gz ${WEB_DIR}

# Sauvegarde de la base de données MySQL
echo "Sauvegarde de la base de données MySQL..."
mysqldump -u ${DB_USER} -p${DB_PASSWORD} ${DB_NAME} > ${BACKUP_DIR}/db_backup_${DATE}.sql

# Compresser les deux sauvegardes dans une archive
echo "Compression des fichiers de sauvegarde..."
tar -czf ${BACKUP_FILE} -C ${BACKUP_DIR} web_backup_${DATE}.tar.gz db_backup_${DATE}.sql

# Supprimer les fichiers individuels après compression
rm ${BACKUP_DIR}/web_backup_${DATE}.tar.gz
rm ${BACKUP_DIR}/db_backup_${DATE}.sql

echo "Sauvegarde terminée et stockée dans ${BACKUP_FILE}"
