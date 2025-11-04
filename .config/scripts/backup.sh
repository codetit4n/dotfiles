#!/bin/bash

set -e

# === CONFIGURATION ===

USER_HOME="/home"
SOURCE_FOLDERS=(tit4n)
EXCLUDE_DIRS=(node_modules target build dist out 'VirtualBox VMs')
TARGET_DIR="/run/media/tit4n/Lokesh 1TB/backups/PC"

mkdir -p "$TARGET_DIR"

# === PREPARE PATHS ===

INCLUDE_PATHS=()
for folder in "${SOURCE_FOLDERS[@]}"; do
  path="$USER_HOME/$folder"
  [ -d "$path" ] && INCLUDE_PATHS+=("$path")
done

# Build tar exclude args
EXCLUDE_ARGS=()
for dir in "${EXCLUDE_DIRS[@]}"; do
  EXCLUDE_ARGS+=(--exclude="$dir")
done

# === PRE-BACKUP DISK USAGE ===

echo "📦 Estimating backup size..."

TOTAL_BACKUP_SIZE_HUMAN=$(du -shc "${INCLUDE_PATHS[@]}" --exclude="${EXCLUDE_DIRS[@]}" 2>/dev/null | tail -n 1 | awk '{print $1}')
TOTAL_BACKUP_SIZE_BYTES=$(du -scb "${INCLUDE_PATHS[@]}" --exclude="${EXCLUDE_DIRS[@]}" 2>/dev/null | tail -n 1 | awk '{print $1}')

AVAILABLE_SPACE_HUMAN=$(df -h "$TARGET_DIR" | awk 'NR==2 {print $4}')
AVAILABLE_SPACE_BYTES=$(df --output=avail -B1 "$TARGET_DIR" | tail -n 1)

echo "📁 Total backup size: $TOTAL_BACKUP_SIZE_HUMAN"
echo "💽 Available space on target: $AVAILABLE_SPACE_HUMAN"

if (( TOTAL_BACKUP_SIZE_BYTES > AVAILABLE_SPACE_BYTES )); then
  echo "⚠️  Warning: Backup size exceeds available space!"
  echo "❗ Proceeding may cause partial copy or failure."
  echo "🔐 Press Enter to force, or Ctrl+C to cancel."
  read -r
else
  echo "✅ Enough space available."
  echo "👉 Press Enter to proceed with the backup."
  read -r
fi

# === START BACKUP ===

for folder in "${SOURCE_FOLDERS[@]}"; do
  SRC_PATH="$USER_HOME/$folder"
  DEST_PATH="$TARGET_DIR/$folder"

  if [ -d "$SRC_PATH" ]; then
    echo -e "\n🚀 Backing up: $SRC_PATH"
    echo "⏳ Tracking total progress with pv (real global progress)..."

    mkdir -p "$DEST_PATH"

    tar -cf - -C "$SRC_PATH" . "${EXCLUDE_ARGS[@]}" 2>/dev/null | \
      pv -s "$TOTAL_BACKUP_SIZE_BYTES" | \
      tar -xf - -C "$DEST_PATH"

    echo -e "\n✅ Done backing up: $SRC_PATH"
  else
    echo "⚠️  Skipping missing folder: $SRC_PATH"
  fi
done

echo -e "\n🎉 Backup complete! All folders processed successfully."
