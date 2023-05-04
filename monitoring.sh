#!/bin/bash
ARCHI=$(printf "#Architecture : %s %s" "$(uname -a)")
CPU=$(printf "#CPU physical : %s" "$(lscpu | awk '/^CPU\(s\)/ {print $2}')")
VCPU=$(printf "#vCPU : %s" "$(($(lscpu | awk '/^CPU\(s\)/ {print $2}') * ($(lscpu | awk '/^Thread/ {print $4}')) * $(lscpu | awk '/^Core/ {print $4}')))")
MEM=$(printf "#Memory Usage : %s/%s (%s%%)" "$(free -m | awk '/^Mem:/ {print $3}')" "$(free -m | awk '/^Mem:/ {print $2}')" "$(($(free -m | awk '/^Mem:/ {print $3}') * 100 / $(free -m | awk '/^Mem:/ {print $2}')))")
DISK=$(printf "#Disk Usage : %s/%s (%s)" "$(df -h / | awk 'NR==2{print $3+0}')" "$(df -h / | awk 'NR==2{print $2}')" "$(df -h / | awk 'NR==2{print $5}')")
CPULOAD=$(printf "#CPU Load : %s%%" "$(top -b -n1 | awk '/load/ {print $10+0}')")
BOOT=$(printf "#Last Boot : %s %s" "$(who -b | awk '{print $3}')" "$(who -b | awk '{print $4}')")
LVM=$(printf "#LVM Use : %s" "$(lsblk | grep lvm | awk '{if ($1) {print "yes";exit;} else {print "no"}}')")
TCP=$(printf "#Connexions TCP : %s ESTABLISHED" "$(netstat | grep tcp | wc -l)")
USER=$(printf "#User Log : %s" "$(who | cut -d " " -f 1 | sort -u | wc -l)")
NET=$(printf "#Network: %s (%s)" "$(ip -4 a | awk '/inet/ && !/127.0.0.1/ {print $2}' | cut -d "/" -f 1)" "$(ip a | grep ether | awk '{print $2}')")
SUDO=$(printf "#Sudo : %s cmd" "$(awk '/COMMAND/' /var/log/sudo/logs | wc -l)")

echo -e "$ARCHI\n$CPU\n$VCPU\n$MEM\n$DISK\n$CPULOAD\n$BOOT\n$LVM\n$TCP\n$USER\n$NET\n$SUDO" | wall