% computing.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{computing}[2018/04/11 Class for computing book]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions \relax
\LoadClass[twoside]{book}

% Use UTF-8
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\input{glyphtounicode}% Make PDF offer better copy and paste
  \pdfgentounicode=1

\usepackage{mathtools}  
\usepackage{amsmath, amssymb, amsthm} % no amsthm; use ntheorem because of margin numbering

% M Sharpe's XCharter
\usepackage{computingfonts}

\usepackage{calc}
% Figure a person could print on letterpaper
\RequirePackage[papersize={8.5in,11in},
                margin=1in, 
                % textwidth=345pt, % textheight=550pt,  % LaTeX defaults
                % inner=.8in,
                % top=57.07pt, % 72.27-15.2 (lower down head height is 15.2)
                % bottom=1in, % 72.27 - 24.29494 pt (from \the\footskip)
                headsep=12pt,
                % bindingoffset=0.4in,
                % includeheadfoot
                ]{geometry}

\RequirePackage[dvipsnames]{xcolor}
\include{colorscheme}  % change the color scheme
\RequirePackage{graphicx}

\usepackage{adjustbox} % for clipping pictures

\usepackage{etoolbox}
% \usepackage{trace}  % for debugging


% ========== lengths on which others are set =============
\setlength{\topsep}{8.0pt plus 2.0pt minus 2.0pt}  % bk10.clo has it set to 8pt


% ========== tables =============
\usepackage{multirow}


\RequirePackage{fancyhdr}
% See http://en.wikibooks.org/wiki/LaTeX/Page_Layout
\setlength{\headheight}{15.2pt}

%HEADINGS
% \lhead[lh-even]{lh-odd} \chead[ch-even]{ch-odd} \rhead[rh-even]{rh-odd}
% \lfoot[lf-even]{lf-odd} \cfoot[cf-even]{cf-odd} \rfoot[rf-even]{rf-odd}
% where
% When LaTeX wants to create a page with an empty style, it will insert the 
% first argument of fancyplain, in all the other cases it will use the 
% second argument
% and available are
% \thepage  number of the current page
% \leftmark current chapter name printed like "CHAPTER 3. THIS IS THE CHAPTER TITLE"
% \rightmark current section name printed like "1.6. THIS IS THE SECTION TITLE"
% \chaptername the name chapter in the current language. If this is English, it will display "Chapter"
% \thechapter 	current chapter number
% \thesection 	current section number

\pagestyle{fancy} % must preceed redefinitions of \chaptermark, \sectionmark
\renewcommand{\chaptermark}[1]{%
  \markboth{\chaptername\ \thechapter.\ #1}{\chaptername\ \thechapter.\ #1}}
\newcommand{\jhchaptermark}[1]{%
  \markboth{\chaptername\ \thechapter.\ #1}{\chaptername\ \thechapter.\ #1}}
\renewcommand{\sectionmark}[1]{%
  \markright{\sectionname\ \thesection.\ #1}}
% Note that \extramark is defined by the definition of \extra
\renewcommand{\headrule}{{\color{lightcolor}%
  \hrule width\headwidth height\headrulewidth \vskip-\headrulewidth}}

% Main body of book
\renewcommand{\chaptername}{Chapter}
\newcommand{\sectionname}{Section}
\fancypagestyle{bookbody}{%
  \renewcommand{\headrulewidth}{.4pt}
  \renewcommand{\footrulewidth}{0pt}
  \fancyhead[LE,RO]{{\color{boldcolor}\textsl{\thepage}}}
  \fancyhead[RE]{{\color{boldcolor}\textsl{\leftmark}}}
  \fancyhead[LO]{{\color{boldcolor}\textsl{\rightmark}}}
}

% Front matter
\fancypagestyle{bookfront}{%
  \lhead{}
  \rhead{}
  \chead{}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
  \lfoot{}
  \rfoot{}
  \cfoot{}
  % \cfoot{\fancyplain{}{-- \thepage{} --}}
}

% Chapters start with an empty page (includes first page of toc)
\fancypagestyle{bookemptypage}{%
  \lhead{}
  \rhead{}
  \chead{}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
  \lfoot{}
  \rfoot{}
  \cfoot{}
}

% Table of contents
\fancypagestyle{booktoc}{%
  \lhead{}
  \rhead{}
  \chead{}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
  \lfoot{}
  \rfoot{}
  \cfoot{}
}

% I can't figure out how to make this wider.
% \fancypagestyle{endmatter}{%
%   \renewcommand{\headrulewidth}{.4pt}
%   \renewcommand{\footrulewidth}{0pt}
%   \fancyheadoffset[RE,LO]{-0.5\textwidth}
%   \fancyhead[LE,RO]{{KKK\color{boldcolor}\textsl{\thepage}}}
%   \fancyhead[RE]{{\color{boldcolor}\textsl{\leftmark}}}
%   \fancyhead[LO]{{\color{boldcolor}\textsl{\rightmark}}}
% }
\fancypagestyle{endmatter}{%
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
  \fancyhead[LE,RO]{}
  \fancyhead[RE]{}
  \fancyhead[LO]{}
}


\pagestyle{bookfront}
\pagenumbering{roman}



%================================================================
% PARAGRAPHS
\setlength{\parskip}{0.2ex plus 0.05ex minus 0.05ex}


% ========= Chapters and sections =============
% How much space to put between numbering and margin 
\newlength{\margin@numberingspace} % Dist between numbering and margin
\setlength{\margin@numberingspace}{0.8em}
\setlength{\marginparsep}{\margin@numberingspace}

% Clear to an odd page with empty pages in between
\newcommand{\clearemptydoublepage}{% clear to right page
  \newpage{\pagestyle{empty}% 
    \cleardoublepage}}
% Clear to an even-numbered page, with blank pages between
% https://tex.stackexchange.com/a/365249/121234
\newcommand*{\cleartoleftpage}{%
  \clearpage
    \if@twoside
    \ifodd\c@page
      \hbox{}\thispagestyle{empty}\newpage
      \if@twocolumn
        \hbox{}\newpage
      \fi
    \fi
  \fi
}


% Exparts
\usepackage{enumitem}
% Some exercises have multiple parts: (1) .. (2) ..
% This can be on separate lines.
\newenvironment{exparts}{%
  \begin{enumerate}[topsep=0ex,
                    itemsep=0ex, parsep=0ex,
                    leftmargin=2em,labelwidth=0.5em,labelsep=.16667em,
                    label={\scshape{\small (}\alph*{\small )}\nobreak\hspace{.16667em plus .08333em}}] 
}{%
  \end{enumerate}
}

% .. or inline
\newenvironment{exparts*}{%
  \begin{enumerate}[label={\scshape(\alph*)\nobreak\hspace{.16667em plus .08333em}},
                     itemsep=0em,labelsep=0em,labelindent=0em,itemindent=0em,
                     itemjoin={\hspace{0.6em plus .1em minus .1em\linebreak[2]}},
                     % before={\hspace{0.6em plus .1em minus .1em\linebreak[2]}}
                     ]
}{%
  \end{enumerate}
}


% Halmos symbol
\renewcommand\qedsymbol{{\setlength{\fboxsep}{0pt}\setlength{\fboxrule}{0.7pt}%
  \fcolorbox{boldcolor}{white}{\color{white}\rule{4pt}{8.5pt}}}}


  
% ==========================================================
% TABLE OF CONTENTS
\usepackage{tocloft}
\tocloftpagestyle{empty}
\setlength{\cftchapnumwidth}{1.25em}
\setlength{\cftsecindent}{1em}
\setlength{\cftsecnumwidth}{1.25em}
\setlength{\cftsubsecindent}{2.5em}
\setlength{\cftsubsecnumwidth}{1em}

% from tocloft.sty; hack to make it print roman chapter number
% I can't figure out how to have jhchapter work, so I am putting a
% \addcontentsline in the \chapter defn
\newcommand{\l@jhchapter}[2]{\relax}
\let\l@extrasection\l@section %


%============= listings =============================
% \definecolor{listingsbackgroundcolor}{RGB}{244,245,213}
\colorlet{listingsbackgroundcolor}{lightcolor}
\usepackage{listings}
% from: http://en.wikibooks.org/wiki/LaTeX/Packages/Listings
\lstset{ %
  % language=Octave,                % the language of the code
  basicstyle=\scriptsize\ttfamily,       % the size of the fonts that are used for the code
  % \stringstyle=\ttfamily,  % use typewriter type
  % numbers=left,                   % where to put the line-numbers
  % numberstyle=\footnotesize,      % the size of the fonts that are used for the line-numbers
  % stepnumber=2,                   % the step between two line-numbers. If it's 1, each line 
                                % will be numbered
  % numbersep=5pt,                  % how far the line-numbers are from the code
  backgroundcolor=\color{listingsbackgroundcolor},  % choose the background color. You must add \usepackage{color}
  showspaces=false,               % show spaces adding particular underscores
  showstringspaces=false,         % underline spaces within strings
  showtabs=false,                 % show tabs within strings adding particular underscores
  % frame=single,                   % adds a frame around the code
  tabsize=8,                      % sets default tabsize to 8 spaces (emacs scheme buffer formatting wants that)
  captionpos=b,                   % sets the caption-position to bottom
  % breaklines=true,                % sets automatic line breaking
  % breakatwhitespace=false,        % sets if automatic breaks should only happen at whitespace
  % title=\lstname,  % show the filename of files included with \lstinputlisting;
                                % also try caption instead of title
  escapeinside={<@}{@>}   % if you want to format lines in your code
  % morekeywords={*,...}   % if you want to add more keywords to the set
}

% \lstdefinestyle{grammar}{
%   basicstyle=\scriptsize\ttfamily,       % the size of the fonts that are used for the code
%   backgroundcolor=\color{white},  % choose the background color. You must add \usepackage{color}
%   showspaces=false,               % show spaces adding particular underscores
%   showstringspaces=false,         % underline spaces within strings
%   showtabs=false,                 % show tabs within strings adding particular underscores
%   tabsize=8,                      % sets default tabsize to 8 spaces (emacs scheme buffer formatting wants that)
%   captionpos=b,                   % sets the caption-position to bottom
%   mathescape=true,
%   % literate=
%   %   {=}{$\leftarrow{}$}{1}
%   %   {==}{::=}{3},
% }


% Don't want \lstinline!..! because it comes out too small.
\usepackage{relsize}
\newcommand\codeinline{\lstinline[basicstyle=\smaller\ttfamily]}




% Note: you can refine the choices with something like:
% \lstset{language=C,caption={Descriptive Caption Text},label=DescriptiveLabel}

% Make single quotes correct in verbatim 
\usepackage{upquote}


% Make ellipsis space out properly before a period
\usepackage[xspace]{ellipsis}

\usepackage{url}
\usepackage{microtype}


% ================
% Dash code stolen from tugboat.dtx
\def\thinskip{\hskip 0.16667em\relax}
\def\endash{--}
\def\emdash{\endash-}
\def\d@sh#1#2{\unskip#1\thinskip#2\thinskip\ignorespaces}
\def\dash{\d@sh\nobreak\endash}
\def\Dash{\d@sh\nobreak\emdash}
\def\ldash{\d@sh\empty{\hbox{\endash}\nobreak}}
\def\rdash{\d@sh\nobreak\endash}
\def\Ldash{\d@sh\empty{\hbox{\emdash}\nobreak}}
\def\Rdash{\d@sh\nobreak\emdash}


% == blkarray ====
%   Extended array features, such as labelled rows and columns
\usepackage{blkarray} 




% =================
% Add notes for me to put something in
\newenvironment{TODO}{%
\par\noindent \makebox[0em][l]{\makebox[-1em][r]{\color{red}TO DO:}}\centering
\begin{minipage}[t]{0.9\textwidth}\itshape
}{%
\end{minipage}
}



% ================ Content macros =========

% Tape sequence
%  List a sequence of executation steps by showing a bunch of tapes 
% Usage: 
%   \begin{tapesequence}
%     \begin{tapesequencetable}
%       0 &\tapegraphic{tapeoutput0.pdf} \\
%       1 &\tapegraphic{tapeoutput1.pdf} \\
%     \end{tapesequencetable}
%   \end{tapesequence}
% \newenvironment{tapesequence}{%
%   % \vspace{1.5ex plus 0.25ex minus 0.15ex}%
%   \begin{center} % \vspace{-3ex}
%     \renewcommand{\arraystretch}{2.25}
% }{%
%   \end{center}
%   % \vspace{-1.5ex plus 0.25ex minus 0.15ex}% arraystretch leaves extra?
% }
% \newenvironment{tapesequencetable}{%
%   % \vspace{2.5ex plus 0.25ex minus 0.15ex}%
%   \begin{tabular}[t]{r|c} 
%     % \multicolumn{1}{r}{\renewcommand{\arraystretch}{1.0}%
%     %                      \begin{tabular}[b]{@{}c@{}}
%     %                        \tabulartext{After} \\[-0.425ex] 
%     %                        \tabulartext{step} 
%                              %                            \end{tabular}}
%     \multicolumn{1}{r}{\tabulartext{Step}}
%      &\tabulartext{Configuration}                        \\[-1ex] \hline
% }{%
%   \end{tabular}%
% }
% \newcommand{\tapegraphic}[1]{%
%   \vcenteredhbox{\includegraphics{#1}}%
% }


% ==== Grammars ==== (Asy doesn't like it) 
\usepackage{grammar}
% \usepackage{syntax}
% \newlength{\grammarmargin}
% \setlength{\grammarmargin}{5em}
% \renewenvironment{grammar}{%
%   \list{}{%
%     \labelwidth\grammarindent%
%     \leftmargin\grammarmargin%
%     \advance\grammarindent\labelsep
%     \itemindent\z@%
%     \listparindent\z@%
%     \parsep\grammarparsep%
%     \small
%   }%
%   \let\\\@normalcr
%   \syntaxShortcuts\relax\relax%
%   % \def\alt{\\\llap{\textbar\hspace*{0em}}}% Comment this out from .sty file to adjust spacing
%   \def\gr@setpar{%
%     \def\par{%
%       \parshape\@ne\@totalleftmargin\linewidth%
%       \@@par%
%       \catcode`\<12%
%       \everypar{%
%         \everypar{}%
%         \catcode`\<\active%
%         \gr@implitem%
%       }%
%     }%
%   }%
%   \gr@setpar%
%   \par%
%   \let\gr@leftsq\[%
%   \let\gr@rightsq\]%
%   \def\gr@endsyntdiag]{\end{syntdiag}\gr@setpar\par}%
%   \def\[{\@ifnextchar[{\begin{syntdiag}\@gobble}\gr@leftsq}%
%   \def\]{\@ifnextchar]\gr@endsyntdiag\gr@rightsq}%
% }{%
%   \@newlistfalse%
%   \everypar{}%
%   \endlist%
% }
% \setlength{\grammarparsep}{0pt plus 0.15ex} % vert space between prods
% \setlength{\grammarindent}{5em} %
% \renewcommand{\grammarlabel}[2]{%
%   \hspace*{1.25em}\synt{#1} \hfill#2%
% }
% \def\alt{\\\llap{\textbar\hspace*{0.35em}}}%

% % Env to indent text
% \newenvironment{clip}{%
%   \begin{list}{}{\setlength{\leftmargin}{1.25em}
%                  \setlength{\parsep}{\grammarparsep}}\item[]
% }{%
%   \end{list}%
% }

% % Used for derivations; gives a raggedright block of indented text
% % \begin{displayedsteps}
% %  \initialstep\syntax{<start>}
% %   ..
% % \end{displayedsteps}
% \newenvironment{displayedsteps}{%
%   \begin{list}{}%
%       {\listparindent 1em%
%        %\itemindent    \listparindent
%        % \leftmargin 2em%
%        \rightmargin 1em%
%        \parsep        \z@ \@plus\p@}%
%        \item\relax \raggedright
% }{%
%   \end{list}
% }
% \newcommand{\initialstep}{\hspace*{-1em}}


% ==== Remaining content macros ======
% Broken out separately so they can be used in the
% Asymptotegraphics
\usepackage{contentmacros}


% ++++++++++++++++++++++++=
% quick defs to get it to go.

\newenvironment{ans}[1]%
  {\par\noindent\textbf{#1}\ }%
  {}

% Mark an answer as verified by putting this in the source, and it gets 
% carried through to answerbody.tex
\newcommand{\verified}{\noindent\makebox[0in][r]{\textcolor{Fuchsia}{Verified}\hspace*{0.65in}}}

\renewcommand{\chapter}[1]{\vspace*{0.5in}\begin{center}\Large\textbf{#1}\end{center}\vspace*{0.5in}}

\newcommand{\autocite}[1]{\textbf{#1}}

\newcommand{\cref}[1]{REF:~\textit{#1}}
\newcommand{\Cref}[1]{REF:~\textit{#1}}


\newcommand{\definend}[1]{#1}  % should get rid of these in answers?