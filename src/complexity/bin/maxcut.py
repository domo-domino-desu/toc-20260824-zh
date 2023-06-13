#!/usr/bin/env python3
# maxcut.py
# 2023-Jun-13 Jim Hefferon 
"""Find the solution to a max cut problem using brute force."""

# from https://stackoverflow.com/a/1482316
from itertools import chain, combinations

def powerset(iterable):
    "powerset([1,2,3]) --> () (1,) (2,) (3,) (1,2) (1,3) (2,3) (1,2,3)"
    s = list(iterable)
    return chain.from_iterable(combinations(s, r) for r in range(len(s)+1))

def find_cut_set(n,vertex_set,edge_set):
    """Return the cut set, as a list
      n  Number of vertices
      vertex_set  List of vertices in half of the partition
      edge_set  List of edges in the graph
    """
    cut_list = []
    for i in range(n):
        for j in range(i):
            if (([i,j] in edge_set)
                and (((i in vertex_set) and not(j in vertex_set)) 
                     or (not(i in vertex_set) and (j in vertex_set)))):
                cut_list.append([i,j])
    return cut_list

def find_max_cut(n, edge_set):
    """Return max cut set
      n  Number of vertices
      edge_set  list of edges in the graph
    """
    max_cut = [] 
    for vertex_list in powerset(range(n)):
      cut_list = find_cut_set(n, vertex_list, edge_set)
      if len(cut_list) > len(max_cut):
          max_cut = cut_list
    return max_cut

# EDGE_SET = [[0,2], [0,3],
#             [1,2], [1,3],
#             [2,0], [2,1], [2,4], [2,5],
#             [3,0], [3,1], [3,4], [3,5],
#             [4,2], [4,3],
#             [5,2], [5,3]]

EDGE_SET = [[0,1], [0,2],
            [1,0], [1,2], [1,3],
            [2,0], [2,1], [2,4],
            [3,1], [3,4], [3,5],
            [4,2], [4,3],
            [5,3], [5,3]]


mc = find_max_cut(6, EDGE_SET)
print("max cut is ",mc)
