#!/usr/bin/env python
import argparse
import sys
import socket
import random
import struct
import argparse

import gpt2

from scapy.all import sendp, send, get_if_list, get_if_hwaddr, hexdump
from scapy.all import Packet
from scapy.all import Ether, IPv6, UDP, TCP
from gpt2 import *

def main():

    if len(sys.argv)<2:
        print 'pass 2 arguments: <destination> "<message>"'
        exit(1)

    iface = "eth1" 

    print "sending on interface %s" % (iface)
    pkt =  Ether(src='00:15:5d:00:00:00', dst='00:15:5d:00:00:03') / IPv6(src="fc00::1", dst="fc00::4") / IPv6ExtHdrRouting(segleft=2, type=4,addresses=["fc00::4","fc00::101","fc00::100"]) / UDP (sport=64515, dport=2152 )  / GTP_U_Header(TEID=32, Reserved=0, E=1) / dl_pdu_session(gtp_ext=133,QoSID=14) / IPv6(src="fc00::1", dst="fc00::2") / UDP(dport=80,sport=35000) / sys.argv[1]
    pkt.show2()
    pkt.summary()
    sendp(pkt, iface=iface, verbose=False)


if __name__ == '__main__':
    main()
