#!/bin/bash

# Detect OS
OS=$(uname)

# Set trash command based on OS
if [[ "$OS" == "Darwin" ]]; then
  # macOS: move to Trash using AppleScript
  move_to_trash() {
    for file in "$@"; do
      osascript -e "tell application \"Finder\" to move POSIX file \"$file\" to trash"
    done
  }
else
  # Linux: require trash-cli
  command -v trash &>/dev/null || { echo "⚠️ Please install trash-cli (sudo apt install trash-cli)"; exit 1; }
  move_to_trash() {
    trash "$@"
  }
fi

# Ask for user input
read -p "Enter target directory (default: current): " TARGET_DIR
TARGET_DIR=${TARGET_DIR:-"."}

read -p "Delete files larger than (e.g., 200M, 1G): " SIZE_THRESHOLD
#read -p "Delete files older than how many days? (e.g., 7): " AGE_THRESHOLD

# Set log file
LOGFILE="$HOME/cleanup_moved_to_trash.log"
echo "---- Cleanup started at $(date) ----" >> "$LOGFILE"

# Find matching files (null-separated for safety)
MATCHING_FILES=$(find "$TARGET_DIR" -type f -size +"$SIZE_THRESHOLD" -print0)

if [ -z "$MATCHING_FILES" ]; then
  echo "No files found matching the criteria."
  echo "No files found for trash." >> "$LOGFILE"
else
  echo "Files to be moved to Trash:"
  echo "$MATCHING_FILES" | tr '\0' '\n'
  
  read -p "Do you want to move these files to Trash? (y/n): " confirm
  if [[ "$confirm" =~ ^[Yy]$ ]]; then
    echo "$MATCHING_FILES" | tr '\0' '\n' | tee -a "$LOGFILE" | while IFS= read -r file; do
      move_to_trash "$file"
      echo "Moved to Trash: $file" >> "$LOGFILE"
    done
    echo "All files moved to Trash. Logged at $LOGFILE"
  else
    echo "Operation cancelled."
    echo "User aborted trash operation." >> "$LOGFILE"
  fi
fi

echo "---- Cleanup finished at $(date) ----" >> "$LOGFILE"
