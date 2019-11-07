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

### MAIN ###
clear
echo -e "          $blueHigh Welcome to EasyAdmin v1 $clearColor"
echo
echo
echo -e "	   $redHigh REMEMBER: Gather Hosts before running anything $clearColor"
PS3='Please select a task: '
options=("Gather hosts" "Internet Disable" "Internet Enable" "Install Software" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Internet Disable")
		internetDisable
            ;;
        "Internet Enable")
            	internetEnable
            ;;
        "Install Software")
            echo -e "Enter name of software to install on ALL machines: $redHigh STILL WORKING ON THE FIX $clearColor"
            ;;
	
        "Gather hosts")
		gatherHosts
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
