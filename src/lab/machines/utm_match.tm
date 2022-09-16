% utm_match.tm
%  An if-then operator:
% Start with S to left of T.  If the unary number after S equals the unary
% number after T then end in state q_100, else end in state q_101.  (The
% 100 and 101 are arbitrary, and just need to steer clear of these state
% numbers.)
%
% The loop is: read after S, replacing a 1 with a G.  Then scan right past T
% and replace a 1 with an H.  If it runs out of 1's after S before it runs
% out of 1's after T then call it less.  Otherwise check if there are more
% 1's after T.
0 B B 10  % End of 1's after S
0 1 G 1  
0 G R 0 
0 S R 0   % Start by shifting right to get into the interval
0 T R 20
1 B R 1 % .. scan right, looking for T 
1 1 R 1
1 G R 1
1 T R 2
2 B B 20  % Ran out of 1's after T sooner than after S
2 1 H 3
2 H R 2
3 B L 3  % .. Scan left, looking for S
3 1 L 3
3 G L 3
3 H L 3
3 S S 0
3 T L 3
% The 1's after S have run out.
% See if the 1's after T are also gone
10 B R 10  % Scan right 
10 1 R 10
10 T R 11
11 B B 30  % Number 1's equal
11 1 1 20  % More 1's after T than after S
11 H R 11
% Unequal; clean up
20 B L 20
20 1 L 20
20 G 1 21
20 H 1 21
20 T L 20
20 S S 101
21 1 L 20
% Equal; clean up
30 B L 30
30 1 L 30
30 G 1 31
30 H 1 31
30 S S 100
30 T L 30
31 1 L 30
