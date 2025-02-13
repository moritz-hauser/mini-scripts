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
	# Iterate folder
	for file in "$HOME/Downloads"/*; do
		# If not a file -> continue
		[ -e "$file" ] || continue
		[ -f "$file" ] || continue
		echo "Datei: $(basename "$file")"
		# Ask permission
		read -p "Remove file? (y/n) " choice
		if [ "$choice" = "y" ]; then 
			rm -v -- "$file"
		fi
	done
	echo "All files processed."
}
# Remove all duplicate files in the folder
clear_duplicates() {
	# Declare associative array (key: hash, value: file)
	declare -A file_hashes
	# Iterate folder
	for file in "$HOME/Downloads"/*; do
		# If not a file -> continue
		[ -e "$file" ] || continue
		[ -f "$file" ] || continue
		# Get hash of file
		hash=$(sha256sum "$file" | awk '{print $1}')
        	if [[ -n "${file_hashes[$hash]}" ]]; then
        		# Array already contains hash -> delete file
            		rm -v -- "$file"
        	else
        		# Array does not contain hash -> add hash
            		file_hashes[$hash]="$file"
        	fi
        done
	echo "---"
}
# Print list, then ask which files *not* to delete
clear_and_ask_list() {
	# 1. Create array containg all files
	declare -a files=()
	for file in "$HOME/Downloads"/*; do
		# If not a file -> continue
		[ -e "$file" ] || continue
		[ -f "$file" ] || continue
		# Add file to array
		files+=("$file")
	done
	# 2. Print array (with indexes)
	echo "Found ${#files[@]} files:"
	for i in "${!files[@]}"; do
        	echo "[$i] $(basename "${files[$i]}")"
    	done
	# 3. Read input
	echo -e "\nInput indexes of files to keep."
    	echo "Separated by spaces. Example: 2 4 13"
    	read -p "Indexes to keep: " -a indexes_to_keep
	# 4. Iterate files and delete those not listed
    	for file_index in "${!files[@]}"; do
    		# Check whether user wants to keep this file
        	keep=false
        	for index_keep in "${indexes_to_keep[@]}"; do
            		if [[ "$index_keep" == "$file_index" ]]; then
                		keep=true
                		break
            		fi
        	done
        	# Delete file
        	if [ "$keep" = false ]; then
            		rm -v -- "${files[$file_index]}"
		fi
    	done
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

# Check if Downloads is empty
if [ -z "$(find "$HOME/Downloads" -type f)" ]; then
    echo "Downloads does not contain any files."
    exit 0
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
