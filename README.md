# Task_Monitoring
Script pour l'automatisation des sauvegardes quotidiennes d'un serveur web. Ce script permet de sauvegarder les fichiers du serveur web ainsi que la base de données MySQL, puis de les compresser et les stocker de manière sécurisée.


Étape 1 : Script de sauvegarde


```bash
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
```


Étape 2 : Automatiser les sauvegardes avec cron
Pour que ce script soit exécuté quotidiennement de manière automatique, tu peux utiliser cron, un planificateur de tâches sous Linux.

1. Ouvre la configuration de cron :

```bash
crontab -e
```

2. Ajoute la ligne suivante pour exécuter la sauvegarde tous les jours à 2h du matin :

```bash
0 2 * * * /chemin/vers/script_sauvegarde.sh
```

Cela planifie le script pour qu'il s'exécute automatiquement tous les jours à 2h du matin.


*Fonctionnement :*

-Sauvegarde des fichiers : Le script compresse les fichiers de ton serveur web dans une archive `.tar.gz`.
-Sauvegarde de la base de données : Il exporte la base de données MySQL dans un fichier `.sql`.
-Compression : Les fichiers sauvegardés (serveur web + base de données) sont ensuite compressés ensemble dans une archive avec un horodatage pour faciliter l'identification des sauvegardes.
-Suppression des fichiers temporaires : Après avoir créé l'archive finale, les fichiers individuels sont supprimés.

*Personnalisation :*
`BACKUP_DIR :` Modifie le chemin où tu souhaites stocker les sauvegardes.
`WEB_DIR :` Le chemin où sont stockés tes fichiers web.
`DB_USER, DB_PASSWORD, DB_NAME :` Les informations de connexion à ta base de données.

*Sécurité :*
-Il est recommandé de stocker le dossier de sauvegarde sur un serveur séparé ou un espace de stockage sécurisé pour protéger tes données en cas de panne ou d'attaque sur le serveur principal.
