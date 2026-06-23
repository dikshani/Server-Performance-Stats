#!/bin/bash

echo "========== SERVER PERFORMANCE REPORT =========="
echo "Generated at: $(date)"
echo ""

echo "===== Total CPU Usage ====="
top -bn1 | grep "Cpu(s)" | awk '{print "CPU Usage:", 100-$8 "%"}'
echo ""

echo "===== Memory Usage ====="
free -m | awk '
/Mem:/ {
used=$3
free=$4
total=$2
printf "Used: %.2f GB\nFree: %.2f GB\nUsage: %.2f%%\n",
used/1024,
free/1024,
(used*100)/total
}'
echo ""

echo "===== Disk Usage ====="
df -h / | awk '
NR==2 {
print "Used:", $3
print "Free:", $4
print "Usage:", $5
}'
echo ""

echo "===== Top 5 Processes by CPU ====="
ps -eo pid,comm,%cpu --sort=-%cpu | head -6
echo ""

echo "===== Top 5 Processes by Memory ====="
ps -eo pid,comm,%mem --sort=-%mem | head -6
echo ""

echo "========== END =========="