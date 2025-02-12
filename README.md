# mini-scripts
Eine Sammlung kleiner Skripte, die praktische Alltagsaufgaben automatisieren.  
Einige Skripte werden zu Übungszwecken in mehreren Sprachen implementiert.

### **clear-downloads.sh**
- Skript zum Aufräumen des Downloads Ordners
- Usage: ./clear-downloads.sh [-d || -l]
- Flags:
	- Ohne Flag: Fragt vor dem Löschen jeder Datei um Erlaubnis
	- "-d" : Löscht alle Duplikate
	- "-l" : Gibt eine Liste aus, fragt welche Dateien *nicht* gelöscht werden sollen

### **clear-downloads.py**
- Löscht alle Dateien aus dem Downloads Ordner
- Fragt vor jedem Löschvorgang um Erlaubnis (y/n)
