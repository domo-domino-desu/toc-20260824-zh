% utm_copy.tm
% Given markers S and T, copy the number of 1's following S over to
% following T.
% Scanning past G's, looking for a 1
0 B B 10  % .. got a B, need to end the program
0 1 G 1   % .. got a 1, make it a G and go to T and add a 1 
0 S R 0
0 G R 0
0 T T 10
% Changed a 1 to a G, go to T, add a 1
1 B R 1
1 1 R 1
1 G R 1
1 T R 2
% Gotten past T on way to adding a 1
2 B 1 3
2 1 R 2
% Start scanning left, until get past T
3 B L 3
3 1 L 3
3 T L 4
% Continue scanning left
4 B L 4
4 1 L 4
4 S S 0
4 G L 4
% Clean up scratch G markers, turn them to 1's
10 B L 10
10 1 L 10
10 S S 20
10 G 1 11
10 T L 10
11 1 L 10