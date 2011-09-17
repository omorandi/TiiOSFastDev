#! /usr/bin/env python

import socket
import sys
import os

cwd =  os.getcwd()
prj_dir = cwd + "/.."
iphone_classes_dir = prj_dir + "/build/iphone/Classes"

print "[info] Starting iOS fastdev server from directory: " 
print "[info] > " + cwd

if not (os.path.exists(prj_dir + "/tiapp.xml") and os.path.exists(cwd + "/app.js")):
    print "[error] not in the Resources directory of a Titanium Mobile project... aborting\n"
    sys.exit(1)

ip_addr = "localhost"

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
try:
    s.connect(("gmail.com",80))
    ip_addr = s.getsockname()[0]
except socket.error, msg:
    s.close()
    s = None

if ip_addr == "localhost":
    print "[warning] cannot retrieve local ip address, falling back to localhost"
    print "[warning] project resource file will not be available for on device testing"
else:
    print "[info] server address is: " + ip_addr

server_addr_file = iphone_classes_dir + "/ServerAddr.h"

print "[info] writing server address to file: "
print "[info] > " + os.path.abspath(server_addr_file)

#out_file = open(server_addr_file,"w")
#out_file.write("#define SERVER_ADDRESS @\"" + ip_addr + "\"\n\n")
#out_file.close()

script_dir =  os.path.dirname(__file__)

print "[info] starting http server "
os.system("node " + script_dir + "/server.js");