# Backup with rsync

## Initial backup

```bash
rsync -avh --exclude-from=Documents/git/dotfiles/misc/rsync_backup_excludes.txt \
    . /run/media/takahisa/iodata-ext1t/ml_bak/takahisa/
```
