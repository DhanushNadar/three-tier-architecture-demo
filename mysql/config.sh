#!/bin/sh

DIR="/etc/mysql"

# Locate the configuration file containing 'datadir'
FILE=$(grep -Rl "^datadir" "$DIR")

if [ -n "$FILE" ]; then
    echo " "
    echo "Updating $FILE to use /data/mysql"
    echo " "
    
    # Update datadir path
    sed -i -e 's|^datadir\s*=\s*/var/lib/mysql|datadir = /data/mysql|' "$FILE"

    # Verify changes
    grep -R "^datadir" "$DIR"
else
    echo " "
    echo "MySQL config file with datadir not found"
    echo " "
fi

# Ensure the data directory exists
mkdir -p /data/mysql

# Set correct ownership
chown -R mysql:mysql /data/mysql
