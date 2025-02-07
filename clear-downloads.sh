#!/bin/bash
# Downloads Ordner finden
if [ ! -d "$HOME/Downloads" ]; then
	echo "Error: Downloads folder cannot be found."
	exit 1
fi

# Durch Dateien iterieren
for file in "$HOME/Downloads"/*; do
	[ -e "$file" ] || continue
	
	echo "Datei: $(basename "$file")" # Nur Dateinamen anzeigen
	
	# Nach Erlaubnis fragen
	read -p "Datei löschen? (y/n) " choice
	if [ "$choice" == "y" ]; then 
		rm -v -- "$file"
	fi
done

echo "---"
echo "Done."
exit 0
