#!/bin/bash


inactif=60

liste=$(find /home -maxdepth 1 -mindepth 1 -type d -atime +$inactif)

# 2. Si la liste est vide (-z), on arrête le script ici
if [ -z "$liste" ]; then
    echo "Aucun dossier inactif trouvé."
    exit 0
fi

# 3. Sinon, on affiche la liste
echo "Voici les dossiers inactifs :"
echo "$liste"
echo "---------------------------"

# 4. Demande de confirmation
read -p "Voulez-vous agir sur ces dossiers ? (o/n) : " reponse

if [ "$reponse" = "o" ]; then
    echo "Action validée !"

else
    echo "Annulé."
fi