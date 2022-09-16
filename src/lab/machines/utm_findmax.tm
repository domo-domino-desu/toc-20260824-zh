% utm_findmax.tm
%  Find the maximum number between two markers
%  Between S and T is a list of numbers in unary, separated by single
% blanks.  This routine ends with nothing changed, except with the largest
% number to the left of S.  It starts pointing to S.
%
% The loop is: as it reads a number x in the interval between S and T, it
% replaces each 1 with a H marker.  Then it travels left, past S, and puts 
% a marker to the left of S.  If this is the third 1 in x, then this will
% be the third G.  When the 1's in x stop, the following blank gets replaced
% with a J marker, and the machine shifts left, past S, and replaces all the
% G's with 1's.  (The G's are there so you can tell x's marks from the 1's
% of the number before x.)  At the end, go back and change all the H's to 1's
% and J's to blanks, and the number of 1's to the left of S is the answer.
0 S R 1   % Start by shifting right to get into the interval
1 B B 10  
1 1 1 20
1 H R 1
1 J R 1
1 T L 30  % At end of interval
10 B J 11 % Reading a blank inside the interval, replace with J
11 B L 11 %  .. move left and replace all G's with 1's
11 1 L 11
11 H L 11
11 J L 11
11 S L 12  % ... headed outside the interval
12 G L 12
12 B R 13
12 1 R 13
13 G 1 14
13 S R 1
14 1 R 13
20 1 H 21 % Reading a 1 inside the interval, replace with H
21 H L 21 % .. then move left to put in a G
21 J L 21 %
21 S L 22 % ... headed outside the interval
22 G L 22
22 B G 23
22 1 G 23
23 G R 23
23 S R 1
30 H 1 31 % Finish up.  Change temp H markers to 1's
30 J B 31 %    and temp J markers to B's
30 S S 40
31 B L 30
31 1 L 30
