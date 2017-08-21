% computing.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{computing}[2014/08/08 Class for computing book]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions \relax
\LoadClass[twoside]{book}

% Use UTF-8
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\input{glyphtounicode}% Make PDF offer better copy and paste
  \pdfgentounicode=1

\usepackage{amsmath, amssymb} % no amsthm; use ntheorem because of margin numbering

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
\usepackage{adjustbox} % for clipping pictures

\usepackage{etoolbox}
% \usepackage{trace}  % for debugging

% ========== enumitem =============
\usepackage[inline]{enumitem}
% parenum
%  Enumerate inside a paragraph
\newenvironment{parenum}{%
  \begin{enumerate*}[label=(\arabic*),]%
}{%
  \end{enumerate*}
}



% ===== Page Headers and Footers =============
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
  % \lhead[\fancyplain{\renewcommand{\headrulewidth}{0pt}}{\color{boldcolor}\textsl{\thepage}}]{\fancyplain{\renewcommand{\headrulewidth}{0pt}}{\color{boldcolor}\textsl{\leftmark}}}
  % \rhead[\fancyplain{}{\color{boldcolor}\textsl{\rightmark}}]{\fancyplain{}{\color{boldcolor}\textsl{\thepage}}}
  % \chead{}
  % \lfoot{}
  % \rfoot{}
  % \cfoot{\fancyplain{\renewcommand{\footrulewidth}{.4pt}\\textsl{thepage}}{}}
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

\pagestyle{bookfront}
\pagenumbering{roman}


% ============================================================
% Behavior inside and outside the Extra sections
% This is the main complication; I want that inside an Extra things
% are numbered less formally, etc.
%   You can find this section by searching for "EXTRA SECTION TOGGLE"
\usepackage{etoolbox}
\newtoggle{insideextrasection} % True if inside an extra section, false ow. 
% Notes
% 1) This is set to false in a chapter command, and true in an extra command;
%   search for the string "EXTRA TOGGLE RESET", 



%================================================================
% PARAGRAPHS
\setlength{\parskip}{0.2ex plus 0.05ex minus 0.05ex}



%================================================================
% FOOTNOTES
% Footnotes: Use footnote symbols (not numbers) on a per-page basis.
% \renewcommand{\thefootnote}{\fnsymbol{footnote}}
\RequirePackage[perpage,symbol*,para,multiple]{footmisc}
\setlength{\footnotemargin}{-1em}
\DefineFNsymbolsTM*{hefferon}{%
  \textdagger    \dagger
  \textdaggerdbl \ddagger
  \textsection   \mathsection
  \textbardbl    \|%
  \#\#%
}%
\setfnsymbol{hefferon}
\newlength{\footmarktotextglue}
\global\footmarktotextglue=.1em plus .05em minus .02em %
% was: \global\footglue=1.25em plus.3em minus.3em % space between footnotes
\global\footglue=0.65em plus.2em minus.1em % space between footnotes
\long\def\@makefntext#1{\leavevmode % hack footmisc line 391 to change space from footnote mark to footnote
\smash{\@makefnmark}\nobreak
\hskip\footmarktotextglue\relax#1% was .5em
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
\AtEndDocument{\Closesolutionfile{\answerbodyfilename}}

% I want to pass a string like Three.II.1 as the ans argument in the answerfile.
% But I get an infinite loop expanding \Numberstring{chapter}.  So I am
% passing 3.II.1 and figuring I'll figure out later how to translate the
% 3 to a Three.
\renewcommand{\Currentlabel}{\arabic{chapter}.\@currentlabel}


% ========== Exercises =======================

% Suppress page break between "Exercises" and top of list
%  see https://tex.stackexchange.com/a/210847/121234
\newlength{\jh@listtopsep}
  % \setlength{\jh@listtopsep}{2.3ex plus 0.2ex}
  \setlength{\jh@listtopsep}{1ex plus 0.2ex minus 0.1ex}
  \newcommand{\nolisttopbreak}{\vspace{\jh@listtopsep}\nobreak\@afterheading} 

% Get the width of a single character; use it for the left margin
\newlength{\jh@widthofchar}
\newsavebox{\jh@widthofcharbox}
\savebox{\jh@widthofcharbox}{\scshape 0}
\settowidth{\jh@widthofchar}{\hbox{\scshape 0}}  

% Define the exercises environment
\newcounter{@exercisenumber}[section]
\renewcommand{\the@exercisenumber}{\Alph{section}.\arabic{@exercisenumber}}
\newcommand{\@exercisecounterstart}{\thesection} % put in the margin to count exercises env
\newcommand{\@exercisecounterlabel}{\normalfont\scshape\the@exercisenumber\hspace*{0.6em}}
\newenvironment{exercises}{%
  \vspace{3.25ex plus 1ex minus 0.2ex}\par\noindent\marginnote{\normalfont\scshape \@exercisecounterstart}{\normalfont\bfseries Exercises}%
  \nolisttopbreak
  \begin{list}{\@exercisecounterlabel}%
     {\usecounter{@exercisenumber}
      \setcounter{@exercisenumber}{\value{theorem}}
      \renewcommand{\makelabel}[1]{\normalfont\scshape ##1}
      \setlength{\leftmargin}{\jh@widthofchar}
      \setlength{\labelwidth}{\leftmargin}
      \setlength{\labelsep}{0em}
      \setlength{\itemindent}{0em}
      \setlength{\listparindent}{0.8\parindent}
      \setlength{\topsep}{\jh@listtopsep}
      \setlength{\parsep}{0ex}
      \setlength{\itemsep}{0.6ex plus 0.25ex minus 0.05ex}
      \setlength{\rightmargin}{0em}
      % Encourage a page break betweeen items; LaTeX book.cls has
      % \@itempenalty     -\@lowpenalty
      \@itempenalty-\@medpenalty %
      % Also discourage clubs and widows
      \clubpenalty6000 % % discourage breaking after first line
      \widowpenalty6000 % discourage breaking before last line
    }
}{%
  \end{list}
}
\newenvironment{exercise}{%
  \item
}{%
}

% Exparts
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
  \begin{enumerate*}[label={\scshape(\alph*)\nobreak\hspace{.16667em plus .08333em}},
                     itemsep=0em,labelsep=0em,labelindent=0em,itemindent=0em,
                     itemjoin={\hspace{0.6em plus .1em minus .1em\linebreak[2]}},
                     % before={\hspace{0.6em plus .1em minus .1em\linebreak[2]}}
                     ]
}{%
  \end{enumerate*}
}

% For naming a part of an exercise, as in \item \expartsname{Commutativity}
\newcommand{\expartsname}[1]{\textsc{(#1)}} 

% For a hint
\newcommand{\hint}{\textit{Hint:}} % no space because want to use a tie: ~




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


%%%%%%%%%%%%%%%%%
% Parts 
\renewcommand{\part}[1]{\clearemptydoublepage\thispagestyle{bookemptypage}%
  \vspace*{\fill}%
  \refstepcounter{part}
  \begin{center}
    \normalfont\Large{\color{boldcolor}Part \thepart} \\[1.25ex]
    \LARGE #1
  \end{center}
  \vspace*{\fill}%
}
\renewcommand{\thepart}{\Alph{part}}

%%%%%%%%%%%%%%%%%
% Chapters
% As with sections, put the numbering in the margin using a marginpar
% (actually a marginnote that has been hacked to always be on the left).
\renewcommand{\chapter}{%
  % Record that we are not inside an Extra section.
  % For more info search for "EXTRA SECTION TOGGLE".
  \global\togglefalse{insideextrasection} % find this by searching for: EXTRA TOGGLE RESET
  \renewcommand{\thesubsection}{\arabic{subsection}}  % set theorem numbering to be as outside Extra sections
  % 
  \pagestyle{bookbody}
  \thispagestyle{bookemptypage}
  %
  \@startsection{chapter}{0}%
  {0em}%
  {-5ex plus -1.5ex minus -.3ex}% *5 from titlesec
  {1ex plus .3ex minus .06ex}% *1 from titlesec
  {\marginnote{\smash{\normalfont\Large\color{boldcolor}\begin{tabular}[b]{@{}r@{}} Chapter \\[-0.15ex] \thechapter\end{tabular}}}[1.4ex]\normalfont\Large\bfseries}%
}

\usepackage{fmtcount}
\renewcommand{\thechapter}{\Numberstring{chapter}}

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
\newlength{\jh@eventotaloutermargin}
\setlength{\jh@eventotaloutermargin}{\evensidemargin}
\addtolength{\jh@eventotaloutermargin}{1in}
\newcommand{\chapteropen}[3][\relax]{%
  \cleartoleftpage
  \thispagestyle{empty}%
  \vspace*{\stretch{1}}  % vertically center on the page
  {\noindent\hspace*{-\jh@eventotaloutermargin}% Move everything left by \evensidemargin
  % The graphicx package will pick the smaller of the height and width
  \makebox[\linewidth][l]{\includegraphics[height=\paperheight,
                   width=\paperwidth,
                   keepaspectratio]{#2}}}%
  \vspace*{\stretch{1}} % vertically center
  \clearpage
  \chapter{#3}\imagecredit{#1}%
  \Writetofile{\answerbodyfilename}{\protect\chapter{#3}}}


%%%%%%%%%%%%%%%%%%%
% Sections, subsections

% Put section names in margin with marginpar; acutally marginnote.
\setlength{\marginparsep}{1em}
\usepackage{marginnote}
% Hack that to make them always on left margin despite twoside option;
% see https://tex.stackexchange.com/a/73117/121234
\patchcmd{\@mn@margintest}{\@tempswafalse}{\@tempswatrue}{}{}
\patchcmd{\@mn@margintest}{\@tempswafalse}{\@tempswatrue}{}{}
\reversemarginpar 

% \sectiontitlecontents
% endnotes makes the Notes page with a \section*{...} command.  I want
% to make the "Section One.II" come out in the document body, but have
% it disappear in the Notes page.  So there I redefine it to \relax.
\newcommand{\sectiontitlecontents}[1]{#1}

\setcounter{secnumdepth}{10}  % Display them all
\renewcommand\@seccntformat[1]{\relax} % no numbering inside section title
\newlength{\jh@margintxttobodytext}
  \setlength{\jh@margintxttobodytext}{0.0em}
% Section
\renewcommand{\section}{%
  \renewcommand{\@exercisecounterstart}{\thesection}% put in the margin to count exercises env
  \renewcommand{\the@exercisenumber}{\Roman{section}.\arabic{@exercisenumber}}%
  \@startsection{section}{1}%
  {0em}%
  {-3.5ex plus -1ex minus -0.2ex}%
  {2.3ex plus .2ex}%
  {\sectiontitlecontents{\marginnote{\smash{\normalfont\scshape\begin{tabular}[b]{@{}r@{}} Section \\ \Numberstring{chapter}.\Roman{section}\end{tabular}\hspace*{\jh@margintxttobodytext}}}}\normalfont\bfseries}%
}
\renewcommand{\thesection}{\Roman{section}}


% Subsections
\renewcommand{\subsection}{%
  \@startsection{subsection}{2}%
  {0em}%
  {-3.25ex plus -1ex minus -0.2ex}%
  {-0.6em plus -0.1em}%  negative makes it a run-in header
  {\marginnote{\normalfont\scshape \Roman{section}.\arabic{subsection}}\normalfont\bfseries}%
}
\renewcommand{\thesubsection}{\arabic{subsection}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extra
% These are optional topics that are covered at the end of each chapter.  The
% formatting of theorems, exercises, etc. is a bit looser.
\newcounter{extra}[chapter]
\renewcommand{\theextra}{\Numberstring{chapter}.\Alph{extra}}
\newcommand{\extra}{%
  % Record that we are now inside an Extra section.
  % For more info search for "EXTRA SECTION TOGGLE".
  \global\toggletrue{insideextrasection} % find this by searching for: EXTRA TOGGLE RESET
  \renewcommand{\@exercisecounterstart}{\theextra} % put in the margin to count exercises env
  \setcounter{theorem}{0}
  \setcounter{subsection}{\the\numexpr\value{extra}+1\relax}
  \renewcommand{\thesubsection}{\Alph{subsection}} % Set theorem numbering for inside Extra sections
  \renewcommand{\the@exercisenumber}{\Alph{section}.\arabic{@exercisenumber}}
  % For headers
  % \let\sectionmark=\extramark %
  %
  \@startsection{extra}{2}%
  {0em}%
  {-3.25ex plus -1ex minus -0.2ex}%
  {-0.6em plus -0.1em}%  negative makes it a run-in header
  {\marginnote{\smash{\normalfont\scshape\begin{tabular}[b]{@{}r@{}} Extra \\ \theextra\end{tabular}\hspace*{\jh@margintxttobodytext}}}\normalfont\bfseries}%
}
\newcommand*\l@extra{\@dottedtocline{6}{10em}{5em}}% for toc
\newcommand{\extramark}[1]{
  \markright{Extra\ \thesubsection.\ #1}}% for page headers



%======================== hyperref ===========
\usepackage[draft]{hyperref}  % remove the draft option at the end.
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
% \newcommand\hyperref[2][\relax]{#2}



\usepackage{cleveref} % part of DeclareTheorem gives the refname's



% ======== clever references ===============
\usepackage{cleveref} % after hyperref, apparently
\def\thmt@refnamewithcomma #1#2#3,#4,#5\@nil{%
  \@xa\def\csname\thmt@envname #1utorefname\endcsname{#3}%
  \ifcsname #2refname\endcsname
    \csname #2refname\expandafter\endcsname\expandafter{\thmt@envname}{#3}{#4}%
  \fi
}


% ============ Theorems ========================
% Theorems
% These need to be numbered all as one, and the numbering in the margin

% The cleveref package requires that theorems be made with either amsthm
% or ntheorem.  I couldn't get the first to put numbering in the margins,
% whereas the second had that built in, so I went with it.
\usepackage[thmmarks,amsmath]{ntheorem} % see https://tex.stackexchange.com/a/50602/121234
% % Make thmstyle with numbers in margin; see https://tex.stackexchange.com/a/59267/121234
\newtheoremstyle{marginnumbers}%
{\item[\theorem@headerfont\llap{##2\hspace*{0.5em}}]{\theorem@headerfont ##1} }%
{\item[\theorem@headerfont\llap{##2\hspace*{0.5em}}]{\theorem@headerfont ##1\ (##3)} }%
\theoremheaderfont{\scshape}
\theorembodyfont{}    
\theoremsymbol{}
\theoremprework{}
\theorempostwork{}
\theoremseparator{}
\theorempreskip{.5\topsep}
\theorempostskip{.5\topsep}
\usepackage{thmtools}
% \shadecolor{backgroundcolor}  % Use this as the background color for theorems
\declaretheorem[style=marginnumbers,
                shaded={bgcolor=backgroundcolor},
                refname={Theorem,Theorems},
                Refname={Theorem,Theorems}]{theorem}
\numberwithin{theorem}{subsection}
\declaretheorem[style=marginnumbers,
                shaded={bgcolor=backgroundcolor},
                refname={Lemma,Lemmas},
                Refname={Lemma,Lemmas},
                sibling=theorem]{lemma}
\declaretheorem[style=marginnumbers,
                shaded={bgcolor=backgroundcolor},
                refname={Corollary,Corollary},
                Refname={Corollary,Corollary},
                sibling=theorem]{corollary}
\declaretheorem[style=marginnumbers,
                shaded={bgcolor=backgroundcolor},
                refname={Definition,Definitions},
                Refname={Definition,Definitions},
                sibling=theorem]{definition}
\declaretheorem[style=marginnumbers,
                refname={Example,Examples},
                Refname={Example,Examples},
                sibling=theorem]{example}
\declaretheorem[style=marginnumbers,
                refname={Remark,Remarks},
                Refname={Remark,Remarks},
                sibling=theorem]{remark}
\declaretheorem[style=nonumberplain,
                refname={Proof,Proofs},
                Refname={Proof,Proofs},
                ]{proof}
\declaretheorem[style=marginnumbers,
                title={Church's Thesis},
                refname={Church's Thesis,Church's Thesis},
                Refname={Church's Thesis,Church's Thesis},
                sibling=theorem]{churchsthesis}
\declaretheorem[style=marginnumbers,
                refname={Problem,Problems},
                Refname={Problem,Problems},
                sibling=theorem]{problem}
\newcommand{\probleminput}{\textit{Input:}}
\newcommand{\problemoutput}{\textit{Output:}}

% \definend
% The thing being defined.
\newcommand{\definend}[1]{\textcolor{highlightcolor}{#1}}
                
% thmparts
% An enumerated list inside the paragraph of the parts of a theorem, or
% lemma or definition
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

% ========== Bibliography =============
% biblatex 
\usepackage[backend=biber,style=authoryear,sorting=nyt]{biblatex}
\addbibresource{computing.bib}


% ============= Citations ============
% citetext
%  Reference text in the body.
% #1 text referenced in the citations
% #2 Citation
%  Example:
%   The soldiers could 
%    \citetext{see his hairy legs}{OR C Dobson, p 1094.}.
% produces an end note like 
%    \textit{see his hairy legs} OR C Dobson, p 1094.

\usepackage{endnotes} %, endheads}
\newcommand{\citetext}[2]{#1%
  \endnote{\protect\hspace*{-2em}\textit{#1}\protect\hspace{.618em} #2}}
\renewcommand{\makeenmark}{\relax} % leave no mark
\newcommand{\citeadd}[1]{\addtoendnotes{#1}}

\renewcommand{\notesname}{Notes}
\usepackage{hanging} % make cited text be in hanging indented paragraphs
% \def\enoteheading{\section*{\notesname
%   \@mkboth{\MakeUppercase{\notesname}}{\MakeUppercase{\notesname}}}%
%   \mbox{}\par\vskip-\baselineskip}
\def\enoteformat{\rightskip\z@ \leftskip 2em \parindent=0em\hangpara{2em}{1}%
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

\newcommand{\jhendnoteshook}{These are citations or discussions that
  supplement the main line of development in the text body.
  For each there is a word or phrase in italics from that text body, and 
  then the notes are in plain text.
  Many of the citations or discussions include sources for you to read more,
  with a web link if possible.
  }

\newcommand{\printnotes}{%
  \newpage
  \begingroup
  % \parindent 0pt
  \parskip=1ex plus 0.2ex minus 0.1ex %
  \def\enotesize{\normalsize}
  % \hangparas{-2em}{-1}
  \renewcommand{\sectiontitlecontents}[1]{\relax} % Cause the "Section One.II" not to printed.
  \vspace*{0.25ex plus 0.02ex}
  \thispagestyle{bookemptypage}
  \theendnotes
  \endgroup
  }

% ==========================================================
% TABLE OF CONTENTS
\usepackage{tocloft}
\tocloftpagestyle{empty}
\setlength{\cftchapnumwidth}{3.25em}
\setlength{\cftsecindent}{1em}
\setlength{\cftsecnumwidth}{4.25em}
\setlength{\cftsubsecindent}{2em}
\setlength{\cftsubsecnumwidth}{5em}




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

% Make single quotes correct in verbatim 
\usepackage{upquote}



% ================ animation ================
\usepackage{animate}




% ====================== figures ===========================
% Figures and captions
\usepackage{float}
\newfloat{animatefigure}{H}{lof}
\newfloat{tablehere}{H}{lof}
\newfloat{figurehere}{H}{lof}


\usepackage{caption} 
\DeclareCaptionLabelSeparator{jhcaptionspace}{\hspace{0.6em}}
\captionsetup{font=small,
              format=hang,
              indention=2em,
              labelformat=simple,
              labelsep=jhcaptionspace,
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

\captionsetup[figurehere]{labelformat=empty}
\renewcommand{\thefigurehere}{\arabic{section}.\arabic{figurehere}}
\newcommand{\figlabel}{\relax} % can't use evn arg #1 in second half so save it
\newcommand{\figcapt}{\relax} % can't use evn arg #2 in second half so save it
\newenvironment{fig}[2][]{%
  \renewcommand\figlabel{#1}% Save for use in second half
  \renewcommand\figcapt{#2}% Save for use in second half
  \begin{figurehere}[H]
  \setcounter{figurehere}{\value{theorem}}
  \refstepcounter{theorem}
  \centering
}{%
  \caption{\thetheorem~\textsc{Figure:} \figcapt} \label{\figlabel}
  \end{figurehere}
}
\crefname{figurehere}{Figure}{Figures}
\Crefname{figurehere}{Figure}{Figures}


% =================== Margin graphics ===================
% put graphics in the pargin

% Wrapping around a figure
\usepackage{wrapfig}
% Set space around wrapfig figures
% see http://tex.stackexchange.com/a/111397/339
\setlength{\intextsep}{6pt plus 1pt minus 0.25 pt}% vertical padding; default: 12.0pt plus 2.0pt minus 2.0pt
\setlength{\columnsep}{10pt}% horizontal padding; default: 10pt

% Captions
\usepackage{caption}[2013/02/03] % \usepackage{subcaption}
% \captionsetup{%
%   labelformat=empty,
%   labelsep=quad,
%   labelfont=bf,
%   format=hang,
%   justification=RaggedRight,
%   indention=1em,
%   skip=8pt
% }
\captionsetup[figure]{labelformat=empty,
  format=hang,              
  justification=RaggedRight,
  indention=0.8em,
  skip=8pt,
  font=small
}

\RequirePackage{suffix}
% \margingraphic -- graphic that sticks out into margin
% Note placement: i or I, o or O, l or L, r or R (capitals are floats)
% #1 l or r  which margin; r is default
% #2 width of graphic
% #3 graphic filename
% #4 caption
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
% margingraphicnomag Same as margin graphic, but the graphic is not magnified
\newcommand{\margingraphicnomag}[4][r]{%  'r' is right side, no floating
  % \setlength{\intextsep}{6pt plus1pt minus 0.5pt} % space at top and bottom
  \begin{wrapfigure}{#1}[3em]{#2}
    \centering
    \includegraphics{#3}% 
    \caption{#4}
  \end{wrapfigure}}
% For graphic without a caption
\WithSuffix\newcommand\margingraphicnomag*[3][r]{%  'r' is right side, no floating
  % \setlength{\intextsep}{6pt plus1pt minus 0.5pt} % space at top and bottom
  \begin{wrapfigure}{#1}[3em]{#2}
    \centering
    \includegraphics{#3}
  \end{wrapfigure}}




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



% ============ Misc typographic widgets ==========

% hangingpar  Hanging paragraph
%  #1  length of hanging
\newenvironment{hangingpar}[1][1em]
  {\begin{list}
          {}
          {\setlength{\itemindent}{-#1}%%'
           \setlength{\leftmargin}{#1}%%'
           \setlength{\itemsep}{0pt}%%'
           \setlength{\parsep}{\parskip}%%'
           \setlength{\topsep}{\parskip}%%'
           }
    \setlength{\parindent}{-#1}%%
    \item[]
  }
  {\end{list}}

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


% =============
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



% == blkarray ====
%   Extended array features, such as labelled rows and columns
\usepackage{blkarray} 




% === dates ====
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
\newenvironment{tapesequence}{%
  % \vspace{1.5ex plus 0.25ex minus 0.15ex}%
  \begin{center} % \vspace{-3ex}
    \renewcommand{\arraystretch}{2.25}
}{%
  \end{center}
  % \vspace{-1.5ex plus 0.25ex minus 0.15ex}% arraystretch leaves extra?
}
\newenvironment{tapesequencetable}{%
  % \vspace{2.5ex plus 0.25ex minus 0.15ex}%
  \begin{tabular}[t]{r|c} 
    \multicolumn{1}{r}{\renewcommand{\arraystretch}{1.0}%
                         % \rule{0em}{2ex}
                         \begin{tabular}[b]{@{}c@{}}
                           \textsc{after} \\[-0.425ex] 
                           \textsc{step} 
                         \end{tabular}} 
     &\textsc{configuration}                        \\[-1ex] \hline
}{%
  \end{tabular}%
}
\newcommand{\tapegraphic}[1]{%
  \vcenteredhbox{\includegraphics{#1}}%
}


% ==== Grammars ==== (Asy doesn't like it) 
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
    \small
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
\setlength{\grammarparsep}{0pt plus 0.15ex} % vert space between prods
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


% ==== Remaining content macros ======
% Broken out separately so they can be used in the
% Asymptotegraphics
\usepackage{contentmacros}

