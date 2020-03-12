#! /bin/sh
SUBJECT="Disk Usage Report on "`date`""
MESSAGE="disk-usage.out"
MESSAGE1="disk-usage-1.out"
TO="vivekmahendra30@gmail.com"
echo "---------------------------------------------------------------------------------------------------" >> $MESSAGE1
echo "HostName            Filesystem                Size Used Avail Use% Mounted on" >> $MESSAGE1
echo "---------------------------------------------------------------------------------------------------" >> $MESSAGE1
for server in `more servers1.txt`
do
output=`ssh $server df -Ph | tail -n +2 | sed s/%//g | awk '{ if($5 > 40) print $0;}'`
echo "$server: $output" >> $MESSAGE
done
cat $MESSAGE | grep G | column -t >> $MESSAGE1
mail -s "$SUBJECT" "$TO" < $MESSAGE1
