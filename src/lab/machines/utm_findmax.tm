% utm_findmax.tm
%  Find the maximum number between two markers
0 S R 1   % Get started by shifting right
1 B B 10  
1 1 1 20
1 H R 1
1 T L 30  % At end of interval
10 B J 11 % Reading a blank inside the interval, replace with J
11 B L 11
11 1 L 11
11 H L 11
11 S L 12  % ... now headed outside the interval
12 G L 12
12 B R 13
12 1 R 13
13 G 1 14
13 S R 1
14 1 R 13
20 1 H 21 % Reading a 1 inside the interval, replace with H
21 H L 21
21 S L 22 % ... headed outside the interval
22 G L 22
22 B G 23
22 1 G 23
23 G R 23
23 S S 1
30 H 1 31 % Finish up.  Change temp H markers to 1's
30 J B 31 %    and temp J markers to B's
30 S S 40
31 1 L 30