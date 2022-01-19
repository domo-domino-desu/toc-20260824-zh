// soduku0.asy
//  Soduku, before view

import settings;
settings.outformat="pdf";
settings.render=0;

// cd needed for relative import 
cd("../../asy");
import tape;
cd("");

picture p;
pen L_PEN = blue;  // pen used to label the tape
unitsize(p,1pt);

label(p, "\scriptsize\renewcommand{\arraystretch}{1.5}
\begin{tabular}{|c|c|c||c|c|c||c|c|c|}
 \hline
  $ $ &$ $ &$9$ &$ $ &$ $ &$ $ &$ $ &$1$ &$5$ \\ \hline
  $5$ &$ $ &$ $ &$4$ &$ $ &$9$ &$7$ &$ $ &$ $ \\ \hline
  $4$ &$7$ &$3$ &$5$ &$6$ &$1$ &$9$ &$ $ &$ $ \\ \hline\hline
  $ $ &$ $ &$ $ &$7$ &$4$ &$ $ &$ $ &$9$ &$6$ \\ \hline
  $ $ &$ $ &$ $ &$ $ &$ $ &$ $ &$ $ &$8$ &$ $ \\ \hline
  $ $ &$ $ &$4$ &$8$ &$3$ &$ $ &$1$ &$5$ &$ $ \\ \hline\hline
  $1$ &$3$ &$5$ &$9$ &$ $ &$ $ &$ $ &$ $ &$2$ \\ \hline
  $ $ &$ $ &$6$ &$2$ &$5$ &$7$ &$ $ &$3$ &$ $ \\ \hline
  $7$ &$2$ &$ $ &$ $ &$1$ &$ $ &$ $ &$ $ &$9$ \\ \hline
\end{tabular}", (0,0), L_PEN);

shipout("soduku0",p);

