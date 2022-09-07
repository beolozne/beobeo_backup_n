#!/bin/bash

DATE=$(date +%Y-%m-%d-%H-%M)
DATADIR=.near
BACKUPDIR=$HOME/backups/

mkdir $BACKUPDIR

sudo systemctl stop neard.service

wait

echo "NEAR node was stopped" | ts

if [ -d "$BACKUPDIR" ]; then
    echo "Backup Near BEOBEO started" | ts
    echo "Compressing backup...."
    tar -zcvf /root/backups/near_${DATE}.tar.gz -C $HOME/.near/data .

    # cp -rf $DATADIR/data/ ${BACKUPDIR}/

    # Submit backup completion status, you can use healthchecks.io, betteruptime.com or other services
    # Example
    curl -fsS -m 10 --retry 5 -o /dev/null https://hc-ping.com/c51ff5b1-fd1e-48b5-b702-c0ce423c789a

    echo "Backup completed" | ts
else
    echo $BACKUPDIR is not created. Check your permissions.
    exit 0
fi

sudo systemctl start neard.service

echo "NEAR node BEOBEO was started" | ts
