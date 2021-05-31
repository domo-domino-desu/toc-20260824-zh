# collatz.py compute collatz conjecture
def h(n):
    if (n % 2 == 0):
        return int(n/2)
    else:
        return 3*n+1

def c(n):
    if (n==0):
        return [1], 0
    k = n
    r, count = [k,], 0
    while (k!= 1):
        k = h(k)
        r.append(k)
        count = count+1
    return r, count

def show(n):
    v = c(n)
    print("for {:d}: length={:d} sequence={:s}".format(n, v[1], str(v[0])))

for n in range(1,20):
    # print("n={:d}".format(n)) 
    show(n)
