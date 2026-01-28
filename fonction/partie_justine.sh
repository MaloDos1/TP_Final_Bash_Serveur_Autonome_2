source ./TP_Final_Bash_Serveur_Autonome_2_main.sh

#Journalisation et robustesse

## Fonction de journalisation standardisée

cd /var/log
echo= "=== Création d'un répertoire maintenance ==="
mkdir maintenance ## Création du répertoire de log nommé "maintenance"
cd maintenance

echo "Début de la maintenance" >> "maintenance_$(date+%Y%m%d_%H%M%S).log"