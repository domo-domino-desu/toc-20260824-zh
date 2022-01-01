% utm_shiftright.tm
%  Move the Universal Turing machine U to the right by one character.
% The issue is that by "one character" we mean "one character representation".
% We assume and interval S...T, followed by a blank, and then another blank
% or some number of 1's.  We want to end with BBS..T or B11..1S..TB.
0 B R 0 % Slide to right to get to T
0 1 R 0
0 S R 0
0 T R 1
1 B T 10 % Overwrite the blank to right of T
1 1 T 20 %   .. or the 1 to the right of T
% Finished carrying the first blank down, now look past T again
% Here we have to worry which case: initial tape had TBB or TB1?
2 B R 2  % slide right until find T
2 1 R 2
2 S R 2
2 T R 3
3 B T 30 % found a second blank
3 1 T 20 % found a 1
% Transferring 1's, so initial tape had TB1
4 B R 4  % slide right until find T
4 1 R 4
4 S R 4
4 T R 5
5 B B 6 % found a blank, clean up and get out
5 1 T 20 % found a 1, start shifting
6 B L 6
6 1 L 6
6 S S 100
6 T L 6
% Slide whole interval right for first blank after T
10 B L 11  
10 1 L 11
10 S L 40 %  .. have to write the blank on the left side of S
10 T L 11
11 B L 12
11 1 L 12
11 S L 12
11 T L 12
12 B R 13
12 1 R 14
12 S R 15
12 T R 16
13 B B 10
13 1 B 10
13 S B 10
13 T B 10
14 B 1 10
14 1 1 10
14 S 1 10
14 T 1 10
15 B S 10
15 1 S 10
15 S S 10
15 T S 10
16 B T 10
16 1 T 10
16 S T 10
16 T T 10
20 B L 21 % Slide Buffer+M one to right, if overwrote 1
20 1 L 21
20 S L 50 % ... have to write the 1 on the left side 
20 T L 21
21 B L 22
21 1 L 22
21 S L 22
21 T L 22
22 B R 23
22 1 R 24
22 S R 25
22 T R 26
23 B B 20
23 1 B 20
23 S B 20
23 T B 20
24 B 1 20
24 1 1 20
24 S 1 20
24 T 1 20
25 B S 20
25 1 S 20
25 S S 20
25 T S 20
26 B T 20
26 1 T 20
26 S T 20
26 T T 20
% In a double blank situation, slide buffer to the right
30 B L 31 %  
30 1 L 31
30 S L 60 %  back to the start, write a second blank 
30 T L 31
31 B L 32
31 1 L 32
31 S L 32
31 T L 32
32 B R 33
32 1 R 34
32 S R 35
32 T R 36
33 B B 30
33 1 B 30
33 S B 30
33 T B 30
34 B 1 30
34 1 1 30
34 S 1 30
34 T 1 30
35 B S 30
35 1 S 30
35 S S 30
35 T S 30
36 B T 30
36 1 T 30
36 S T 30
36 T T 30
% Write that first blank to the left of S
40 B B 41 
40 1 B 41
40 S B 41
40 T B 41
41 B R 2
41 1 R 2
41 S R 2
41 T R 2
% Write a 1 to the left of S
50 B 1 51 
50 1 1 51
50 S 1 51
50 T 1 51
51 B R 4
51 1 R 4
51 S R 4
51 T R 4
% Write a second blank to the left of S
60 B B 61 
60 1 B 61
60 S B 61
60 T B 61
61 B R 100
61 1 R 100
61 S R 100
61 T R 100
