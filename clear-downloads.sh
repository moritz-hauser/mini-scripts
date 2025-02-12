#!/bin/bash

# -------- FUNCTIONS ----------
# Print usage in case of misinput
usage() {
	echo "Usage: $0 [-d || -l]"
}
# Display status of Downloads folder
downloads_status() {
	files=$(ls -A "$HOME/Downloads")
	if [ -z "$files" ]; then
		echo "Downloads is now empty."
	else
		echo "Downloads now contains: "
		echo "$files"
	fi 
}
# Ask for permission for each file individually, then remove them
clear_and_ask() {
	# Durch Dateien iterieren
	for file in "$HOME/Downloads"/*; do
		# If file does not exist (Downloads is emtpy) -> continue
		[ -e "$file" ] || continue
		echo "Datei: $(basename "$file")"
		# Nach Erlaubnis fragen
		read -p "Datei löschen? (y/n) " choice
		if [ "$choice" = "y" ]; then 
			rm -v -- "$file"
		fi
	done
	echo "All files processed."
}
# Remove all duplicate files in the folder
clear_duplicates() {
	# TODO 
	echo "clear_duplicates called"
}
# Print list, then ask which files *not* to delete
clear_and_ask_list() {
	# TODO
	echo "clear_and_ask_list called"
}

# ----------- LOGIC -----------
# Find Downloads folder
if [ ! -d "$HOME/Downloads" ]; then
	echo "Error: Downloads folder cannot be found."
	exit 1
fi

# Check amount of arguments
if [ $# -gt 1 ]; then
	usage
	exit 1
fi

# Handle arguments
option_found=0
while getopts ":dl" flag; do
	case "$flag" in
		d) clear_duplicates; option_found=1 ;;
		l) clear_and_ask_list; option_found=1 ;;
		\?) usage; exit 1 ;;
	esac
done

# No arguments provided
if [ "$option_found" -eq 0 ]; then
	clear_and_ask
fi

# Display status of Downloads folder after execution
downloads_status
