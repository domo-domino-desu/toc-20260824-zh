#!/usr/bin/env python3
# subsetsumdp.py
# 2019-Jan-04 Jim Hefferon  Taken from:
# From https://python-forum.io/Thread-a-solution-to-the-Subset-Sum-Problem
# User: Mekire
# License: MIT, https://python-forum.io/misc.php?action=help&hid=47
"""Find the solution to a subset sum problem using dynamic programming."""

import numpy as np
 
def subset_sum(sequence, target):
    T = np.zeros((len(sequence)+1, target+1), dtype=int)
    T[:,0] = 1 
    for i,num in enumerate(sequence, start=1):
        for j in range(1, target+1):
            if j >= num:
                T[i,j] = T[i-1, j-num] or T[i-1, j]
            else:
                T[i,j] = T[i-1, j]
    return T

def subset_sum_solution(sequence, target):
    T = subset_sum(sequence, target)
    n = len(sequence)
    solution = []
    if T[n,target]:
        while n > 0 and target > 0:
            if not T[n-1, target]:
                solution.append(sequence[n-1])
                target -= sequence[n-1]
            n -= 1
    return solution

seq = [911, 22, 821, 563, 405, 986, 165, 732]
target = 1173
 
print(subset_sum_solution(seq, target))
