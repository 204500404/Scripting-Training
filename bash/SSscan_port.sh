#!/bin/bash

# Defininition des couleurs
GREEN="\e[32m"
RED="\e[31m"
NC="\e[0m"

# Verifier si le script est execute en tant que root
if [ "$UID" -ne 0 ]; then
    echo -e "${RED}Erreur : Ce script doit etre execute en tant que root (sudo).${NC}" >&2
    exit 1
fi

echo -e "${GREEN}Debut du script...${NC}"
echo "Scan des ports ouverts localement avec ss..."
echo "---------------------------------------------"

# Scanne les ports, les affiches, puis tri des ports.
ss -tuln | awk 'NR > 1 {
    split($5, a, ":")
    port = a[length(a)]
    proto = tolower($1)
    if (port ~ /^[0-9]+$/) {
        printf "%s %s\n", proto, port
    }
}' | sort -k1,1 -k2n | awk '
BEGIN {
    print "Ports ouverts :"
    print "----------------"
    current_proto = ""
}
{
    if ($1 != current_proto) {
        current_proto = $1
        print "\nProtocole " toupper(current_proto) ":"
    }
    print "  Port " $2 " ouvert\n"
}'
