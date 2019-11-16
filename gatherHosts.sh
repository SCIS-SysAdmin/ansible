#!/bin/bash
hosts="./inventory/hosts"
arpWithMAC="./tmp/arpOutput.txt"
systemInfo="./labMACs/systemInfo.txt"
currentList="./tmp/currentSystemList.txt"
rawARP="./tmp/rawARP.txt"
macAddr="./labMACs/mac.txt"
allLab="./labMACs/mac.txt"
sideLab="./labMACs/sidelab.txt"
insideLab="./labMACs/insidelab.txt"
outsideLab="./labMACs/outsidelab.txt"

# Make sure the tmp folder exists
mkdir -p ./tmp

ssh root@10.5.0.81 "ip -s -s neigh flush all" > /dev/null
echo "ARP cache flushed. Waiting for NIS to create new table."
sleep 30s
ssh root@10.5.0.81 "arp -a" > $rawARP
cat $rawARP | grep -f $macAddr | sed -E 's/.*(10.5.[01].[0-9]+).*/\1/' > $hosts
cat $rawARP | grep -f $macAddr | cut -d ' ' -f 2,4 > $arpWithMAC

if [[ $? == 0 ]]; then
	echo "IP gathering successful."
	echo "$(cat $hosts | wc -l) IPs active"
else
	echo "Something went wrong while IP gathering!"
fi

## Uncomment the following section to ping all the IPs
# SECTION PING start

# echo "Pinging all the hosts"
# while IFS= read -r line; do
#     ping -c 1 $line > /dev/null
# done < $hosts

# if [[ $? == 0 ]]; then
# 	echo "Done!"
# else
# 	echo "Unable to ping some IPs."
# fi

# SECTION PING end

if [[ $1 == "show" ]]; then
	echo "Will show the list"
	awk 'NR==FNR {h[$2] = $1; next} $NF in h {print $1,$2,$3,h[$NF]}' $arpWithMAC $systemInfo > $currentList
	cat $currentList
fi
