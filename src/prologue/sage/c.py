# c.py  Calculate the c(x,y) table in the primitive recursion exercises
def C(x,y):
    r = 0
    for i in range(x+y+1):
        r+=i
    return r+y

if __name__=='__main__':
    for x in range(5):
        print("\n")
        for y in range(5):
            print("C({0:d}, {1:d})={2:d}".format(x,y,C(x,y)))
