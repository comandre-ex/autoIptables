#!/usr/bin/env  bash

trap  ctrl_c  INT  

function ctrl_c(){
  echo -e  "Exiting...."
  tput cnorm; exit 1
}


function helpPanel(){
  echo -e "\n\n\t\t [*] Author :  Comandre-ex\n"
  echo -e "\n\t-h)helpPanel\n"
  echo -e "\n\t-ipv4) configuration ipv4\n"
  echo -e "\n\t-ipv6) configuration ipv6\n"
}


function  configuration_ipv4(){
  touch /etc/iptables/rules.v4
  chmod 600 /etc/iptables/rules.v4
  echo "*filter" >> /etc/iptables/rules.v4
  echo ":INPUT ACCEPT [0:0]" >> /etc/iptables/rules.v4
  echo ":FORWARD ACCEPT [0:0]" >> /etc/iptables/rules.v4
  echo ":OUTPUT ACCEPT [0:0]" >> /etc/iptables/rules.v4
  echo "-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT" >> /etc/iptables/rules.v4
  echo "-A INPUT -i lo -j ACCEPT" >> /etc/iptables/rules.v4
  echo "-A INPUT -p tcp -m tcp --dport 22 -j ACCEPT" >> /etc/iptables/rules.v4
  echo "-A INPUT -j DROP" >> /etc/iptables/rules.v4
  echo "COMMIT" >> /etc/iptables/rules.v4
}



function  configuration_ipv6(){
  touch /etc/iptables/rules.v6
  chmod 600 /etc/iptables/rules.v6
  echo "*filter" >> /etc/iptables/rules.v6
  echo ":INPUT ACCEPT [0:0]" >> /etc/iptables/rules.v6
  echo ":FORWARD ACCEPT [0:0]" >> /etc/iptables/rules.v6
  echo ":OUTPUT ACCEPT [0:0]" >> /etc/iptables/rules.v6
  echo "-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT" >> /etc/iptables/rules.v6
  echo "-A INPUT -i lo -j ACCEPT" >> /etc/iptables/rules.v6
  echo "-A INPUT -p tcp -m tcp --dport 22 -j ACCEPT" >> /etc/iptables/rules.v6
  echo "-A INPUT -j DROP" >> /etc/iptables/rules.v6
  echo "COMMIT" >> /etc/iptables/rules.v6
}



declare  -i  parameter_counter=0;  while  getoopts   ":h:ipv4:ipv6:" args ; do  

       case $args  in 
         h)helpPanel;;
         ipv4)configuration_ipv4; let  parameter_counter+=2;;
         ipv6)configuration_ipv6; let  parameter_counter+=2;;
         *)
           :
       esac  
done 

if [[ "$(id -u)"  == "0" ]];  then

else
  echo  "\n\nEjecute como ~ root\n"
fi
