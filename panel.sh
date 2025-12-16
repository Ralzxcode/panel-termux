#!/bin/bash
clear

RED='\033[1;31m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m'

echo -e "${RED}"
echo "██╗  ██╗ █████╗  ██████╗██╗  ██╗"
echo "██║  ██║██╔══██╗██╔════╝██║ ██╔╝"
echo "███████║███████║██║     █████╔╝ "
echo "██╔══██║██╔══██║██║     ██╔═██╗ "
echo "██║  ██║██║  ██║╚██████╗██║  ██╗"
echo "╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝"
echo -e "${WHITE}        PANEL TERMUX by Ralzxc0de${NC}"
echo ""

echo -e "${CYAN}[1] Info System"
echo "[2] Update Packages"
echo "[3] Install Tools"
echo "[4] Exit${NC}"
echo ""

read -p "Pilih menu > " menu

case $menu in
1)
  echo -e "${GREEN}User   : $(whoami)"
  echo "OS     : $(uname -o)"
  echo "Kernel : $(uname -r)${NC}"
;;
2)
  pkg update && pkg upgrade -y
;;
3)
  pkg install git curl wget nano -y
;;
4)
  echo "Bye..."
  exit
;;
*)
  echo "Pilihan salah!"
;;
esac

