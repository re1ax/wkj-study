#!/usr/bin/env bash
set -e

echo "===== OS ====="
cat /etc/os-release | head -20
uname -a

echo
echo "===== CPU ====="
lscpu

echo
echo "===== MEMORY ====="
free -h
cat /proc/meminfo | head -20

echo
echo "===== DISK ====="
df -h
lsblk -f

echo
echo "===== COMPILER / PYTHON ====="
which gcc || true
gcc --version | head -1 || true
which g++ || true
g++ --version | head -1 || true
which python || true
python --version || true
which python2 || true
python2 --version || true
which python3 || true
python3 --version || true

echo
echo "===== SICSTUS ====="
which sicstus || true
sicstus --version || true

echo
echo "===== ULIMIT ====="
ulimit -a

echo
echo "===== CGROUP ====="
stat -fc %T /sys/fs/cgroup || true
cat /proc/$$/cgroup || true
systemctl --user status --no-pager || true

echo
echo "===== TOP PROCESSES BY MEMORY ====="
ps aux --sort=-%mem | head -20

echo
echo "===== TOP PROCESSES BY CPU ====="
ps aux --sort=-%cpu | head -20

echo
echo "===== OOM LOG ====="
dmesg -T | grep -i -E "killed process|out of memory|oom" | tail -20 || true
