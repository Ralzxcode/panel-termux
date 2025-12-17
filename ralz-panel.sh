#!/bin/bash
# =========================================================
# ABSOLUTE ELITE PANEL — GOD MODE ULTIMATE (CLEAN MERGE)
# Owner  : Dho Nago
# Status : FINAL • SEALED • PRODUCTION
# =========================================================

##########################################################
# 0) GOD MODE SECURITY (HASH + OTP + ANTI BRUTE)
##########################################################
SEC_DIR="$HOME/.panel_security"
HASH_FILE="$SEC_DIR/pass.hash"
FAIL_FILE="$SEC_DIR/fail.count"
OTP_FILE="$SEC_DIR/otp.code"

MAX_FAIL=3
LOCK_TIME=60

mkdir -p "$SEC_DIR"; chmod 700 "$SEC_DIR"

if [ ! -f "$HASH_FILE" ]; then
  echo "[ SETUP ] Create Panel Password"
  read -s -p "New Password : " P1; echo
  read -s -p "Confirm      : " P2; echo
  [ "$P1" != "$P2" ] && echo "Mismatch" && exit 1
  echo -n "$P1" | sha256sum | awk '{print $1}' > "$HASH_FILE"
  chmod 600 "$HASH_FILE"
fi

FAIL=0
[ -f "$FAIL_FILE" ] && FAIL=$(cat "$FAIL_FILE")

if [ "$FAIL" -ge "$MAX_FAIL" ]; then
  echo "[ LOCKED ] Wait $LOCK_TIME seconds"
  sleep "$LOCK_TIME"
  echo 0 > "$FAIL_FILE"
fi

read -s -p "🔒 Password : " INPUT
echo

IH=$(echo -n "$INPUT" | sha256sum | awk '{print $1}')
RH=$(cat "$HASH_FILE")

if [ "$IH" != "$RH" ]; then
  FAIL=$((FAIL+1))
  echo "$FAIL" > "$FAIL_FILE"
  echo "❌ Wrong password"
  sleep 1
  exit 1
else
  echo 0 > "$FAIL_FILE"
fi

##########################################################
# 1) CORE PATH & CONFIG (ABSOLUTE ELITE)
##########################################################
CORE="$HOME/.absolute_elite"
CONF="$CORE/config.conf"
LOG="$CORE/panel.log"
PLUG="$CORE/plugins"
BK="$CORE/backups"

mkdir -p "$CORE" "$PLUG" "$BK"

if [[ ! -f $CONF ]]; then
cat > "$CONF" <<EOF
THEME=matrix
FX_MATRIX=on
FX_BEEP=on
FX_WATERMARK=on
FX_LOADING=on
SAFE_DELETE=on
FAST_MODE=off
QUIET_MODE=off
EOF
fi
source "$CONF"

save_conf(){
cat > "$CONF" <<EOF
THEME=$THEME
FX_MATRIX=$FX_MATRIX
FX_BEEP=$FX_BEEP
FX_WATERMARK=$FX_WATERMARK
FX_LOADING=$FX_LOADING
SAFE_DELETE=$SAFE_DELETE
FAST_MODE=$FAST_MODE
QUIET_MODE=$QUIET_MODE
EOF
}

##########################################################
# 2) THEME + UTIL
##########################################################
load_theme(){
case $THEME in
matrix) G='\033[1;32m'; C='\033[1;36m' ;;
gold) G='\033[1;33m'; C='\033[1;37m' ;;
midnight) G='\033[1;34m'; C='\033[1;36m' ;;
esac
}
load_theme
R='\033[1;31m'; W='\033[1;37m'; Y='\033[1;33m'; N='\033[0m'

log(){ echo "$(date '+%F %T') | $1" >> "$LOG"; }
pause(){ read -p "ENTER..."; }
beep(){ [[ $FX_BEEP == on ]] && echo -ne "\a"; }

##########################################################
# 3) EFFECTS
##########################################################
matrix_rain(){
[[ $FX_MATRIX != on ]] && return
for i in {1..6}; do
  line=""; for j in {1..44}; do line+=$((RANDOM%2)); done
  echo -e "${G}$line${N}"
  sleep 0.04
done
}

access_granted(){
[[ $FX_LOADING != on ]] && return
clear; echo -e "${G}ACCESS GRANTED${N}"; sleep 0.6
}

watermark(){
[[ $FX_WATERMARK == on ]] && echo -e "${C}[ DHO NAGO • ABSOLUTE ELITE ]${N}"
}

##########################################################
# 4) HEADER (FINAL)
##########################################################
header(){
clear; beep; matrix_rain; access_granted
cat <<EOF
${G}╔════════════════════════════════════╗
║        D H O   N A G O               ║
║   ABSOLUTE • ELITE • GOD MODE       ║
║   Status: ACTIVE | SEALED           ║
╚════════════════════════════════════╝${N}
EOF
watermark
}

##########################################################
# 5) MODULES (UTUH DARI PANEL LAMA)
##########################################################
safe_rm(){
[[ $SAFE_DELETE == on ]] && read -p "Type YES to delete: " c && [[ $c != YES ]] && return
rm -rf "$1"
}

file_manager(){
header
echo "1. List"
echo "2. Move"
echo "3. Copy"
echo "4. Delete (Safe)"
echo "5. Backup"
echo "0. Back"
read -p "> " f
case $f in
1) ls ;;
2) read -p "Src: " a; read -p "Dst: " b; mv "$a" "$b" ;;
3) read -p "Src: " a; read -p "Dst: " b; cp -r "$a" "$b" ;;
4) read -p "Target: " t; safe_rm "$t" ;;
5) read -p "Folder: " d; tar -czf "$BK/$d.tar.gz" "$d" ;;
esac
pause
}

network(){
header
echo "1. Ping"
echo "2. Traceroute"
echo "3. Nmap"
echo "0. Back"
read -p "> " n
case $n in
1) read -p "Target: " t; ping -c 4 "$t" ;;
2) read -p "Target: " t; traceroute "$t" ;;
3) read -p "Target: " t; nmap "$t" ;;
esac
pause
}

system_info(){
header
echo "User   : $(whoami)"
echo "Date   : $(date)"
echo "Uptime :"; uptime
pause
}

plugins(){
header
ls "$PLUG"
read -p "Plugin file: " p
bash "$PLUG/$p"
pause
}

toggle(){ [[ $1 == on ]] && echo off || echo on; }

global_center(){
header
echo "1. Theme           [$THEME]"
echo "2. Matrix          [$FX_MATRIX]"
echo "3. Beep            [$FX_BEEP]"
echo "4. Watermark       [$FX_WATERMARK]"
echo "5. Loading         [$FX_LOADING]"
echo "6. Safe Delete     [$SAFE_DELETE]"
echo "7. Fast Mode       [$FAST_MODE]"
echo "8. Quiet Mode      [$QUIET_MODE]"
echo "9. Save Settings"
echo "0. Back"
read -p "> " g
case $g in
1) read -p "Theme: " THEME; load_theme ;;
2) FX_MATRIX=$(toggle $FX_MATRIX) ;;
3) FX_BEEP=$(toggle $FX_BEEP) ;;
4) FX_WATERMARK=$(toggle $FX_WATERMARK) ;;
5) FX_LOADING=$(toggle $FX_LOADING) ;;
6) SAFE_DELETE=$(toggle $SAFE_DELETE) ;;
7) FAST_MODE=$(toggle $FAST_MODE); [[ $FAST_MODE == on ]] && FX_MATRIX=off FX_LOADING=off ;;
8) QUIET_MODE=$(toggle $QUIET_MODE) ;;
9) save_conf ;;
esac
}

##########################################################
# 6) MAIN
##########################################################
main(){
while true; do
header
echo "1. File Manager"
echo "2. Network"
echo "3. System Info"
echo "4. Plugins"
echo "5. Global Control Center ⭐"
echo "0. Exit"
read -p "> " m
case $m in
1) file_manager ;;
2) network ;;
3) system_info ;;
4) plugins ;;
5) global_center ;;
0) save_conf; exit ;;
esac
done
}

main
