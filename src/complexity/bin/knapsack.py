WEIGHTS = [21, 33, 49, 42, 19]
WEIGHT_BOUND = 73
VALUES = [50, 48, 34, 44, 40]
VALUE_TARGET = 140

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
                    total_weight, total_value = 0, 0
                    for dex, x in enumerate(items):
                        if x:
                            total_weight += WEIGHTS[dex]
                            total_value += VALUES[dex]
                    # print(" items: {0} weight: {1:d} value: {2:d}".format(str(items), total_weight, total_value))
                    print("   {0} &{1} &{2} &{3} &{4} &${5:d}$ &${6:d}$ \\\\".format(yorn(items[0]),
                                                                 yorn(items[1]),
                                                                 yorn(items[2]),
                                                                 yorn(items[3]),
                                                                 yorn(items[4]),
                                                                 total_weight,
                                                                 total_value))
                    if ((total_weight<=WEIGHT_BOUND)
                        and (total_value>=VALUE_TARGET)):
                        print("!!! weight bound and value target met")
