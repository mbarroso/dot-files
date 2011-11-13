#!/usr/bin/env python 
 import sys 
 """To use: 
 $ echo "I ate too much" | ./Update_friedcode.py 
 """ 
 U = 'friedcode' 
 P = <something something>

 import pytwitter 
 client = pytwitter.pytwitter(username=U, password=P) 
 status_update = sys.stdin.read().strip()[:140] 
 client.statuses_update(status=status_update)
