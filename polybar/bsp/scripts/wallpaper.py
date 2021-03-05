import os
from random import randint

d = "/home/ByteWaiser/Pictures/wallpapers/"
os.chdir(d)
l = os.listdir()
s = randint(0,len(l)-1)
f = d + l[s]
os.system("feh --bg-scale " + f)



