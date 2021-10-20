echo -n "#Architecture: "
uname -a
echo -n "#CPU physical : "
lscpu | grep Processeur | rev | cut -d : -f 1
echo -n "#vCPU : "
lscpu | head -n 6 | tail -n 1 | awk -F ' ' '{print $6}'
echo -n "#Memory Usage: "
free -m | grep Mem | awk -F ' ' '{print $3 "/" $2 "MB (" (100*$3/$2) "%)"}'
echo -n "#Disk Usage: "
disk_use=$(free | grep Mem | awk -F ' ' '{print $2}' | cut -c 1-4)
echo -n "$disk_use/2Gb "
free | grep Mem | awk -F ' ' '{print ("(" $2/10/2000 "%)")}'
echo -n "#CPU load: "
mpstat | grep all | awk -F ' ' '{print(100 - $12 "%")}'
echo -n "#Last boot: "
who -b | awk -F ' ' '{print($3)}' | tr "\n" " "
who -b | awk -F ' ' '{print($4)}'
lvm_use=$(lsblk | grep lvm | head -n 1 | awk '{print $6}')
if [ "$lvm_use" = "lvm" ]; then
	echo '#LVM use : yes'
else
	echo '#LVM use : no'
fi
echo -n "#Connection TCP : "
ss | grep -c tcp | awk -F ' ' '{print $1 " ESTABLISHED"}'
echo -n "#User log: "
w | wc -l | awk '{print $1 - 2}'
echo -n "#Network: IP "
/sbin/ifconfig | grep inet | head -n 1 | awk '{print $2}' | tr "\n" " "
/sbin/ifconfig | grep inet6 | head -n 1 | awk '{print "(" $2 ")"}'
echo -n "#Sudo : "
cat /var/log/sudo.log | grep -c PWD | awk '{print $1 " cmd"}'

#pid=$(ps -ef | grep PID | tail -n 1 | awk -F ' ' '{print $4}')
#sleep 2
#kill -9 $pid
