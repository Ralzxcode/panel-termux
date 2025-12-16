#!/data/data/com.termux/files/usr/bin/bash

echo "[+] Update system"
pkg update && pkg upgrade -y

echo "[+] Install tools"
pkg install figlet lolcat nmap git python -y

echo "[✓] Install selesai"
