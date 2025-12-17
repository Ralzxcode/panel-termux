#!/bin/bash
[ "$DEV_MODE" = "1" ] && exit 0
SEC_DIR="$HOME/.panel_security"
HASH_FILE="$SEC_DIR/pass.hash"
FAIL_FILE="$SEC_DIR/fail.count"

MAX_FAIL=3
LOCK_TIME=60

mkdir -p "$SEC_DIR"
chmod 700 "$SEC_DIR"

# SETUP
if [ ! -f "$HASH_FILE" ]; then
  echo "[ SETUP ] Create Panel Password"
  read -s -p "New Password : " P1; echo
  read -s -p "Confirm      : " P2; echo
  [ "$P1" != "$P2" ] && echo "❌ Mismatch" && exit 1
  echo -n "$P1" | sha256sum | awk '{print $1}' > "$HASH_FILE"
  chmod 600 "$HASH_FILE"
  echo 0 > "$FAIL_FILE"
fi

FAIL=$(cat "$FAIL_FILE" 2>/dev/null || echo 0)

if [ "$FAIL" -ge "$MAX_FAIL" ]; then
  echo "🔒 Locked — wait $LOCK_TIME seconds"
  sleep "$LOCK_TIME"
  echo 0 > "$FAIL_FILE"
fi

read -s -p "🔐 Password : " INPUT; echo
IH=$(echo -n "$INPUT" | sha256sum | awk '{print $1}')
RH=$(cat "$HASH_FILE")

if [ "$IH" != "$RH" ]; then
  FAIL=$((FAIL+1))
  echo "$FAIL" > "$FAIL_FILE"
  echo "❌ Wrong password"
  exit 1
fi

echo 0 > "$FAIL_FILE"
