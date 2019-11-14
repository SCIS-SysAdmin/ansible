#!/bin/bash

# Flush the rules
iptables -F



# Create Input Rules
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Create Output rules

iptables -A OUTPUT -d localhost -j ACCEPT
iptables -A OUTPUT -d --sport 22 -j ACCEPT
iptables -A OUTPUT -m owner --uid-owner 1000 -d elcs.uohyd.ac.in -j ACCEPT
iptables -A OUTPUT -m owner --uid-owner 1000 -d dcis.uohyd.ac.in -j ACCEPT
iptables -A OUTPUT -m -d 10.5.0.93 -j ACCEPT
iptables -A OUTPUT -m owner --uid-owner 1000 -d 10.5.0.93 -j ACCEPT
iptables -A OUTPUT -m owner --uid-owner 1000 -d 10.5.0.63 -j ACCEPT
iptables -A OUTPUT -m owner --uid-owner 0 -d elcs.uohyd.ac.in -j ACCEPT
iptables -A OUTPUT -m owner --uid-owner 0 -d 10.5.0.93 -j ACCEPT
iptables -A OUTPUT -m owner --uid-owner 0 -d 10.5.0.63 -j ACCEPT
iptables -A OUTPUT -m owner --uid-owner 0 -d dcis.uohyd.ac.in -j ACCEPT
iptables -A OUTPUT -p tcp --dport 80 -j DROP
iptables -A OUTPUT -p tcp --dport 443 -j DROP

# List iptable rules
iptables -L
