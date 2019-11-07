#!/bin/bash
firewallHosts="./inventory/firewallHosts"
arpWithMAC="./arpOutput.txt"
systemInfo="./systemInfo.txt"
currentList="./currentSystemList.txt"

ssh root@10.5.0.81 "ip -s -s neigh flush all" > /dev/null
echo "ARP cache flushed. Waiting for NIS to create new table."
sleep 30s
ssh root@10.5.0.81 "arp -a | grep -f mac.txt | sed -E 's/.*(10.5.[01].[0-9]+).*/\1/'" > $firewallHosts
#ssh root@10.5.0.81 "arp -a | grep -f sideLab.txt | sed -E 's/.*(10.5.[01].[0-9]+).*/\1/'" > $firewallHosts
ssh root@10.5.0.81 "arp -a | grep -f mac.txt | cut -d ' ' -f 2,4 " > $arpWithMAC
#ssh root@10.5.0.81 "arp -a | grep -f sideLab.txt | cut -d ' ' -f 2,4 " > $arpWithMAC
if [[ $? == 0 ]]; then
	echo "IP gathering successful."
	echo "$(cat $firewallHosts | wc -l) IPs active"
else
	echo "Something went wrong!"
fi

echo "Pinging all the hosts"
while IFS= read -r line; do
    ping -c 1 $line > /dev/null
done < $firewallHosts

echo "Done!"

if [[ $1 == "show" ]]; then
	echo "Will show the list"
	awk 'NR==FNR {h[$2] = $1; next} $NF in h {print $1,$2,$3,h[$NF]}' $arpWithMAC $systemInfo > $currentList
	cat $currentList
fi
