#!/data/data/com.termux/files/usr/bin/bash

# =============================
# WARNA
# =============================
MERAH="\e[31m"
HIJAU="\e[32m"
KUNING="\e[33m"
BIRU="\e[34m"
RESET="\e[0m"

# =============================
# HEADER
# =============================
header() {
    clear
    figlet -f slant "HACK PANEL" | lolcat
    echo -e "${MERAH}========================================${RESET}"
    echo -e "${HIJAU}   Ethical Hacking Learning Dashboard   ${RESET}"
    echo -e "${MERAH}========================================${RESET}"
    echo
}

# =============================
# MENU UTAMA
# =============================
menu_utama() {
    echo -e "${KUNING}1.${RESET} Hacking Menu"
    echo -e "${KUNING}2.${RESET} System Info"
    echo -e "${KUNING}0.${RESET} Exit"
    echo
}

# =============================
# SUBMENU HACKING
# =============================
menu_hacking() {
    while true
    do
        header
        echo -e "${BIRU}1.${RESET} Info Sistem"
        echo -e "${BIRU}2.${RESET} Lihat IP Device"
        echo -e "${BIRU}3.${RESET} Scan Port Localhost"
        echo -e "${BIRU}0.${RESET} Kembali"
        echo
        read -p "Pilih submenu: " hack

        case $hack in
            1)
                uname -a
                ;;
            2)
                ip addr || ifconfig
                ;;
            3)
                pkg install nmap -y
                nmap 127.0.0.1
                ;;
            0)
                break
                ;;
            *)
                echo -e "${MERAH}Pilihan salah!${RESET}"
                ;;
        esac
        read -p "ENTER untuk lanjut..."
    done
}

# =============================
# PROGRAM UTAMA
# =============================
while true
do
    header
    menu_utama
    read -p "Pilih menu: " pilih

    case $pilih in
        1)
            menu_hacking
            ;;
        2)
            uname -a
            read -p "ENTER untuk kembali..."
            ;;
        0)
            echo -e "${MERAH}Keluar...${RESET}"
            exit
            ;;
        *)
            echo -e "${MERAH}Menu tidak ada!${RESET}"
            read -p "ENTER..."
            ;;
    esac
done
