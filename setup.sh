#!/bin/bash

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

# Trap Ctrl+C, Ctrl+Z, Ctrl+\ signals
trap '' SIGINT SIGTSTP SIGQUIT

clear
echo -e "${YELLOW}Setting up Terminal Lock...${NC}"

# Ask for password
echo -n -e "${YELLOW}Set a password for your terminal lock: ${NC}"
read -s password
echo

# Create .termlock script
cat > "$HOME/.termlock" <<EOF
#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

trap '' SIGINT SIGTSTP SIGQUIT

echo -n -e "\${YELLOW}Please enter your password: \${NC}"
read -s input_password

if [ "\$input_password" == "$password" ]; then
    echo -e "\n\${GREEN}Access granted.\${NC}"
else
    echo -e "\n\${RED}Incorrect password. Access denied.\${NC}"
    kill -9 \$PPID
fi
EOF

chmod +x "$HOME/.termlock"

echo -e "${GREEN}.termlock created successfully.${NC}"

# Add .termlock to startup files
TERML_START="# >>> terminal lock >>>"
TERML_END="# <<< terminal lock <<<"
TERML_CODE="[ -f \$HOME/.termlock ] && bash \$HOME/.termlock"

RC_FILES=(
    "$HOME/.bashrc"
    "$HOME/.zshrc"
    "$HOME/.profile"
    "$HOME/.bash_profile"
    "$HOME/.config/fish/config.fish"
)

for rc in "${RC_FILES[@]}"; do
    if [ -f "$rc" ]; then
        if ! grep -q ".termlock" "$rc"; then
            {
                echo ""
                echo "$TERML_START"
                echo "$TERML_CODE"
                echo "$TERML_END"
            } >> "$rc"
            echo -e "${GREEN}Terminal lock added to ${rc}.${NC}"
        else
            echo -e "${YELLOW}Terminal lock already present in ${rc}.${NC}"
        fi
    fi
done

echo -e "${GREEN}Terminal Lock setup completed successfully!${NC}"
