#!/bin/bash

# Configuration
PTERO_VOLUME="/var/lib/pterodactyl/volumes/0dbca6f3-965c-4b3f-86a2-0f9b599d3547"
SOURCE_DIR="$(pwd)"
ARCHIVE_NAME="php-bin.tar.gz"

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}[1/6]${NC} Création de l'archive..."
tar -czvhf "$ARCHIVE_NAME" bin/ > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo -e "${RED}Erreur: Impossible de créer l'archive${NC}"
    exit 1
fi
echo -e "${GREEN}OK${NC}"

echo -e "${YELLOW}[2/6]${NC} Copie vers Pterodactyl..."
sudo cp "$ARCHIVE_NAME" "$PTERO_VOLUME/"
if [ $? -ne 0 ]; then
    echo -e "${RED}Erreur: Impossible de copier vers $PTERO_VOLUME${NC}"
    exit 1
fi
echo -e "${GREEN}OK${NC}"

echo -e "${YELLOW}[3/6]${NC} Suppression de l'ancien bin..."
sudo rm -rf "$PTERO_VOLUME/bin/"
echo -e "${GREEN}OK${NC}"

echo -e "${YELLOW}[4/6]${NC} Extraction..."
cd "$PTERO_VOLUME"
sudo tar -xzvf "$ARCHIVE_NAME" > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo -e "${RED}Erreur: Impossible d'extraire l'archive${NC}"
    exit 1
fi
echo -e "${GREEN}OK${NC}"

echo -e "${YELLOW}[5/6]${NC} Permissions..."
sudo chown -R pterodactyl:pterodactyl bin/
echo -e "${GREEN}OK${NC}"

echo -e "${YELLOW}[6/6]${NC} Nettoyage..."
sudo rm "$PTERO_VOLUME/$ARCHIVE_NAME"
rm "$SOURCE_DIR/$ARCHIVE_NAME"
echo -e "${GREEN}OK${NC}"

echo ""
echo -e "${GREEN}Déploiement terminé !${NC}"
echo -e "PHP déployé dans: ${YELLOW}$PTERO_VOLUME/bin/php7/${NC}"
