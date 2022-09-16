ELEMENTS = [21, 33, 49, 42, 19]
TARGET = 114

def yorn(x):
    if x:
        return 'Y'
    else:
        return 'N'

items = [False,]*5
for items[0] in [False,True]:
    for items[1] in [False,True]:
        for items[2] in [False,True]:
            for items[3] in [False,True]:
                for items[4] in [False,True]:
                    total = 0
                    for dex, x in enumerate(items):
                        if x:
                            total += ELEMENTS[dex]
                    # print(" items: {0} total: {1:d}".format(str(items), total))
                    print("   {0} &{1} &{2} &{3} &{4} &${5:d}$ \\\\".format(yorn(items[0]),
                                                                 yorn(items[1]),
                                                                 yorn(items[2]),
                                                                 yorn(items[3]),
                                                                 yorn(items[4]),
                                                                 total))
                    if (total==TARGET):
                        print("!!! target met")
