# Backup with rsync

```bash
./rsync_backup.sh --dst /run/media/takahisa/iodata-ext1t/backups/
./rsync_backup.sh --dst /run/media/takahisa/PWX/backups/
```

## Remove temporary directory, files

!! Confirm files before use them !!

```bash
fd -HIp --type directory -I 'app/build/intermediates$' ~
fd -HI --type directory '^tmp$' ~
fd -HI --type directory -HI '^old$' ~
fd -HI --type directory -HI '^cache$' ~
```

```bash
fd -HIp --type directory -I 'app/build/intermediates$' ~ --exec rm -rf
fd -HI --type directory '^tmp$' ~ --exec rm -rf
fd -HI --type directory -HI '^old$' ~ --exec rm -rf
fd -HI --type directory -HI '^cache$' ~ --exec rm -rf
```
