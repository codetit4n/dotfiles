#!/bin/bash

TARGET_DIR="/run/media/tit4n/Lokesh 1TB/backup_pc"

# Count total number of files
total_files=$(find "$TARGET_DIR" -type f | wc -l)
deleted_files=0

# Exit if no files
if [ "$total_files" -eq 0 ]; then
    echo "No files to delete."
    exit 0
fi

# Delete and show progress
find "$TARGET_DIR" -type f | while read -r file; do
    rm -f "$file"
    deleted_files=$((deleted_files + 1))
    percent=$((deleted_files * 100 / total_files))
    echo -ne "Deleted: $percent% ($deleted_files / $total_files)\r"
done

# Remove empty directories
find "$TARGET_DIR" -type d -empty -delete

echo -e "\nDeletion complete."
