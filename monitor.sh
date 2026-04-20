#!/bin/bash

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$BASE_DIR/config.conf"

mkdir -p "$BASE_DIR/logs"

TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
MEM_USAGE=$(free | grep Mem | awk '{print ($3/$2) * 100.0}')
DISK_USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')

echo "$TIMESTAMP | CPU: $CPU_USAGE% | MEM: $MEM_USAGE% | DISK: $DISK_USAGE%" >> "$BASE_DIR/logs/system.log"

if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
    echo "$TIMESTAMP WARNING: High CPU usage ($CPU_USAGE%)" >> "$BASE_DIR/logs/alerts.log"
fi

if (( $(echo "$MEM_USAGE > $MEM_THRESHOLD" | bc -l) )); then
    echo "$TIMESTAMP WARNING: High Memory usage ($MEM_USAGE%)" >> "$BASE_DIR/logs/alerts.log"
fi

if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
    echo "$TIMESTAMP WARNING: High Disk usage ($DISK_USAGE%)" >> "$BASE_DIR/logs/alerts.log"
fi

