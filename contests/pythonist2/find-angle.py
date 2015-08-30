#coding=utf8
from math import sqrt, atan, cos, acos, degrees

ab = float(raw_input())
bc = float(raw_input())
ac = sqrt(ab**2 + bc**2)
cm = ac/2

abc = atan(ab/bc)
bm = sqrt(bc**2 + cm**2 - 2*bc*cm*cos(abc))
angle = acos((bm**2 + bc**2 - cm**2)/(2*bm*bc))

print str(int(round(degrees(angle)))) + '°'