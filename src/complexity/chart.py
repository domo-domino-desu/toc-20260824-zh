#!/usr/bin/env python3
# chart.py
#  Generate a chart of time for an algorithm to finish
#
# 2017-Jul-25 Jim Hefferon GPL

from decimal import Decimal
import math

def lg(x):
    return math.log2(x)

def n(x):
    return x

def nlgn(x):
    return x*lg(x)

def square(x):
    return x*x

def cube(x):
    return x*x*x

def twopow(x):
    return math.pow(2,x)

MACHINE_SPEED=10000*1000000  # ticks per second 10 gHz
SECS_PER_YEAR=60*60*24*365.25  # Julian
def compute_times(fcn,inputs):
    r=[]
    for x in inputs:
        t = fcn(x)/(MACHINE_SPEED*SECS_PER_YEAR)
        t_str = '{0:.2E}'.format(Decimal(t))
        r.append(t_str)
    return " ".join(r)

INPUTS=[1, 10, 50, 100]
for fcn in [lg, n, nlgn, square, cube, twopow]:
    print(compute_times(fcn,INPUTS))

