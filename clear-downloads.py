#!/usr/bin/env python3
import os

downloads_path = os.path.expanduser("~/Downloads")

if not os.path.exists(downloads_path):
	print("Fehler: Download-Ordner nicht gefunden.")
	exit(1)
	
print("Download-Ordner gefunden.")

# Dateien im Verzeichnis auflisten
files = os.listdir(downloads_path)

# Falls Ordner leer ist:
if not files:
	print("Der Download-Ordner ist leer.")
	exit(0)
	
# Durch Dateien iterieren 
for file in files:
	file_path = os.path.join(downloads_path, file)
	
	# Ordner überspringen
	if not os.path.isfile(file_path):
		continue
		
	print(f"Datei: {file}")
	
	choice = input("Datei löschen? (y/n) ").strip().lower()
	if choice == "y":
		os.remove(file_path)
		print(f"{file} wurde gelöscht.")

print("---")
print("Done.")
	
	
	
	
