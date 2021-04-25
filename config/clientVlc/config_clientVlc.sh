#!/bin/bash

sudo apt-get update

sudo apt-get -y install scapy net-tools

sudo ip link set dev lo up
sudo ip -6 addr add fc00::9/64 dev enp0s8
sudo ip link set dev enp0s8 up
sudo ip -6 neigh add fc00::1 lladdr 00:15:4d:00:00:00 nud permanent dev enp0s8
sudo ip -6 neigh add fc00::2 lladdr 00:15:4d:00:00:01 nud permanent dev enp0s8
sudo ip -6 neigh add fc00::3 lladdr 00:15:4d:00:00:02 nud permanent dev enp0s8
sudo ip -6 neigh add fc00::4 lladdr 00:15:4d:00:00:03 nud permanent dev enp0s8
sudo ip -6 neigh add fc00::5 lladdr 00:15:4d:00:00:04 nud permanent dev enp0s8
sudo ip -6 neigh add fc00::8 lladdr 00:15:4d:00:00:05 nud permanent dev enp0s8

sudo ip -6 addr add fc10::2/64 dev enp0s9
sudo ip link set dev enp0s9 up
ip -6 neigh add fc10::1 lladdr 08:00:27:bb:bb:bb nud permanent dev enp0s9
ip -6 route add fc00::8 via fc10::1
ip -6 route add fc20::2 via fc10::1

sudo sysctl -w net.ipv6.conf.all.seg6_require_hmac=-1
sudo sysctl -w net.ipv6.conf.all.accept_source_route=1
sudo sysctl -w net.ipv6.conf.all.forwarding=1
sudo sysctl -w net.ipv6.conf.enp0s8.seg6_require_hmac=-1
sudo sysctl -w net.ipv6.conf.enp0s8.seg6_enabled=1
sudo sysctl -p 