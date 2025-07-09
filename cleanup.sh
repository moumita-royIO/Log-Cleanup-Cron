#!/bin/bash

TARGET_DIR="/Users/xxxx/xxxx"
SIZE_THRESHOLD="+200M"
AGE_THRESHOLD="+7"
LOGFILE="$HOME/cron_cleanup.log"

echo "---- Cleanup started at $(date) ----" >> "$LOGFILE"

# Find and delete safely using null-separated list
find "$TARGET_DIR" -type f -size "$SIZE_THRESHOLD" -mtime "$AGE_THRESHOLD" -print0 \
  | tee >(tr '\0' '\n' >> "$LOGFILE") \
  | xargs -0 rm -v >> "$LOGFILE" 2>&1

echo "---- Cleanup finished at $(date) ----" >> "$LOGFILE"

