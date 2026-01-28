#!/bin/bash
# 1. On "source" les fichiers externes
# Cela permet d'utiliser les fonctions définies dans les autres fichiers
# Attention : le dossier s'appelle "fonction" (singulier) sur ton image
source ./fonction/partie_justine.sh
source ./fonction/partie_louis.sh
source ./fonction/partie_malo.sh
source ./fonction/partie_mathis.sh
echo "=== Démarrage du Serveur Autonome ==="

# Ici, tu appelleras plus tard les fonctions créées par tes collègues.
# Exemple imaginaire :
# initialiser_justine
# lancer_serveur_malo
# verifier_logs_louis
echo "=== Fin du script ==="
