#!/bin/bash
apt install scapy
# Configure Interfaces
sudo ip link set dev lo up

sudo ip -6 addr add fc00::5/64 dev eth1 #link primário
sudo ip link set dev eth1 up
sudo ip link set eth1 mtu 9000

sudo ip -6 addr add fc20::1/64 dev eth2 #link secundário
sudo ip link set dev eth2 up
sudo ip link set eth2 mtu 9000

sudo ip -6 neigh add fc00::1 lladdr 00:15:4d:00:00:00 nud permanent dev eth1 #ran
sudo ip -6 neigh add fc00::2 lladdr 00:15:4d:00:00:01 nud permanent dev eth1 #nfv1
sudo ip -6 neigh add fc00::3 lladdr 00:15:4d:00:00:02 nud permanent dev eth1 #nfv2
sudo ip -6 neigh add fc00::4 lladdr 00:15:4d:00:00:03 nud permanent dev eth1 #nfv3

sudo ip -6 neigh add fc00::8 lladdr 00:15:4d:00:00:05 nud permanent dev eth1 #dashServer
sudo ip -6 neigh add fc20::2 lladdr 08:00:27:dd:dd:dd nud permanent dev eth2 #dashServer

sudo ip -6 neigh add fc00::9 lladdr 00:15:4d:00:00:06 nud permanent dev eth1 #clientVlc
sudo ip -6 neigh add fc10::2 lladdr 08:00:27:aa:aa:aa nud permanent dev eth1 #clientVlc

sudo ip -6 route add fc10::2 via fc00::1 #clientVlc
sudo ip -6 route add fc00::100 via fc00::2 #nfv1

sudo sysctl -w net.ipv6.conf.all.seg6_require_hmac=-1
sudo sysctl -w net.ipv6.conf.all.accept_source_route=1
sudo sysctl -w net.ipv6.conf.all.forwarding=1
sudo sysctl -w net.ipv6.conf.eth1.seg6_require_hmac=-1
sudo sysctl -w net.ipv6.conf.eth1.seg6_enabled=1
sudo sysctl -p 

