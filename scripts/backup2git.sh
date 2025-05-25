#!/bin/bash
set -e

SSH_DIR="/root/.ssh"
REPO_DIR="/config"
CONFIG_FILE="/config/scripts/git_backup_config.env"

# Laad configuratie (email, naam, repo-url) uit extern bestand
if [ -f "$CONFIG_FILE" ]; then
  source "$CONFIG_FILE"
else
  echo "Config file $CONFIG_FILE niet gevonden!"
  exit 1
fi

# Kopieer de bestaande private key naar .ssh/id_rsa
mkdir -p "$SSH_DIR"
cp /config/scripts/id_rsa "$SSH_DIR/id_rsa"
chmod 600 "$SSH_DIR/id_rsa"

# Voeg github.com toe aan known_hosts zodat ssh connectie werkt zonder prompt
ssh-keyscan github.com >> "$SSH_DIR/known_hosts"
chmod 644 "$SSH_DIR/known_hosts"

# Git configuratie
git config --global user.email "$GIT_USER_EMAIL"
git config --global user.name "$GIT_USER_NAME"

cd "$REPO_DIR"

# Voeg alles toe en commit
git add .
git commit -m "Automatische backup $(date '+%Y-%m-%d %H:%M:%S')"

# Push met SSH
GIT_SSH_COMMAND="ssh -i $SSH_DIR/id_rsa -o IdentitiesOnly=yes" git push "$GIT_REPO_URL" master
