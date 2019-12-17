% computing.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{computing}[2018/04/11 Class for computing book]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions \relax
\LoadClass[twoside,fleqn]{book}

% Use UTF-8
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\input{glyphtounicode}% Make PDF offer better copy and paste
  \pdfgentounicode=1

\usepackage{mathtools}  
\usepackage{amsmath, amssymb, amsthm} % no amsthm; use ntheorem because of margin numbering

% M Sharpe's XCharter
\usepackage{computingfonts}

% Get some file directories in this layout, such as where graphics are
\input{directory.tex}

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

% ========== Bibliography =============
% biblatex 
\usepackage[backend=biber,style=authoryear,sorting=nyt]{biblatex}
\addbibresource{computing.bib}


% ========== floats, captions =============
\usepackage{float}
\usepackage[% see https://tex.stackexchange.com/a/122329/121234
    font={small,sf},
    labelfont=bf,
    format=hang,    
    format=plain,
    margin=0pt,
    width=0.8\textwidth,
]{caption}
\usepackage[list=true]{subcaption} % replaces subfigure and subfig

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
% \renewcommand{\headrule}{{\color{lightcolor}%
%   \hrule width\headwidth height\headrulewidth \vskip-\headrulewidth}}
\renewcommand{\headrule}{{\color{black}%
  \hrule width\headwidth height\headrulewidth \vskip-\headrulewidth}}

% Main body of book
\renewcommand{\chaptername}{Chapter}
\newcommand{\sectionname}{Section}

\fancypagestyle{bookbody}{%
  \renewcommand{\headrulewidth}{.4pt}
  \renewcommand{\footrulewidth}{0pt}
  \fancyhead[LE,RO]{{\color{black}\textsl{Page \thepage}}} % instead of boldcolor
  \fancyhead[RE]{{\color{black}\textsl{\leftmark}}}
  \fancyhead[LO]{{\color{black}\textsl{\rightmark}}}
  \lfoot{}
  \rfoot{}
  \cfoot{}
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


\pagestyle{bookbody}
\pagenumbering{arabic}



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
    \cleardoublepage\thispagestyle{bookemptypage}}%
    \pagestyle{bookbody}}
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
                    itemsep=0ex, parsep=0ex,listparindent=0.68\parindent,
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



% ================ Display environment =========
% Like "center" except if fleqn is in effect, then it has a left margin
\newenvironment{display}{%
  \if@fleqn%
    \list{}{%
      \setlength{\leftmargin}{\mathindent}%
      \setlength{\itemindent}{0em}%
      \setlength{\labelwidth}{0em}%
      \setlength{\labelsep}{0em}%
      \setlength{\rightmargin}{0em}%
      \setlength{\listparindent}{\parindent}%
      \setlength{\parsep}{\parskip}%
      \setlength{\topsep}{0.5 ex plus 0.2ex minus 0.1ex}%
      \setlength{\partopsep}{0ex}%
      \setlength{\itemsep}{0ex}%
      }% 
  \else% 
    \list{}{%
      \setlength{\leftmargin}{0em}%
      \setlength{\itemindent}{0em}%
      \setlength{\labelwidth}{0em}%
      \setlength{\labelsep}{0em}%
      \setlength{\rightmargin}{0em}%
      \setlength{\listparindent}{\parindent}%
      \setlength{\parsep}{\parskip}%
      \setlength{\topsep}{0ex}%
      \setlength{\partopsep}{0ex}%
      \setlength{\itemsep}{0ex}%
      }\centering%
  \fi%
  \item[]%
}{%
  \endlist%
}


% ==== Grammars ==== (Asy doesn't like it) 
\usepackage{grammar}


% ==== Remaining content macros ======
% Broken out separately so they can be used in the
% Asymptote graphics
\usepackage{contentmacros}


% ++++++++++++++++++++++++=
% quick defs to get it to go.

\newenvironment{ans}[1]%
  {\leftskip1em\par\noindent\hspace{-1em}\textbf{#1}\ }%
  {}

% Mark an answer as verified by putting this in the source, and it gets 
% carried through to answerbody.tex
\newcommand{\verified}{\noindent\makebox[0in][r]{\textcolor{Fuchsia}{Verified}\hspace*{0.65in}}}


\renewcommand{\chapter}[1]{\clearemptydoublepage\vspace*{0.15in}\begin{center}\Large\textbf{#1}\end{center}\vspace*{0.5in}}


% \newcommand{\autocite}[1]{\textbf{#1}}

% Code below from https://www.overleaf.com/learn/how-to/Cross_referencing_with_the_xr_package_in_Overleaf
\usepackage{xr}
\newcommand*{\addFileDependency}[1]{% argument=file name and extension
  \typeout{(#1)}
  \@addtofilelist{#1}
  \IfFileExists{#1}{}{\typeout{No file #1.}}
}
\newcommand*{\myexternaldocument}[1]{%
    \externaldocument{#1}%
    \addFileDependency{#1.tex}%
    \addFileDependency{#1.aux}%
}
\myexternaldocument{preface/preface}
\myexternaldocument{prologue/prologue}
\myexternaldocument{background/background}
\myexternaldocument{langages/languages}
\myexternaldocument{automata/automata}
\myexternaldocument{/complexity/complexity}
% \externaldocument{book,prologue,background,languages,automata,complexity}


\newcommand{\definend}[1]{#1}  % should get rid of these in answers?


% ================= hyperref ===============
\usepackage{hyperref}  % remove the draft option at the end.
  % It is there to prevent errors like
  % "\pdfendlink ended up in different nesting level than \pdfstartlink";
  % see https://tex.stackexchange.com/a/154184/121234
\hypersetup{
    bookmarks=true,         % show bookmarks bar?
    unicode=false,          % non-Latin characters in Acrobat’s bookmarks
    pdftoolbar=true,        % show Acrobat’s toolbar?
    pdfmenubar=true,        % show Acrobat’s menu?
    pdffitwindow=false,     % window fit to page when opened
    pdfstartview={FitH},    % fits the width of the page to the window
    pdftitle={Computing},    % title
    pdfauthor={Jim Hefferon, Saint Michael's College},     % author
    pdfsubject={Theory of Computation answers to exercises},   % subject of the document
    pdfcreator={Jim Hefferon},   % creator of the document
    pdfproducer={Jim Hefferon}, % producer of the document
    pdfkeywords={theory of computation} {computation} {turing machines} {answers}, % list of keywords
    pdfnewwindow=true,      % links in new window
    colorlinks=true,       % false: boxed links; true: colored links
    linkcolor=black,          % color of internal links (change box color with linkbordercolor)
    citecolor=black,        % color of links to bibliography
    filecolor=black,      % color of file links
    urlcolor=black,           % color of external links
    plainpages=false   % prevent "destination with the same identifier" error
}

% === clever ref must come after hyperref ====
\usepackage{cleveref}
\def\thmt@refnamewithcomma #1#2#3,#4,#5\@nil{%
  \@xa\def\csname\thmt@envname #1utorefname\endcsname{#3}%
  \ifcsname #2refname\endcsname
    \csname #2refname\expandafter\endcsname\expandafter{\thmt@envname}{#3}{#4}%
  \fi
}
\crefname{theorem}{Theorem}{Theorems}
\Crefname{theorem}{Theorem}{Theorems}
\crefname{lemma}{Lemma}{Lemmas}
\Crefname{lemma}{Lemma}{Lemmas}
\crefname{corollary}{Corollary}{Collaries}
\Crefname{corollary}{Corollary}{Collaries}
\crefname{definition}{Definition}{Definitions}
\Crefname{definition}{Definition}{Definitions}
\crefname{example}{Example}{Examples}
\Crefname{example}{Example}{Theorems}
\crefname{remark}{Remark}{Remarks}
\Crefname{remark}{Remark}{Remarks}
\crefname{problem}{Problem}{Problems}
\Crefname{problem}{Problem}{Problems}
\crefname{churchsthesis}{Church's Thesis}{Church's Thesis}
\Crefname{churchsthesis}{Church's Thesis}{Church's Thesis}
\crefname{@exercisenumber}{Exercise}{Exercises}
\Crefname{@exercisenumber}{Exercise}{Exercises}

% \renewcommand{\cref}[1]{REF:~\textit{#1}}
% \renewcommand{\Cref}[1]{REF:~\textit{#1}}
