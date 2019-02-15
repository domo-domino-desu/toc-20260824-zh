# ackermann.py compute ackermann function
def h(level,x,y):
    if level==0:
        return y+1
    elif ((level==1) and (y==0)):
        return x
    elif ((level==2) and (y==0)):
        return 0
    elif ((level>2) and (y==0)):
        return 1
    else:
        print("calling H({:d}, {:d}, H({:d}, {:d}, {:d})".format(level-1, x, level, x, y-1))
        return h(level-1, x, h(level, x, y-1))

def h0(level,x,y):
    if level==0:
        return y+1
    elif (level==1):
        return x+y
    elif (level==2):
        return x*y
    elif (level==3):
        return x**y
    elif ((level>2) and (y==0)):
        return 1
    else:
        print("calling H({:d}, {:d}, H({:d}, {:d}, {:d})".format(level-1, x, level, x, y-1))
        return h0(level-1, x, h0(level, x, y-1))

def years(n):
    return n/(60*60*24*365.2422)

level = 4
x = 3
y = 3
r2 = h(2,2,2)
print("H({:d}, {:d}, {:}) is {:d}".format(2, 2, 2, r2))
r3 = h(3,3,3)
print("H({:d}, {:d}, {:}) is {:d}".format(3, 3, 3, r3))
r4 = h(4,4,4)
print("H({:d}, {:d}, {:}) is {:d}".format(4, 4, 4, r4))
print("ratio is {:f}".format(r3/r2))

# for y in range(3,4):
#     r = h(level, x, y)
#     print("H({:d}, {:d}, {:}) is {:d}".format(level, x, y, r))
#     print("  That is {:f} years".format(years(r)))
