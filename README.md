<<<<<<< HEAD
# File Cleanup to Trash — Bash + Cron

A cross-platform Bash script that finds large and old files and safely moves them to the **Trash/Recycle Bin** instead of deleting them permanently. Built for Technical Support Engineers who frequently deal with log files and crash dumps.

---

## 💡 Features

- Interactive: prompts for folder, size, and file age
- Safe deletion: uses Trash instead of `rm`
- macOS and Linux supported
- Handles filenames with spaces
- Full logging of all moved files
- Cron-friendly version included

## 🔧 Requirements

| OS       | Required Tool        |
|----------|----------------------|
| macOS    | Built-in `osascript` |
| Linux    | [`trash-cli`](https://github.com/andreafrancia/trash-cli): `sudo apt install trash-cli` |

---

## 🧪 How It Works

1. User enters:
   - Target directory
   - Size threshold (e.g., `200M`, `1G`)
   - Age threshold in days (e.g., `+7`)
2. Script lists matching files
3. On confirmation, moves each file to Trash
4. Logs the operation to `~/cleanup_moved_to_trash.log`

---

## ⚙️ Setup

### 1. Make the script executable:
```bash
chmod +x cleanupaskfromuser.sh
```
### 2. Manually run:
```bash
./cleanup_trash.sh
```
### 3. Automated with cron job for the non-interactive script:
```bash
crontab -e
```
  - Replace /path/to/ with the actual full path to your script
```bash
0 3 * * * /path/to/cleanup.sh
```
 - Verify is cron job is scheduled
```bash
crontab -l
```
---
