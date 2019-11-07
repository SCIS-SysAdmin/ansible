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
iptables -A OUTPUT -m owner --uid-owner 1000 -j DROP


iptables -L