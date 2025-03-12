#!/bin/bash

# Dieses Skript wird im Container ausgeführt, um das richtige Repository zu klonen
set -e

# Wechsle ins Home-Verzeichnis des Benutzers abc
cd /config
# Repository-Auswahl aus Umgebungsvariable
echo -e "Repository-Auswahl aus Umgebungsvariable: $DESKTOP_INSTALLATION"
REPO_CHOICE=${DESKTOP_INSTALLATION}

# Wenn die Wahl leer ist, Standard auf "Nichts" setzen
if [ -z "$REPO_CHOICE" ]; then
    REPO_CHOICE="Nichts"
    echo "Keine Repository-Auswahl angegeben, verwende Standard-Option: $REPO_CHOICE"
fi

echo "Repository-Auswahl: $REPO_CHOICE"

# Behandlung der verschiedenen Optionen
case "$REPO_CHOICE" in
    "Nichts")
        echo "Keine Repositories werden ausgecheckt."
        ;;
        
    "VS_Pattern")
        echo "Clone VS_Pattern Repository..."
        if [ -d "VS_Pattern_By_KI" ]; then
            echo "Repository existiert bereits, update wird durchgeführt..."
            cd VS_Pattern_By_KI
            git fetch
            git pull
            cd ..
        else
            git clone https://github.com/scimbe/VS_Pattern_By_KI.git
        fi
        
        # Installiere JDK für VS_Pattern
        echo "Installiere default-jdk für VS_Pattern..."
        apt-get update
        apt-get install -y default-jdk
        ;;
        
    "VS_Script")
        echo "Clone VS_Script Repository..."
        if [ -d "vs_script" ]; then
            echo "Repository existiert bereits, update wird durchgeführt..."
            cd vs_script
            git fetch
            git pull
            cd ..
        else
            git clone https://github.com/scimbe/vs_script.git
        fi
        ;;
        
    "Alles")
        echo "Clone VS_Pattern Repository..."
        if [ -d "VS_Pattern_By_KI" ]; then
            echo "Repository existiert bereits, update wird durchgeführt..."
            cd VS_Pattern_By_KI
            git fetch
            git pull
            cd ..
        else
            git clone https://github.com/scimbe/VS_Pattern_By_KI.git
        fi
        
        echo "Clone VS_Script Repository..."
        if [ -d "vs_script" ]; then
            echo "Repository existiert bereits, update wird durchgeführt..."
            cd vs_script
            git fetch
            git pull
            cd ..
        else
            git clone https://github.com/scimbe/vs_script.git
        fi
        ;;

    *)
        echo "Ungültige Repository-Auswahl: $REPO_CHOICE"
        echo "Gültige Optionen sind: Nichts, VS_Pattern, VS_Script, Alles"
        exit 1
        ;;
esac

# Setze Berechtigungen
chown -R abc:abc /config/home/abc

echo "Repository-Auschecken abgeschlossen."