% computing.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{computing}[2014/08/08 Class for computing book]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions \relax
\LoadClass[oneside]{book}

% Make PDF offer better copy and paste
\usepackage{cmap}  

\usepackage{amsmath,amsthm,amssymb}  % later load mathtools

% M Sharpe's XCharter
% \usepackage[scaled=.98,sups,osf]{XCharter}% lining figures in math, osf in text
% \usepackage[scaled=1.04,varqu,varl]{zi4}% inconsolata typewriter
% \usepackage[type1]{cabin}% sans serif
% \usepackage[libertine,bigdelims,vvarbb,scaled=1.07]{newtxmath}
% \usepackage[cal=boondoxo]{mathalfa}
% \linespread{1.04}
\usepackage{computingfonts}

\usepackage{calc}
\RequirePackage[papersize={7.5in,9.25in},
                textwidth=345pt, % textheight=550pt,  % LaTeX defaults
                inner=.8in, top=1in, bottom=1in, %
                headsep=12pt,
                bindingoffset=0.4in,
                ]{geometry}

\RequirePackage[dvipsnames]{xcolor}
\include{colorscheme}  % change the color scheme
\RequirePackage{graphicx}

\usepackage{etoolbox}

\usepackage[inline]{enumitem} % for exparts and exparts*, for exercises and answers 
\newenvironment{parenum}{%
  \begin{enumerate*}[label=(\arabic*),]%
}{%
  \end{enumerate*}
}


%=========== answers to exercises ===================================
%  The file answerbody.tex holds the answers, and in input by the file 
% answers.tex
%
% This needs to be before sections and chapters because they write to
% the answer body file

% Name of file holding answers
\newcommand{\answerbodyfilename}{answerbody}

\usepackage{answers}
\Opensolutionfile{\answerbodyfilename}
\Newassociation{answer}{ans}{\answerbodyfilename}


% ====================== citations ===========================
% Put citations in the end, referencing text but without giving
% a number in the text body.  

% biblatex 
\usepackage[backend=biber,style=authoryear,sorting=nyt]{biblatex}
\addbibresource{computing.bib}

% citetext
%  Reference text in the body.
% #1 text referenced in the citations
% #2 Citation
%  Example:
%   The soldiers could 
%    \citetext{see his hairy legs}{OR C Dobson, p 1094.}.
% produces an end note like 
%    \textit{see his hairy legs} OR C Dobson, p 1094.

\usepackage{fancyhdr} % has to go here for endheads, but not used until below.
\usepackage{endnotes, endheads}
\newcommand{\citetext}[2]{#1%
  \endnote{\protect\textit{#1}\protect\hspace{.618em} #2}}
\renewcommand{\makeenmark}{\relax} % leave no mark
\newcommand{\citeadd}[1]{\addtoendnotes{#1}}

\renewcommand{\notesname}{Notes}
\usepackage{hanging} % make cited text be in hanging indented paragraphs
\def\enoteformat{\rightskip\z@ \leftskip\z@ \parindent=0em\hangpara{2em}{1}%
  \leavevmode\llap{\makeenmark}}
% \usepackage{needspace}   % prevent a page break between a chapter announcement and the citations on that chapter

% How headings for chapters, Preface, etc. ar formatted on Citations page
\newcommand{\citechapterformatting}[1]{\vspace{2ex}%
  \par\noindent{\textbf{#1}}}
% How chapters are put onto Citations page.  For Preface, etc. you use prior
% command by hand.
\newcommand{\citechapter}[2]{\citechapterformatting{Chapter #1\hspace{1em}#2}}

% Change \theendnotes to add a hook for some explanatory text.
\def\theendnotes{\immediate\closeout\@enotes \global\@enotesopenfalse
  \begingroup
    \makeatletter
    %
    % The machinery with \@ResetGT and > here ensures that
    % \@doanenote works properly even if > is an active character
    % at the point where \theendnotes is invoked. > needs to have
    % catcode 12 when the arguments of \@doanenote are scanned, so
    % that the > in the string "macro:->" is matched.  The actual
    % footnote text is not an argument to \@doanenote, but just
    % follows it in the .ent file; so \@ResetGT can reset the
    % category code for > that should be used when processing
    % that text.  That resetting takes place within a
    % \begingroup-\endgroup block set up by \@doanenote and
    % \@endanenote, so the catcode for > is back to 12 for the
    % next note.
    %
    \edef\@tempa{`\string >}%
    \ifnum\catcode\@tempa=12%
      \let\@ResetGT\relax
    \else
      \edef\@ResetGT{\noexpand\catcode\@tempa=\the\catcode\@tempa}%
      \@makeother\>%
    \fi
    \def\@doanenote##1##2>{\def\@theenmark{##1}\par\begingroup
        \@ResetGT
        \edef\@currentlabel{\csname p@endnote\endcsname\@theenmark}%
        \enoteformat}
    \def\@endanenote{\par\endgroup}%
    \enoteheading
    \enotesize
    \jhendnoteshook
    \input{\jobname.ent}%
  \endgroup}

\newcommand{\jhendnoteshook}{Each note refers to a word or phrase from
the text body of the chapter, given here in italics.
They include both citations and more traditional notes, as well as combinations
of the two.}


\newcommand{\printnotes}{%
  \newpage
  \begingroup
  % \parindent 0pt
  \parskip 1ex
  \def\enotesize{\normalsize}
  % \hangparas{-2em}{-1}
  \def\sectiontitlecontents{\relax} % omit "Section Five.II"-like from margin
  \theendnotes
  \endgroup
  }

% \newenvironment{notes}{%
%   \citationwrite{\citationbackslash end{citationlist}}
%   \citationclose%
%   \clearemptydoublepage%
%   \thispagestyle{empty}%
%   \vspace*{6ex}\noindent{\LARGE \textbf{Notes}}\vspace{2ex}%
% }{%
% }





%=========== formatting ===================================
% CHAPTERS, SECTIONS, SUBSECTIONS
\newcommand{\clearemptydoublepage}{%
  \newpage{\pagestyle{empty}% 
  \cleardoublepage}}
\newcommand{\newpart}[1]{\clearemptydoublepage\thispagestyle{empty}%
  \vspace*{\fill}%
  \begin{center}
    \large #1
  \end{center}
  \vspace*{\fill}%
}


% Put numbering in margin 
\newlength{\margin@numberingspace} % Dist between numbering and margin
\setlength{\margin@numberingspace}{0.8em}

\usepackage[calcwidth]{titlesec}
% Summary of titleformat command:
% \titleformat{ command }[ shape ]{ format }{ label }{ sep }{ before-code }[ after-code ]
% Summary of titlespacing command:  (*-ed form kills indent of paragraph)
% \titlespacing*{ command }{ left }{ before-sep }{ after-sep }[ right-sep ]

\renewcommand{\thepart}{\Alph{part}}
\titleclass{\part}{part}
\titleformat{\part}[display]{\Large}{}{0em}{\thispagestyle{empty}\centering \LARGE{\color{boldcolor}Part \thepart} \\[1.5ex]}[\relax]

\usepackage{fmtcount}
\renewcommand{\thechapter}{\Numberstring{chapter}}
\newcommand{\format@chapter@title}[1]{#1}
% \newcommand{\format@chapter@title}[1]{\begin{tabular}[b]{@{}r@{}}Chapter \\[0.25ex] #1\end{tabular}}
% \titleformat{\chapter}[hang]{\bfseries}{\makebox[0em][r]{\normalfont\Large\bfseries\format@chapter@title{\begin{tabular}[b]{@{}r@{}}Chapter \\ \thechapter\end{tabular}}\rule{\margin@numberingspace}{0ex}}}{0ex}{\normalfont\Large\bfseries}[\relax]
\newcommand{\jh@grabtitle}[2][\relax]{%
  \typeout{the chapter name is #2}% 
  \Writetofile{\answerbodyfilename}{\chapter{#2}}%
  #1 %
}
\titleformat{\chapter}[hang]{\bfseries}{\makebox[0em][r]{\normalfont\Large\color{boldcolor}\format@chapter@title{\begin{tabular}[b]{@{}r@{}}Chapter \\[-.15ex] \thechapter\end{tabular}}\rule{\margin@numberingspace}{0ex}}}{0ex}{\normalfont\Large\bfseries}[\relax]
\titlespacing*{\chapter}{0em}{*5}{*1}

\usepackage{nextpage}
\usepackage{xifthen}
% \chapteropen
% chapters start with a full page picture on the left, and a chapter
% page on the right
%  #1 figure scaling factor (times \paperwidth) default is 1
%  #2 figure name
%  #3 chapter name
\newlength{\jh@eventotaloutermargin}
\setlength{\jh@eventotaloutermargin}{\evensidemargin+1in}
% \newcommand{\jh@chapterfigure}[2]{\mbox{\hspace*{-\jh@eventotaloutermargin}\makebox[0em]{\includegraphics[width=#1\paperwidth]{#2}}}}

% For the chapter image, load it at full height and at full width, and then
% see which of the two is the right size (doesn't spill out of page)
\newsavebox{\jh@chaptergraphicrightsized}
\newsavebox{\jh@chaptergraphicrightheight}
\newsavebox{\jh@chaptergraphicrightwidth}
\newlength{\jh@graphicrightheightwidth}
\newlength{\jh@graphicrightheightheight}
\newlength{\jh@graphicrightwidthwidth}
\newlength{\jh@graphicrightwidthheight}

% \jh@loadchapterfigure Grab the image, decide on the size, and put in
% the box \jh@chaptergraphicrightsized
% #1 graphic name; e.g., einstein.jpg 
\newcommand{\jh@loadchapterfigure}[1]{%
  % \typeout{!!! About to read in graphic #1}
  \savebox{\jh@chaptergraphicrightheight}{\includegraphics[height=\paperheight]{#1}}%
  \savebox{\jh@chaptergraphicrightwidth}{\includegraphics[width=\paperwidth]{#1}}%
  % \typeout{!!! Just read in graphic.} 
  \settowidth{\jh@graphicrightheightwidth}{\usebox{\jh@chaptergraphicrightheight}}%
  % \settototalheight{\jh@graphicrightheightheight}{\usebox{\jh@chaptergraphicrightheight}}%
  % \settowidth{\jh@graphicrightwidthwidth}{\usebox{\jh@chaptergraphicrightwidth}}%
  % \settototalheight{\jh@graphicrightwidthheight}{\usebox{\jh@chaptergraphicrightwidth}}%
  % \typeout{!!! Paper height: \the\glueexpr\paperheight} 
  % \typeout{!!! Paper width: \the\glueexpr\paperwidth} 
  % \typeout{!!! Height of rightheight: \the\glueexpr\jh@graphicrightheightheight} 
  % \typeout{!!! Width of rightheight: \the\dimexpr\jh@graphicrightheightwidth} 
  % \typeout{!!! Height of rightwidth: \the\glueexpr\jh@graphicrightwidthheight} 
  % \typeout{!!! Width of rightwidth: \the\dimexpr\jh@graphicrightwidthwidth} 
  % \typeout{!!! About to ifthenelse}
  \ifthenelse{\dimtest{\jh@graphicrightheightwidth}{<=}{\paperwidth}}{%
    % \typeout{!!! using rightheight}
    \savebox{\jh@chaptergraphicrightsized}{%
       \usebox{\jh@chaptergraphicrightheight}}% 
  }{%
    % \typeout{!!! using rightwidth}
    \savebox{\jh@chaptergraphicrightsized}{%
       \usebox{\jh@chaptergraphicrightwidth}}% 
  }
}

% \jh@chapterfigure  Return a box with the figure
\newcommand{\jh@chapterfigure}{%
  \noindent\makebox[\textwidth][l]{%
    \hspace*{-\jh@eventotaloutermargin}%
    \setlength{\unitlength}{1pt}% 
    \begin{picture}(0,0)
      \put(0,0){\raisebox{-0.5\height}{\usebox{\jh@chaptergraphicrightsized}}}
    \end{picture}}%
}

% imagecredit  Give credit in a footnote-like entry for an image
%  #1  text of image credit
\newcommand\imagecredit[1]{%
  \begingroup% 
  \renewcommand\thefootnote{}\footnote{\hskip-\footmarktotextglue\textsc{Image:} #1}%
  \addtocounter{footnote}{-1}%
  \endgroup% 
}

% \chapteropen  Start a chapter
%  #1 optional  image credit; e.g., Einstein archive
%  #2 name of figure; e.g., einstein.jpg
%  #3 chapter name; e.g., Einstein's view
\newcommand{\chapteropen}[3][\relax]{%
  \cleartoevenpage[\thispagestyle{empty}]% clear to the next even page
  \jh@loadchapterfigure{#2}% 
  \thispagestyle{empty}\vspace*{\fill}{\centering\jh@chapterfigure}\vspace*{\fill}% draw the figure
  \clearpage% go to the odd page for the chapter head
  \chapter{#3}\imagecredit{#1}% 
  \Writetofile{\answerbodyfilename}{\protect\chapter{#3}}% 
  \citeadd{\citechapter{\thechapter}{#3}}
  % \citeadd{\citechapter{\arabic{chapter}}{#3}}% 
}

\renewcommand{\thesection}{\thechapter.\Roman{section}}
% \newcommand{\sectiontitlecontents}{Section \\[-.15ex] \thesection}
% \newcommand{\format@section@title}[1]{\normalfont\large\color{boldcolor}#1}
% \titleformat{name=\section}[hang]{\bfseries}{%
%   \mbox{\checkoddpage\ifoddpage%
%       \makebox[0em][r]{\format@section@title{\begin{tabular}[b]{@{}r@{}}\sectiontitlecontents\end{tabular}}\rule{\margin@numberingspace}{0ex}}%
%     \else%
%       \makebox[0em][l]{\rule{\linewidth}{0ex}\rule{\margin@numberingspace}{0ex}\format@section@title{\begin{tabular}[b]{@{}l@{}}\sectiontitlecontents\end{tabular}}}%
%   \fi}%
%   }{0ex}{\normalfont\large\bfseries}[]
\newcommand{\sectiontitlecontents}{\normalfont\large\color{boldcolor}\begin{tabular}[b]{@{}r@{}}Section \\[-.15ex] \thesection\end{tabular}\hspace*{\margin@numberingspace}}
\newcommand{\format@section@title}[1]{\normalfont\large\color{boldcolor}#1}
\newlength{\sectiontitlewidth}
\titleformat{name=\section}[hang]{\bfseries}{%
 \settowidth{\sectiontitlewidth}{\sectiontitlecontents}%
 \llap{\parbox[b]{\sectiontitlewidth}{\sectiontitlecontents\hfill}}%
}{0ex}{\normalfont\large\bfseries}[]
\titlespacing*{\section}{0em}{*4}{*1}

\titleformat{name=\section,numberless}[hang]{\bfseries}{%
 \settowidth{\sectiontitlewidth}{\sectiontitlecontents}%
 \llap{\parbox[b]{\sectiontitlewidth}{\sectiontitlecontents\hfill}}%
  }{0ex}{\normalfont\large\bfseries}[\relax]
% \titlespacing*{\section}{0em}{*4}{*1}

\newcommand{\extra}[1]{%
  \bgroup
  \renewcommand{\sectiontitlecontents}{\normalfont\large\color{boldcolor} Extra\hspace*{\margin@numberingspace}}
  \section*{#1}%
  \addcontentsline{toc}{section}{Extra: #1}%
  \egroup
}

\newlength{\subsectionbeforesep}
\setlength{\subsectionbeforesep}{1.5ex plus0.2ex minus0.1ex}
\newlength{\subsectionaftersep}
\setlength{\subsectionaftersep}{0.8em plus0.2em minus0.1em}
\renewcommand{\thesubsection}{\thechapter.\Roman{section}.{\large \arabic{subsection}}}
% \titleformat{\subsection}[runin]{\bfseries}{%
%   \mbox{\checkoddpage\ifoddpage%
%       \makebox[0em][r]{\normalfont{\color{boldcolor}\thesubsection}\rule{\margin@numberingspace}{0ex}}%
%     \else%
%       \makebox[0em][l]{\rule{\linewidth}{0ex}\rule{1.25\margin@numberingspace}{0ex}\normalfont{\color{boldcolor}\thesubsection}}%
% \fi}}{0ex}{\normalfont\bfseries}[\relax]
% \titlespacing*{\subsection}{0em}{*1.5}{0.8em plus0.2em minus0.1em}
\newcommand{\subsectiontitlecontents}{\normalfont\normalsize\color{boldcolor}\thesubsection\hspace*{\margin@numberingspace}}
\newlength{\subsectiontitlewidth}
\titleformat{\subsection}[runin]{\bfseries}{%
 \settowidth{\subsectiontitlewidth}{\subsectiontitlecontents}%
 \llap{\parbox[b]{\subsectiontitlewidth}{\subsectiontitlecontents\hfill}}%
}{0ex}{\normalfont\bfseries}[\relax]
\titlespacing*{\subsection}{0em}{\subsectionbeforesep}{\subsectionbeforesep}

\newcommand{\extrasubsection}[1]{%
  \bgroup
  \vspace{\subsectionbeforesep}
  \par\noindent\textbf{#1}\hspace{\subsectionaftersep}%
  % \addcontentsline{toc}{section}{Extra: #1}%
  \egroup
}


% http://tex.stackexchange.com/a/98283/339
\newlength\sectionnumberlen
\setlength\sectionnumberlen{\dimexpr\oddsidemargin+1in+\hoffset\relax}
% \titleformat{\section}
%   {leftmargin}
%   {\normalfont\bfseries}
%   {section}{3em}{\relax}
%  {\mbox{\checkoddpage\ifoddpage\makebox[0em][r]{\rule{\margin@numberingspace}{0ex}}}}
%  {\llap{\hspace*{-\sectionnumberlen}\thesection\hfill}}{0em}{}[]
% \titleformat{\section}
%   {\normalfont\bfseries}
%   {\llap{\hspace*{-\sectionnumberlen}\thesection\hfill}}{0em}{}[]
  % [{\makebox[\linewidth][l]{%
  %   \hspace*{-\sectionnumberlen}\rule{\dimexpr\textwidth+\sectionnumberlen\relax}{1pt}}}]

% \titleclass{\part}{part}
% \titleformat{name=\part}[block]{}{Part:}{1ex}{\large\centering}[\relax]
% Summary of titlespacing command:  (*-ed form kills indent of paragraph)
% \titlespacing*{ command }{ left }{ before-sep }{ after-sep }[ right-sep ]





% HEADERS and FOOTERS
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
  \markboth{#1}{#1}}
\renewcommand{\sectionmark}[1]{%
  \markright{#1}}
\renewcommand{\headrule}{{\color{lightcolor}%
  \hrule width\headwidth height\headrulewidth \vskip-\headrulewidth}}

% Main body of book
\renewcommand{\chaptername}{Chapter}
\fancypagestyle{bookbody}{%
  \renewcommand{\headrulewidth}{.4pt}
  \renewcommand{\footrulewidth}{0pt}
  \lhead[\fancyplain{\renewcommand{\headrulewidth}{0pt}}{\thepage}]{\fancyplain{\renewcommand{\headrulewidth}{0pt}}{\color{boldcolor}\textsl{Section \thesection. \rightmark}}}
  \rhead[\fancyplain{}{\color{boldcolor}\textsl{Chapter \thechapter. \leftmark}}]{\fancyplain{}{\thepage}}
  \chead{}
  \lfoot{}
  \rfoot{}
  \cfoot{\fancyplain{\renewcommand{\footrulewidth}{.4pt}\thepage}{}}
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

\pagestyle{bookfront}
\pagenumbering{roman}

% ==========================================================
% TABLE OF CONTENTS
\usepackage{tocloft}
\tocloftpagestyle{empty}
\setlength{\cftchapnumwidth}{3.25em}
\setlength{\cftsecindent}{1em}
\setlength{\cftsecnumwidth}{4.25em}
\setlength{\cftsubsecindent}{2em}
\setlength{\cftsubsecnumwidth}{4.5em}




%================================================================
% PARAGRAPHS
\setlength{\parskip}{0.2ex plus 0.05ex minus 0.05ex}



%================================================================
% FOOTNOTES
% Footnotes: Use footnote symbols (not numbers) on a per-page basis.
% \renewcommand{\thefootnote}{\fnsymbol{footnote}}
\RequirePackage[perpage,symbol*,para,multiple]{footmisc}
\setlength{\footnotemargin}{-1em}
% \DefineFNsymbols{hefferon}{\dagger\ddagger\S}
\DefineFNsymbolsTM*{hefferon}{%
  \textdagger    \dagger
  \textdaggerdbl \ddagger
  \textsection   \mathsection
  \textbardbl    \|%
  \#\#%
}%
\setfnsymbol{hefferon}
\newlength{\footmarktotextglue}
\global\footmarktotextglue=.1em %
\global\footglue=1.25em plus.3em minus.3em % space between footnotes
\long\def\@makefntext#1{\leavevmode % hack footmisc line 391 to change space from footnote mark to footnote
\@makefnmark\nobreak
\hskip\footmarktotextglue\relax#1% was .5em
}


% ============== grammars ===========
% \usepackage{syntax}  % http://ctan.org/pkg/syntax-mdw some conflict with listings
% \newcommand{\nonterminal}[1]{\textit{<#1>}}
% \newcommand{\produces}{$\longrightarrow$}

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

% Don't want \lstinline!..! because it comes out too small.
\usepackage{relsize}
\newcommand\codeinline{\lstinline[basicstyle=\smaller\ttfamily]}

% Note: you can refine the choices with something like:
% \lstset{language=C,caption={Descriptive Caption Text},label=DescriptiveLabel}



% ====================== dates ===========================
\RequirePackage{ifthen}
\let\oldtoday\today
\def\today{%
  \number\year-\ifcase\month\or%
  Jan\or Feb\or Mar\or Apr\or May\or Jun\or%
  Jul\or Aug\or Sep\or Oct\or Nov\or Dec\fi%
  -\ifthenelse{\number\day<10}{0}{}\number\day%
}

% \ymd format date in an ISO-like style
%  #1 year
%  #2 month as an integer
%  #3 day  
\newcommand{\ymd}[3]{%
  \number#1-\ifcase#2\or%
  Jan\or Feb\or Mar\or Apr\or May\or Jun\or%
  Jul\or Aug\or Sep\or Oct\or Nov\or Dec\fi%
  -\ifthenelse{\number#3<10}{0}{}\number#3%
}



% ====================== other styles ===========================
% Make single quotes correct in verbatim 
\usepackage{upquote}

% Make ellipsis space out properly before a period
\usepackage[xspace]{ellipsis}

\usepackage{url}
\usepackage{microtype}

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

% Lists that do not break after a section starts.
% http://tex.stackexchange.com/a/47586/339
% copied from ltlists.dtx
\def\nobreakitem{%
  \@inmatherr\nobreakitem
  \@ifnextchar [\@nobreakitem{\@noitemargtrue \@nobreakitem[\@itemlabel]}}
\def\@nobreakitem[#1]{%
  \if@noparitem
    \@donoparitem
  \else
    \if@inlabel
      \indent \par
    \fi
    \ifhmode
      \unskip\unskip \par
    \fi
    \if@newlist
      \if@nobreak
        \@nbitem
      \else
        \addpenalty\@beginparpenalty
        \addvspace\@topsep
        \addvspace{-\parskip}%
      \fi
    \else
      \addpenalty\@M%only new bit!
      \addvspace\itemsep
    \fi
    \global\@inlabeltrue
  \fi
  \everypar{%
    \@minipagefalse
    \global\@newlistfalse
    \if@inlabel
      \global\@inlabelfalse
      {\setbox\z@\lastbox
       \ifvoid\z@
         \kern-\itemindent
       \fi}%
      \box\@labels
      \penalty\z@
    \fi
    \if@nobreak
      \@nobreakfalse
      \clubpenalty \@M
    \else
      \clubpenalty \@clubpenalty
      \everypar{}%
    \fi}%
  \if@noitemarg
    \@noitemargfalse
    \if@nmbrlist
      \refstepcounter\@listctr
    \fi
  \fi
  \sbox\@tempboxa{\makelabel{#1}}%
  \global\setbox\@labels\hbox{%
    \unhbox\@labels
    \hskip \itemindent
    \hskip -\labelwidth 
    \hskip -\labelsep
    \ifdim \wd\@tempboxa >\labelwidth
      \box\@tempboxa
    \else
      \hbox to\labelwidth {\unhbox\@tempboxa}%
    \fi
    \hskip \labelsep}%
  \ignorespaces}
\renewenvironment{quotation}{\begin{list}{}{%
            \setlength{\parsep}{\parskip}%
            \setlength{\itemsep}{-\parsep}%
            \setlength{\labelwidth}{0em}%
            \setlength{\topsep}{0.5ex}%
            \setlength{\partopsep}{0ex}%
            \setlength{\leftmargin}{\parindent}%
            }\nobreakitem\relax\small%
}{%
  \end{list}%
}
% \renewenvironment{quotation}{%
%   \begin{trivlist}\item\relax\small%
%     \setlength{\parsep}{\parskip}%
%     \setlength{\labelwidth}{0em}%
%     \setlength{\leftmargin}{5\parindent}%
%     \setlength{\itemindent}{0.618\parindent}%
% }{%
%   \end{trivlist}
% }
 

% ================== Some handy definitions =============

% Content definitions broken out separately so they can be used in the graphics
\usepackage{contentmacros}

% Tape sequence
%  List a sequence of executation steps by showing a bunch of tapes 
% Usage: 
%   \begin{tapesequence}
%     \begin{tapesequencetable}
%       0 &\tapegraphic{tapeoutput0.pdf} \\
%       1 &\tapegraphic{tapeoutput1.pdf} \\
%     \end{tapesequencetable}
%   \end{tapesequence}
\newenvironment{tapesequence}{%
  \begin{center} \vspace{-3ex}\renewcommand{\arraystretch}{2.25}
}{%
  \end{center}
}
\newenvironment{tapesequencetable}{%
  \begin{tabular}[t]{r|c} 
    \multicolumn{1}{r}{\textsc{step}} &\textsc{configuration}       \\[-1ex] \hline
}{%
  \end{tabular}
}
\newcommand{\tapegraphic}[1]{%
  \vcenteredhbox{\includegraphics{#1}}%
}

% Wrapping around a figure
\usepackage{wrapfig}

% Captions
\usepackage{caption}[2013/02/03]
\captionsetup{%
  labelformat=empty,
  format=hang,
  justification=RaggedRight,
  indention=1em,
  skip=8pt
}

\RequirePackage{suffix}
% \margingraphic -- graphic that sticks out into margin
% Note placement: i or I, o or O, l or L, r or R (capitals are floats)
% #1 number of affected lines
% #1 width of graphic
% #2 graphic filename
% #3 caption
\captionsetup[wrapfigure]{labelformat=empty,
                          format=hang,              
                          justification=RaggedRight,
                          indention=0.8em,
                          skip=8pt,
                          font=small
}
\newcommand{\margingraphic}[4][r]{%  'r' is right side, no floating
  % \setlength{\intextsep}{6pt plus1pt minus 0.5pt} % space at top and bottom
  \begin{wrapfigure}{#1}[3em]{#2}
    \centering
    \includegraphics[width=#2]{#3}% 
    \caption{#4}
  \end{wrapfigure}}
% For graphic without a caption
\WithSuffix\newcommand\margingraphic*[3][r]{%  'r' is right side, no floating
  % \setlength{\intextsep}{6pt plus1pt minus 0.5pt} % space at top and bottom
  \begin{wrapfigure}{#1}[3em]{#2}
    \centering
    \includegraphics[width=#2]{#3}
  \end{wrapfigure}}

% % Figures sticking into the margin.
% \newlength{\margingraphic@size}  % default width of graphic
% \setlength{\margingraphic@size}{0.3\textwidth}
% \newlength{\margingraphic@border} % width between graphic and text
% \setlength{\margingraphic@border}{1em}
% \newlength{\margingraphic@protrude} % how far graphic protrudes into margin
% \setlength{\margingraphic@protrude}{3em}
% \newlength{\margingraphic@tmp}  % for length calculations
% \newsavebox{\margingraphic@box}  % picture and caption go in here
% \newcommand{\margingraphic@common}[4]{%
%   \setlength{\margingraphic@tmp}{#1}
%     \addtolength{\margingraphic@tmp}{\margingraphic@border}
%     \addtolength{\margingraphic@tmp}{-\margingraphic@protrude}
%   % make a box of the graphic and the caption
%   \savebox{\margingraphic@box}{%
%     \begin{parbox}{#1} 
%       {\centering
%       \includegraphics[width=#1]{#2}
%       \captionof*{figure}{#3}
%       }
%     \end{parbox}}
% }

% \newcommand{\margingraphicleft}[3]{%
%    \begin{wrapfigure}{L}{\margingraphic@tmp}
%       \makebox[\margingraphic@size][r]{\usebox{\margingraphic@box}
%                                                \rule{\margingraphic@border}{0pt}}
%     \end{wrapfigure}}

% % \margingraphic -- graphic that sticks out into margin
% % #1 width of graphic (before it is shifted)
% % #2 graphic filename
% % #3 caption
% \newcommand{\margingraphic}[3][0.2\textwidth]{%
%   % make a border between the text and the graphic, find size of whole
%   \setlength{\margingraphic@tmp}{#1}
%     \addtolength{\margingraphic@tmp}{\margingraphic@border}
%     \addtolength{\margingraphic@tmp}{-\margingraphic@protrude}
%   % make a box of the graphic and the caption
%   \savebox{\margingraphic@box}{%
%     \begin{parbox}{#1} 
%       {\centering
%       \includegraphics[width=#1]{#2}
%       \captionof*{figure}{#3}
%       }
%     \end{parbox}}
%   \mbox{\checkoddpage\ifoddpage%
%     \typeout{!!!! ODD PAGE}
%     KKKKKK
%       \begin{wrapfigure}{R}{\margingraphic@tmp}
%         \typeout{!!!! IN MARGINGRAPHIC}
%         TTTTTT
%         % \makebox[\margingraphic@size][l]{% \rule{\margingraphic@border}{0pt}%
%         %                                  \usebox{\margingraphic@box}}
%       \end{wrapfigure}
%     \else%
%       \begin{wrapfigure}{L}{\margingraphic@tmp}
%         \makebox[\margingraphic@size][r]{\usebox{\margingraphic@box}
%                                                  \rule{\margingraphic@border}{0pt}}
%       \end{wrapfigure}
%     \fi}%
% }

%======================== hyperref ===========
\usepackage{hyperref}
\hypersetup{
    bookmarks=true,         % show bookmarks bar?
    unicode=false,          % non-Latin characters in Acrobat’s bookmarks
    pdftoolbar=true,        % show Acrobat’s toolbar?
    pdfmenubar=true,        % show Acrobat’s menu?
    pdffitwindow=false,     % window fit to page when opened
    pdfstartview={FitH},    % fits the width of the page to the window
    pdftitle={Computing},    % title
    pdfauthor={Jim Hefferon, Saint Michael's College},     % author
    pdfsubject={Theory of Computation},   % subject of the document
    pdfcreator={Jim Hefferon},   % creator of the document
    pdfproducer={Jim Hefferon}, % producer of the document
    pdfkeywords={theory of computation} {computation} {turing machines}, % list of keywords
    pdfnewwindow=true,      % links in new window
    colorlinks=true,       % false: boxed links; true: colored links
    linkcolor=black,          % color of internal links (change box color with linkbordercolor)
    citecolor=black,        % color of links to bibliography
    filecolor=black,      % color of file links
    urlcolor=black           % color of external links
}
% \newcommand\href[2]{\relax}


% ================ animation ================
\usepackage{animate}

% ======== clever references ===============
\usepackage{cleveref} % after hyperref, apparently
\def\thmt@refnamewithcomma #1#2#3,#4,#5\@nil{%
  \@xa\def\csname\thmt@envname #1utorefname\endcsname{#3}%
  \ifcsname #2refname\endcsname
    \csname #2refname\expandafter\endcsname\expandafter{\thmt@envname}{#3}{#4}%
  \fi
}



%============= theorems =============================
% This stuff has to all come after cleveref, which must all come after hyperref
% \usepackage{amsmath} % ,amssymb}
\usepackage{ifoddpage}
\usepackage{framed}
  % \definecolor{shadecolor}{gray}{.95}
  \colorlet{shadecolor}{backgroundcolor}
\usepackage{footnote}
% \usepackage{amsthm}
% \usepackage{ntheorem} 
\usepackage{thmtools}
\declaretheoremstyle[
  spaceabove=.5\thm@preskip, spacebelow=.5\thm@postskip,
  headfont=\normalfont\scshape,
  notefont=\normalfont\scshape, notebraces={ (}{)},
  headformat={\makebox[0em][r]{\NUMBER\rule{\margin@numberingspace}{0ex}}\NAME\NOTE\ignorespaces}, % note that \thetheorem is redefined below so \NUMBER is altered
  % headformat={\mbox{\checkoddpage\ifoddpage%
  %   \makebox[0em][r]{\NUMBER\rule{\margin@numberingspace}{0ex}}\NAME %
  % \else%
  %   \makebox[0em][l]{\rule{\linewidth}{0ex}\rule{\margin@numberingspace}{0ex}\NUMBER}\NAME %
  % \fi}\ignorespaces},
  headpunct={},
  bodyfont=\normalfont,
  % postheadspace={.618em plus .2em minus .1em},
  postheadspace={.55em plus .2em minus .1em},
  preheadhook={\begin{savenotes}\begin{snugshade}}, % savenotes allows appendrefs to appear as footnotes
  postfoothook={\end{snugshade}\end{savenotes}}
%   % for doing this with mdframed, see also http://tex.stackexchange.com/questions/34405/shaded-theorems-thmtools-spanning-pages
  ]{shadedtext}  % for text that has a shaded box behind it TODO: make the frames not add any vertical space, add a rule to the frame

\declaretheoremstyle[
  spaceabove=.35\thm@preskip, spacebelow=.65\thm@postskip,
  headfont=\normalfont\scshape,
  notefont=\normalfont\scshape, notebraces={ (}{)},
  headformat={\makebox[0em][r]{\NUMBER\rule{\margin@numberingspace}{0ex}}\NAME\NOTE\ignorespaces}, % note that \thetheorem is redefined below so \NUMBER is altered
  % headformat={\mbox{\checkoddpage\ifoddpage%
  %   \makebox[0em][r]{\NUMBER\rule{\margin@numberingspace}{0ex}}\NAME %
  % \else%
  %   \makebox[0em][l]{\rule{\linewidth}{0ex}\rule{\margin@numberingspace}{0ex}\NUMBER}\NAME %
  % \fi}\ignorespaces},
  headpunct={},
  bodyfont=\normalfont,
  % postheadspace={.618em plus .2em minus .1em},
  postheadspace={.55em plus .2em minus .1em},
  ]{text}   % for text that is not shaded 

\declaretheoremstyle[
  spaceabove=.15\thm@preskip, spacebelow=.15\thm@postskip,
  headfont=\normalfont\scshape,
  notefont=\normalfont\scshape, notebraces={ (}{)},
  headformat={\NUMBER\NOTE\ignorespaces},
  headindent={-1em},
  headpunct={},
  bodyfont=\normalfont,
  postheadspace={.618em plus .2em minus .1em},
  ]{exercise}   %  

\declaretheoremstyle[
  spaceabove=.15\thm@preskip, spacebelow=.15\thm@postskip,
  headfont=\normalfont\scshape,
  notefont=\normalfont\scshape, notebraces={ (}{)},
  headformat={\NUMBER\NOTE\ignorespaces},
  headindent={-1em},
  headpunct={},
  bodyfont=\normalfont,
  postheadspace={.618em plus .2em minus .1em},
  numberwithin=subsection
  ]{extraexercise}   %  
% \renewcommand{\theextraexercise}{\arabic{exercise}}

\declaretheoremstyle[
  % spaceabove=.5\thm@preskip, spacebelow=.5\thm@postskip,
  headfont=\normalfont\scshape,
  notefont=\normalfont\scshape, notebraces={ (}{)},
  headformat={\NAME\NOTE\ignorespaces}, % note that \thetheorem is redefined below so \NUMBER is altered
  headpunct={},
  bodyfont=\normalfont,
  postheadspace={.618em plus .2em minus .1em},
  prefoothook={\hfill\qedsymbol}
  ]{pf}  % for proofs, with qedsymbol at the end

\declaretheoremstyle[
  spaceabove=.5\thm@preskip, spacebelow=.5\thm@postskip,
  headfont=\normalfont\scshape,
  notefont=\normalfont\scshape, notebraces={ (}{)},
  headformat={\NAME },
  headpunct={},
  bodyfont=\normalfont,
  postheadspace={.618em plus .2em minus .1em},
  preheadhook={\begin{savenotes}}, % savenotes allows appendrefs to appear as footnotes
  postfoothook={\end{savenotes}}
%   % for doing this with mdframed, see also http://tex.stackexchange.com/questions/34405/shaded-theorems-thmtools-spanning-pages
  ]{nonumber}  % for text not numbered

\declaretheoremstyle[
  spaceabove=.5\thm@preskip, spacebelow=.5\thm@postskip,
  headfont=\normalfont\scshape,
  notefont=\normalfont\scshape, notebraces={ (}{)},
  headformat={\NAME },
  headpunct={},
  bodyfont=\normalfont,
  postheadspace={.618em plus .2em minus .1em},
  preheadhook={\begin{savenotes}\begin{snugshade}}, % savenotes allows appendrefs to appear as footnotes
  postfoothook={\end{snugshade}\end{savenotes}}
%   % for doing this with mdframed, see also http://tex.stackexchange.com/questions/34405/shaded-theorems-thmtools-spanning-pages
  ]{shadednonumber}  % for text that has a shaded box behind it 

\declaretheorem[name=Theorem,
                style=shadedtext,
                refname={Theorem,Theorems},
                Refname={Theorem,Theorems},
                numberwithin=subsection]{theorem}
   % \surroundwithmdframed[style=thmstyle]{theorem}\resetparens[theorem]
\renewcommand{\thetheorem}{\arabic{subsection}.\arabic{theorem}}

\declaretheorem[name=Definition,
                style=shadedtext,
                refname={Definition,Definitions},
                Refname={Definition,Definitions},
                sibling=theorem]{definition} 
   % \surroundwithmdframed[style=thmstyle]{definition} \resetparens[definition]

\declaretheorem[name=Church's Thesis,
                style=shadedtext,
                refname={Church's Thesis,Church's Theses},
                Refname={Church's Thesis,Church's Theses},
                sibling=theorem]{churchsthesis} 
   % \surroundwithmdframed[style=thmstyle]{definition} \resetparens[definition]

\declaretheorem[name=Lemma,
                style=shadedtext,
                refname={Lemma,Lemmas},
                Refname={Lemma,Lemmas},
                sibling=theorem]{lemma}
   % \surroundwithmdframed[style=thmstyle]{lemma}\resetparens[lemma]

\declaretheorem[name=Corollary,
                style=shadedtext,
                refname={Corollary,Corollaries},
                Refname={Corollary,Corollaries},
                sibling=theorem]{corollary}
   % \surroundwithmdframed[style=thmstyle]{corollary}\resetparens[corollary]

\declaretheorem[name=Example,
                style=text,
                refname={Example,Examples},
                Refname={Example,Examples},
                sibling=theorem]{example}

\declaretheorem[name=Exercise,
                style=exercise,
                refname={Exercise,Exercises},
                Refname={Exercise,Exercises},
                sibling=theorem]{exercise}

\declaretheorem[name=Notation,
                style=shadednonumber
                refname={Notation,Notations},
                Refname={Notation,Notations},
                ]{notation}

\declaretheorem[name=Remark,
                refname={Remark,Remarks},
                Refname={Remark,Remarks},
                style=nonumber]{remark}

\let\proof\@undefined                     
\let\endproof\@undefined               
\declaretheorem[name=Proof,
                refname={Proof,Proofs},
                Refname={Proof,Proofs},
                style=pf]{proof}

% styling of proofs
\renewcommand{\proofname}{{\scshape\small Proof}}
% End of \begin{proof} ... \end{proof}
\renewcommand{\qedsymbol}{{\scshape\small QED}}

% Problem statements
\declaretheorem[name=Problem,
                style=shadedtext,
                refname={Problem,Problems},
                Refname={Problem,Problems},
                sibling=theorem]{problem} 
\newcommand{\probleminput}{\textit{Input:}}
\newcommand{\problemoutput}{\textit{Output:}}

% In the Extra sections we want the numbering of
% theorem environments to be different, more informal.
\declaretheoremstyle[
  spaceabove=.5\thm@preskip, spacebelow=.5\thm@postskip,
  headfont=\normalfont\scshape,
  notefont=\normalfont\scshape, notebraces={ (}{)},
  headformat={\mbox{\checkoddpage\ifoddpage%
    \makebox[0em][r]{\rule{\margin@numberingspace}{0ex}}\NAME \NOTE%
  \else%
    \makebox[0em][r]{\rule{\margin@numberingspace}{0ex}}\NAME \NOTE%
%     \makebox[0em][l]{\rule{\linewidth}{0ex}\rule{\margin@numberingspace}{0ex}\NUMBER}\NAME %
  \fi}\ignorespaces},
  % headformat={\NAME\NOTE },
  headpunct={},
  bodyfont=\normalfont,
  postheadspace={.618em plus .2em minus .1em},
  preheadhook={\begin{savenotes}\begin{snugshade}}, % savenotes allows appendrefs to appear as footnotes
  postfoothook={\end{snugshade}\end{savenotes}}
%   % for doing this with mdframed, see also http://tex.stackexchange.com/questions/34405/shaded-theorems-thmtools-spanning-pages
  ]{extrashadedtext}  % for text that has a shaded box behind it TODO: make the frames not add any vertical space, add a rule to the frame

\declaretheoremstyle[
  spaceabove=.35\thm@preskip, spacebelow=.65\thm@postskip,
  headfont=\normalfont\scshape,
  notefont=\normalfont\scshape, notebraces={ (}{)},
  headformat={\makebox[0em][r]{\NUMBER\rule{\margin@numberingspace}{0ex}}\NAME\NOTE\ignorespaces}, % note that \thetheorem is redefined below so \NUMBER is altered
  headformat={\mbox{\checkoddpage\ifoddpage%
    \makebox[0em][r]{\rule{\margin@numberingspace}{0ex}}\NAME %
  \else%
    \makebox[0em][r]{\rule{\margin@numberingspace}{0ex}}\NAME %
    % \makebox[0em][l]{\rule{\linewidth}{0ex}\rule{\margin@numberingspace}{0ex}\NUMBER}\NAME %
  \fi}\ignorespaces},
  headformat={\NAME\NOTE },
  headpunct={},
  bodyfont=\normalfont,
  postheadspace={.618em plus .2em minus .1em},
  ]{extratext}   % for text that is not shaded 

\declaretheoremstyle[
  spaceabove=.15\thm@preskip, spacebelow=.15\thm@postskip,
  headfont=\normalfont\scshape,
  notefont=\normalfont\scshape, notebraces={ (}{)},
  headformat={\NUMBER\NOTE\ignorespaces},
  headindent={-1em},
  headpunct={},
  bodyfont=\normalfont,
  postheadspace={.618em plus .2em minus .1em},
  ]{extraexercise}   %  

\declaretheorem[name=Theorem,
                style=extrashadedtext,
                refname={Theorem,Theorems},
                Refname={Theorem,Theorems},
                ]{extratheorem}
   % \surroundwithmdframed[style=thmstyle]{theorem}\resetparens[theorem]
\renewcommand{\theextratheorem}{\arabic{extratheorem}}

\declaretheorem[name=Definition,
                style=extrashadedtext,
                refname={Definition,Definitions},
                Refname={Definition,Definitions},
                sibling=extratheorem]{extradefinition} 
   % \surroundwithmdframed[style=thmstyle]{definition} \resetparens[definition]

\declaretheorem[name=Lemma,
                style=extrashadedtext,
                refname={Lemma,Lemmas},
                Refname={Lemma,Lemmas},
                sibling=extratheorem]{extralemma}
   % \surroundwithmdframed[style=thmstyle]{lemma}\resetparens[lemma]

\declaretheorem[name=Corollary,
                style=extrashadedtext,
                refname={Corollary,Corollaries},
                Refname={Corollary,Corollaries},
                sibling=extratheorem]{extracorollary}
   % \surroundwithmdframed[style=thmstyle]{corollary}\resetparens[corollary]

\declaretheorem[name=Example,
                style=extratext,
                refname={Example,Examples},
                Refname={Example,Examples},
                sibling=extratheorem]{extraexample}

\declaretheorem[name=Exercise,
                style=extraexercise,
                refname={Exercise,Exercises},
                Refname={Exercise,Exercises},
                sibling=extratheorem]{extraexercise}

% This is supposed to turn on the main kind of theorem when it is put in 
% the after code of a \section definition.  I get a stack overflow and 
% I can't figure out why.
% \newcommand{\setmaintheorems}{%
%   \typeout{!!! set main theorems}% 
%   \global\let\theorem=\maintheorem%        
%     \global\let\endtheorem=\endmaintheorem% 
%   \global\let\definition=\maindefinition% 
%     \global\let\enddefinition=\endmaindefinition% 
%   \global\let\lemma=\mainlemma%           
%     \global\let\endlemma=\endmainlemma% 
%   \global\let\corollary=\maincorollary%   
%     \global\let\endcorollary=\endmaincorollary% 
%   \global\let\example=\mainexample%       
%     \global\let\endexample=\endmainexample% 
%   \global\let\exercise=\mainexercise%     
%     \global\let\endexercise=\endmainexercise% 
% }
% \newcommand{\setextratheorems}{%
%   \global\let\theorem=\extratheorem%       
%     \global\let\endtheorem%\endextratheorem 
%   \global\let\definition=\extradefinition% 
%     \global\let\enddefinition=\endextradefinition% 
%   \global\let\lemma=\extralemma%           
%     \global\let\endlemma=\endextralemma% 
%   \global\let\corollary=\extracorollary%   
%     \global\let\endcorollary=\endextracorollary% 
%   \global\let\example=\extraexample%       
%     \global\let\endexample=\endextraexample% 
%   \global\let\exercise=\extraexercise%     
%     \global\let\endexercise=\endextraexercise% 
% }



\newcommand{\definend}[1]{\textcolor{highlightcolor}{#1}}

% thmparts
%  For an enumerated list of the parts of a theorem or lemma or definition
% (anything numbered like a theorem)
\newenvironment{thmparts}{%
  \begin{enumerate}[label={\normalfont\scshape(\alph*)~},
                    align=left, 
                    ref={{\scshape\alph*}},
    topsep={0.25ex plus 0.05ex minus 0.025ex},
    leftmargin=1em,
    rightmargin=0em,
    labelwidth=1em,
    labelsep=0em,
    itemindent=0em,
    parsep={0ex plus 0.1ex},
    listparindent=1em,
    itemsep={0.2ex plus .1ex minus 0.1ex}
    ]
}{%
  \end{enumerate}
}



%============= explorations =============================
% Additional material to go look at.
\newcommand{\exlabel}[1]{%
  \vbox{
    \hbox{\textbf{#1}}
     %\hbox{\raisebox{1ex}{\color{lightcolor}\rule{\textwidth}{0.4pt}}}
  }}

\newenvironment{explorations}{%
  \begin{list}{}{% 
    \let\makelabel\exlabel
    \setlength{\topsep}{2ex plus 0.5ex minus .1ex}
    \setlength{\leftmargin}{1em}
    \setlength{\rightmargin}{0em}
    \setlength{\labelwidth}{1em}
    \setlength{\labelsep}{0.6em}
    \setlength{\itemindent}{0em}
    \setlength{\parsep}{0ex plus 0.1ex}
    \setlength{\listparindent}{1em}
    \setlength{\itemsep}{0.2ex plus .1ex minus 0.1ex}}
    \item[Explorations] \ \\
}{%
  \end{list}
  \vspace{2ex plus .1ex minus 0.1ex}% 
}



%============= exercise =============================
% See also answers section near the top of this file
%
% exercises  environment to surround exercises for each section
% \newcommand{\exlabel}[1]{%
%   \begin{tabular}{@{}l@{}}
%     \textbf{#1} \\[-2ex]
%     {\color{lightcolor}\rule{\textwidth}{0.4pt}}
%   \end{tabular}%
%   \vspace*{-2ex}%
%   }

% Common to exercises and explorations?  Too much for explorations.
\newlength{\exenvironmenttopsep}
\setlength{\exenvironmenttopsep}{4ex plus 1.5ex minus .2ex}

\newenvironment{exercises}{%
% from titlesec: *n in titlespace means: n times 1ex plus .3ex minus .06ex
% so the *3 before means this.
  \begin{list}{}{% 
    \let\makelabel\exlabel
    \setlength{\topsep}{\exenvironmenttopsep}
    \setlength{\leftmargin}{1em}
    \setlength{\rightmargin}{0em}
    \setlength{\labelwidth}{1em}
    \setlength{\labelsep}{0em}
    \setlength{\itemindent}{0em}
    \setlength{\parsep}{0ex plus 0.1ex}
    \setlength{\listparindent}{1em}
    \setlength{\itemsep}{0.2ex plus .1ex minus 0.1ex}}
    % \item[Exercises, Section \thesection] 
    \item[Exercises] 
}{%
  \end{list}
  \vspace{-4ex}% 
}

\newcounter{extraexercisectr}
\newcommand{\extraexerciseslabel}[1]{\stepcounter{extraexercisectr}\normalfont\textsc{#1}}
\newenvironment{extraexercises}{%
  \setcounter{extraexercisectr}{0}
% from titlesec: *n in titlespace means: n times 1ex plus .3ex minus .06ex
% so the *3 before means this.
  \begin{list}{}{% 
    \let\makelabel\extraexerciseslabel
    \setlength{\topsep}{\exenvironmenttopsep}
    \setlength{\leftmargin}{1em}
    \setlength{\rightmargin}{0em}
    \setlength{\labelwidth}{1em}
    \setlength{\labelsep}{0em}
    \setlength{\itemindent}{0em}
    \setlength{\parsep}{0ex plus 0.1ex}
    \setlength{\listparindent}{1em}
    \setlength{\itemsep}{0.2ex plus .1ex minus 0.1ex}}
    % \item[Exercises, Section \thesection] 
    \item[Exercises] 
}{%
  \end{list}
  \vspace{-4ex}% 
}


\newenvironment{exparts}{%
  \begin{enumerate}[topsep=0ex,
                    itemsep=0ex, parsep=0ex,
                    leftmargin=2em,labelwidth=0.5em,labelsep=.16667em plus .08333em,
                    label={(\scshape\alph*)\nobreak\hspace{.16667em plus .08333em}}] 
}{%
  \end{enumerate}
}

% produce an inline list
\newenvironment{exparts*}{%
  \begin{enumerate*}[label={\scshape(\alph*)\nobreak\hspace{.16667em plus .08333em}},
                     itemjoin={\hspace{0.6em plus .1em minus .1em\linebreak[2]}},
                     before={\hspace{0.6em plus .1em minus .1em\linebreak[2]}}]
}{%
  \end{enumerate*}
}


% Grammars
\usepackage{syntax}
\newlength{\grammarmargin}
\setlength{\grammarmargin}{5em}
\renewenvironment{grammar}{%
  \list{}{%
    \labelwidth\grammarindent%
    \leftmargin\grammarmargin%
    \advance\grammarindent\labelsep
    \itemindent\z@%
    \listparindent\z@%
    \parsep\grammarparsep%
  }%
  \let\\\@normalcr
  \syntaxShortcuts\relax\relax%
  % \def\alt{\\\llap{\textbar\hspace*{0em}}}% Comment this out from .sty file to adjust spacing
  \def\gr@setpar{%
    \def\par{%
      \parshape\@ne\@totalleftmargin\linewidth%
      \@@par%
      \catcode`\<12%
      \everypar{%
        \everypar{}%
        \catcode`\<\active%
        \gr@implitem%
      }%
    }%
  }%
  \gr@setpar%
  \par%
  \let\gr@leftsq\[%
  \let\gr@rightsq\]%
  \def\gr@endsyntdiag]{\end{syntdiag}\gr@setpar\par}%
  \def\[{\@ifnextchar[{\begin{syntdiag}\@gobble}\gr@leftsq}%
  \def\]{\@ifnextchar]\gr@endsyntdiag\gr@rightsq}%
}{%
  \@newlistfalse%
  \everypar{}%
  \endlist%
}
\setlength{\grammarparsep}{0pt plus 0.25pt} % vert space between prods
\setlength{\grammarindent}{5em} %
\renewcommand{\grammarlabel}[2]{%
  \hspace*{1.25em}\synt{#1} \hfill#2%
}
\def\alt{\\\llap{\textbar\hspace*{0.35em}}}%

% Env to indent text
\newenvironment{clip}{%
  \begin{list}{}{\setlength{\leftmargin}{1.25em}
                 \setlength{\parsep}{\grammarparsep}}\item[]
}{%
  \end{list}%
}

% Used for derivations; gives a raggedright block of indented text
% \begin{displayedsteps}
%  \initialstep\syntax{<start>}
%   ..
% \end{displayedsteps}
\newenvironment{displayedsteps}{%
  \begin{list}{}%
      {\listparindent 1em%
       %\itemindent    \listparindent
       % \leftmargin 2em%
       \rightmargin 1em%
       \parsep        \z@ \@plus\p@}%
       \item\relax \raggedright
}{%
  \end{list}
}
\newcommand{\initialstep}{\hspace*{-1em}}




% ====================== figures ===========================
% Figures and captions
\usepackage{float}
\newfloat{animatefigure}{H}{lof}
\newfloat{tablehere}{H}{lof}
\usepackage{caption} 
\captionsetup{font=small,
              format=hang,
              indention=2em,
              labelformat=simple,
              labelsep=space,
              labelfont=sc,
              textformat=simple,
              position=bottom,
              justification=RaggedRight
              }
\captionsetup[animatefigure]{labelformat=empty}
\renewcommand{\theanimatefigure}{\arabic{section}.\arabic{animatefigure}}
\newenvironment{animatedfigure}[1]{%
  \begin{animatefigure}[H]
  \setcounter{animatefigure}{\value{theorem}}  % for \cref
  \refstepcounter{theorem}
  \caption{\textsc{\thetheorem~Animation:} #1}
  % \caption{\small \textsc{Click to animate.} #1}
  \centering
}{%
  \end{animatefigure}
}
\crefname{animatefigure}{Animation}{Animations}
\Crefname{animatefigure}{Animation}{Animations}


\captionsetup[tablehere]{labelformat=empty}
% \newcounter{tablehere}
\renewcommand{\thetablehere}{\arabic{section}.\arabic{tablehere}}
\newenvironment{tablefigure}[1]{%
  \begin{tablehere}[H]
  \setcounter{tablehere}{\value{theorem}}
  \refstepcounter{theorem}
  \caption{\thetheorem~\textsc{Table:} #1}
  \centering
}{%
  \end{tablehere}
}
\crefname{tablehere}{Table}{Tables}
\Crefname{tablehere}{Table}{Tables}
