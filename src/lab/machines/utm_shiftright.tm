% utm_shiftright.tm
%  Move the Universal Turing machine U to the right by one character.
0 B R 0 % Slide to right to get to T
0 1 R 0
0 S R 0
0 T R 1
1 B T 10 % Overwrite the blank to right of T
1 1 T 20 %   .. or the 1 to the right of T
10 B L 11 % Slide Buffer+M one to right, if overwrote blank 
10 1 L 11
10 S L 30 %  .. have to write the blank on the left side
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
20 S L 40 % ... have to write the 1 on the left side 
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
30 B B 31 % ... write that blank on the left of S
30 1 B 31
30 S B 31
30 T B 31
31 B R 50
31 1 R 50
31 S R 50
31 T R 50 
40 B 1 41 % ... write that 1 on the left of S
40 1 1 41
40 S 1 41
40 T 1 41
41 B R 50
41 1 R 50
41 S R 50
41 T R 50 