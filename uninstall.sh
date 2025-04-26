#!/bin/bash

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

clear
echo -e "${YELLOW}Uninstalling Terminal Lock...${NC}"

# Remove .termlock
if [ -f "$HOME/.termlock" ]; then
    rm "$HOME/.termlock"
    echo -e "${GREEN}.termlock removed.${NC}"
else
    echo -e "${YELLOW}.termlock not found. Skipping.${NC}"
fi

# RC files to clean
RC_FILES=(
    "$HOME/.bashrc"
    "$HOME/.zshrc"
    "$HOME/.profile"
    "$HOME/.bash_profile"
    "$HOME/.config/fish/config.fish"
)

for rc in "${RC_FILES[@]}"; do
    if [ -f "$rc" ]; then
        if grep -q ">>> terminal lock >>>" "$rc"; then
            # Remove the block between the markers
            sed -i.bak '/# >>> terminal lock >>>/,/# <<< terminal lock <<</d' "$rc"
            echo -e "${GREEN}Cleaned terminal lock entry from ${rc}.${NC}"
        else
            echo -e "${YELLOW}No terminal lock entry found in ${rc}.${NC}"
        fi
    fi
done

echo -e "${GREEN}Terminal Lock uninstalled successfully!${NC}"

