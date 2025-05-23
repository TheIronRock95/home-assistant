#!/bin/bash

# Pad naar het bestand met de Home Assistant-versie
HA_VERSION=$(cat /data/config/.HA_VERSION)

# Huidige datum en tijd
COMMIT_DATE=$(date +'%d-%m-%Y %H:%M:%S')

# Bericht opstellen
COMMIT_MESSAGE="Autocommit from HA - [$HA_VERSION]: $COMMIT_DATE"

# Bericht tonen in terminal/log
echo "$COMMIT_MESSAGE"

# Git-commando's uitvoeren
cd /data/config
git add .
git commit -m "$COMMIT_MESSAGE"
git push
