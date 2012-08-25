#!/usr/bin/python
# -*- coding: utf-8 -*-
#
#  pitalk.py
#
# Copyright (C) 2012    David House <davidahouse@gmail.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 or version 3.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
#
#
# This script depends on the usbmux python script that you can find here:
# http://code.google.com/p/iphone-dataprotection/source/browse/usbmuxd-python-client/?r=3e6e6f047d7314e41dcc143ad52c67d3ee8c0859
#
import usbmux
import SocketServer
import select
from optparse import OptionParser
import sys
import threading
import struct
import RPi.GPIO as GPIO

GPIO.setmode(GPIO.BOARD)

print "pitalk starting"
mux = usbmux.USBMux()

print "Waiting for devices..."
if not mux.devices:
    mux.process(1.0)
if not mux.devices:
    print "No device found"

dev = mux.devices[0]
print "connecting to device %s" % str(dev)
psock = mux.connect(dev, 2345)

# setup the GPIO pins
outputpins = [3,5,7,8,10,11,12,13,15,16,18,19,21,22,23,24,26]
for pin in outputpins:
	print "setup pin %d" % pin
	GPIO.setup(pin,GPIO.OUT)

done = False
while not done:
	msg = psock.recv(17)

	index = 0
	for pin in outputpins:
		if msg[index] == "0":
			print "pin %d OFF" % pin
			GPIO.output(pin,False)
		else:
			print "pin %d ON" % pin
			GPIO.output(pin,True)
		index = index + 1

psock.close()

