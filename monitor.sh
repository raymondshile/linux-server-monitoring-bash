#!/bin/bash

echo "===== SYSTEM HEALTH CHECK ====="
echo "Date: $(date)"
echo ""

echo "Uptime:"
uptime
echo ""

echo "Memory Usage:"
free -m
echo ""

echo "Disk Usage:"
df -h
echo ""

echo "Top Processes:"
top -b -n 1 | head -15
echo ""

echo "===== END OF REPORT ====="
