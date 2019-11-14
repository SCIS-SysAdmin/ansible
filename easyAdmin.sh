#!/bin/bash

##### Colors #####
blueHigh="\e[44m"
cyan="\e[96m"
clearColor="\e[0m"
redHigh="\e[41m"
green="\e[32m"
greenHigh="\e[42m"


### Internet Disable ###
internetDisable() {
	ansible-playbook -i inventory/firewallHosts netDisable-exam.yml
}
internetEnable() {
	ansible-playbook -i inventory/firewallHosts netEnable-exam.yml
}

gatherHosts() {

	echo -e "$cyan Wait till we gather IP addr of running AI Lab machines. Takes 30 seconds. $clearColor"
	./gatherHosts.sh show
}

disableNFS() {
	ansible-playbook -i inventory/firewallHosts examMode.yml --tags disableNFS
}

enableNFS() {
	ansible-playbook -i inventory/firewallHosts examMode.yml --tags enableNFS
}

rebootMachine() {
	ansible-playbook -i inventory/firewallHosts examMode.yml --tags reboot
}
poweroffMachine() {
	ansible-playbook -i inventory/firewallHosts examMode.yml --tags poweroff
}

examCleanup() {
	ansible-playbook -i inventory/firewallHosts examMode.yml --tags examCleanup
}


### MAIN ###
clear
echo -e "          $blueHigh Welcome to EasyAdmin v1 $clearColor"
echo
echo
echo -e "	   $redHigh REMEMBER: Gather Hosts before running anything $clearColor"
PS3='Please select a task: '
options=("Gather hosts" "Internet Disable" "Internet Enable" "Exam Mode ON" "Exam Mode OFF" "Power off All" "Exam Clean-up" "" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Internet Disable")
		internetDisable
            ;;
        "Internet Enable")
            	internetEnable
            ;;

	"Exam Clean-up")
		examCleanup
	    ;;
        "Exam Mode ON")
	   	gatherHosts
		internetDisable
		disableNFS
		rebootMachine
            ;;
	
        "Gather hosts")
		gatherHosts
            ;;
	 
	"Power off All")
		poweroffMachine
	    ;;

        "Exam Mode OFF")
		gatherHosts
		internetEnable
		enableNFS
		rebootMachine
	    ;;
        "Quit")
	   # echo -e " $redHigh WARNING: Host files flushed. Gather hosts when you open the script next time. $clearColor "
	   # echo
	    #echo "" > inventory/firewallHosts
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
