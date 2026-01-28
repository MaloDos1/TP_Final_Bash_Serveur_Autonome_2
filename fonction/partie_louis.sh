#!/bin/bash

# Pour vérifier l'espace du disque 
echo " Etat de la partition /boot "
df -h | grep "/boot" 

echo ""

# Pour vérifier espace libre RAM 
echo " Utilisation de la RAM " 
free -m 

echo "" 