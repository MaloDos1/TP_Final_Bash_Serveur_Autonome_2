#!/bin/bash

partie_malo() {


inactif=60

liste=$(find /home -maxdepth 1 -mindepth 1 -type d -atime +$inactif)


if [ -z "$liste" ]; then
    echo "Aucun dossier inactif trouvé."
    exit 0
fi


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
}