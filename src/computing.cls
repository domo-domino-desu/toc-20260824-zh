% computing.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{computing}[2014/08/08 Class for computing book]

% This dir name allows using this .cls file from other dirs,  such as complexity/
\providecommand{\computingClsDir}{.}  

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions \relax
\LoadClass[twoside]{book}

\usepackage{etoolbox}

% Look in the file papercopyflag for about whether this is making paper copies
\input{\computingClsDir/papercopyflag}

% Use UTF-8
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\input{glyphtounicode}% Make PDF offer better copy and paste
  \pdfgentounicode=1

\usepackage{mathtools}  
\usepackage{amsmath}
% Fix some font-loading error
\let\Bbbk\relax
\usepackage{amssymb, amsthm} 

% M Sharpe's XCharter
% \usepackage[scaled=.98,sups,osf]{XCharter}% lining figures in math, osf in text
% \usepackage[scaled=1.04,varqu,varl]{zi4}% inconsolata typewriter
% \usepackage[type1]{cabin}% sans serif
% \usepackage[libertine,bigdelims,vvarbb,scaled=1.07]{newtxmath}
% \usepackage[cal=boondoxo]{mathalfa}
% \linespread{1.04}
\usepackage{\computingClsDir/computingfonts}

% This must be early in the class file to avoid an option clash
\usepackage[hyphens]{url}  % allow splitting at hyphens
% \g@addto@macro{\UrlBreaks}{\UrlOrds} % allow break at ord chars; https://tex.stackexchange.com/a/10419/339 
% \DeclareUrlCommand\pathname{\urlstyle{tt}}
\usepackage[hyphens]{xurl}  % 2022-Jun-05; allow break at any char

% Get RaggedRight
\usepackage{ragged2e}


% Get some file directories in this layout, such as where graphics are
\input{\computingClsDir/directory.tex}
% Define where the asy/ directory is, which will change from chapter 
% to chapter, for the slides
\newcommand{\asydir}{} 


\usepackage{calc}
\RequirePackage[papersize={7.5in,9.25in},
                textwidth=345pt,    % LaTeX default 4.744 inches
                % textheight=550pt,  % LaTeX default
                inner=.8in,
                top=60pt, % 72.27-15.2\approx 60 (lower down head height is 15.2)
                % bottom=57.07pt,
                % top=1in,
                % bottom=1in, % 72.27 - 24.29494 pt (from \the\footskip)
                footskip=\dimexpr\headsep+\ht\strutbox\relax,
                textheight=\dimexpr9.25in-2\dimexpr60pt\relax, % \paperheight and \topmargin don't work here
                headsep=12pt,
                bindingoffset=0.4in,
                % showframe,  % show lines for the margins
                ]{geometry}

\RequirePackage[dvipsnames]{xcolor}
\input{\computingClsDir/colorscheme.tex}  % change the color scheme
\RequirePackage{graphicx}

\usepackage{adjustbox} % for clipping pictures

% \usepackage{trace}  % for debugging

% Get the name of the file into the error message https://tex.stackexchange.com/q/724002/339
\usepackage{currfile} 
\def\on@line{ on input line \the\inputlineno\space in \currfilepath}

% ========== lengths on which others are set =============
\setlength{\topsep}{8.0pt plus 2.0pt minus 2.0pt}  % bk10.clo has it set to 8pt


% ========== tables =============
\usepackage{multirow}

% ========== enumitem =============
\usepackage[inline]{enumitem}
% parenum
%  Enumerate inside a paragraph
\newenvironment{parenum}{%
  \begin{enumerate*}[label=(\arabic*),
                     before=\unskip{\nobreak\ \mbox{}}]%
}{%
  \end{enumerate*}
}

\newenvironment{exercisedescription}{%
  \begin{description}[topsep=0ex,parsep=0ex,itemsep=0ex,
                      labelsep=0.5em,labelwidth=0.5em,itemindent=0.15em,leftmargin=1em]
}{%
  \end{description}
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

\fancypagestyle{plain}{%  appendix and notes first page
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
  \fancyhead[LE,RO]{}
  % \fancyhead[RE]{{\color{boldcolor}\textsl{\leftmark}}}
  % \fancyhead[LO]{{\color{boldcolor}\textsl{\rightmark}}}
  \fancyfoot[C]{} % {\color{boldcolor}\textsl{--Page \thepage--}}}
}

\fancypagestyle{endmatter}{%  appendix and notes
  % \renewcommand{\headrulewidth}{0.4pt}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
  % \fancyhead[LE,RO]{{\color{boldcolor}\textsl{\thepage}}}
  % \fancyhead[RE]{{\color{boldcolor}\textsl{\leftmark}}}
  % \fancyhead[LO]{{\color{boldcolor}\textsl{\rightmark}}}
  \fancyhead{}
  \fancyfoot{}
  % \fancyhead[RE]{{\color{boldcolor}\textsl{Index}}}
  % \fancyhead[LO]{{\color{boldcolor}\textsl{Index}}}
}


\pagestyle{bookfront}
\pagenumbering{roman}


% ============================================================
% Behavior inside and outside the Extra sections
% This is the main complication; I want that inside an Extra things
% are numbered less formally, etc.
%   You can find this section by searching for "EXTRA SECTION TOGGLE"
\newtoggle{insideextrasection} % True if inside an extra section, false ow. 
% Notes
% 1) This is set to false in a chapter command, and true in an extra command;
%   search for the string "EXTRA TOGGLE RESET", 



%================================================================
% PARAGRAPHS
\setlength{\parskip}{0.2ex plus 0.05ex minus 0.05ex}


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

% For debugging I want the input line number in the answer file.
% For where this is used, see the exercise environment.
\ifnum\inputlineno=\m@ne
\let\showlineno\@empty
\else
\def\showlineno{Line \the\inputlineno}
\fi
\renewcommand{\Currentlabel}{\Roman{chapter}.\@currentlabel}


% ========= Chapters and sections =============
% How much space to put between numbering and margin 
\newlength{\margin@numberingspace} % Dist between numbering and margin
\setlength{\margin@numberingspace}{0.8em}
\setlength{\marginparsep}{\margin@numberingspace}

% Clear to an odd page with empty pages in between
\newcommand{\clearemptydoublepage}{% clear to right page
  \newpage{\pagestyle{empty}\thispagestyle{empty}% 
    \cleardoublepage}}
% Clear to an even-numbered page, with blank pages between
% https://tex.stackexchange.com/a/365249/121234
\newcommand*{\cleartoleftpage}{%
  \clearpage
  \thispagestyle{empty}\pagestyle{empty}
    \if@twoside
    \ifodd\c@page
      \hbox{}\thispagestyle{empty}\pagestyle{empty}\newpage
      \if@twocolumn
        \hbox{}\newpage
      \fi
    \fi
  \fi
}


%%%%%%%%%%%%%%%%%
% Parts 
\renewcommand{\part}[1]{\clearemptydoublepage\thispagestyle{bookemptypage}%
  \vspace*{\stretch{1}}%
  \refstepcounter{part}
  \begin{center}
    \normalfont\Large{\color{boldcolor}Part \thepart} \\[1.25ex]
    \LARGE #1
  \end{center}
  \vspace*{\stretch{1.5}}%
}
\usepackage{fmtcount}  % Display the part number as an English word "One"
\renewcommand{\thepart}{\Numberstring{part}}

%%%%%%%%%%%%%%%%%
% Chapters

% As with sections, put the numbering in the margin using a marginpar
% (actually a marginnote that has been hacked to always be on the left).
\newcommand{\chapterwrapper}{%
  \@ifstar{\jhchapter@star}{\jhchapter@nostar}}%

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
% This is Amazon KDP's Safe area (#3 in the picture)
\newlength{\heightamazon}
  \setlength{\heightamazon}{9in}
\newlength{\widthamazon}
  \setlength{\widthamazon}{7.375in}
\newcommand{\chapteropen}[3][\relax]{%
  \cleartoleftpage
  \thispagestyle{bookemptypage}%
  \vspace*{\stretch{1}}% vertically center on the page
  % {\noindent\hspace*{-\jh@eventotaloutermargin}% Move everything left by \evensi
  % {\noindent\hspace*{-0.8\jh@eventotaloutermargin}% Move everything left by \evensidemargin
  % The graphicx package will pick the smaller of the height and width
  {\centering\makebox[0em][c]{\includegraphics[height=1.2\textheight,
                   width=1.2\textwidth,
                   keepaspectratio]{#2}}\par}% center image on line
  \vspace*{\stretch{1}}% vertically center
  \clearpage
  \chapterwrapper{#3}\imagecredit{#1}%
  \Writetofile{\answerbodyfilename}{\protect\chapter{Chapter \Roman{chapter}: #3}}%
  \storeNumberstring{chapterasnumberstring}{chapter}% See answers description
}


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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extra
\usepackage{titlesec}

% If making paper copy, have "Chapter" and "Section" butt left into the
% margin by this amount
\newlength{\MakePaperChapterSectionNameLeftShift}
  \setlength{\MakePaperChapterSectionNameLeftShift}{-1.6em}

% Chapter
% Main part chapters
\newcounter{jhchapter}
  \newcommand{\thejhcounter}{\Roman{jhchapter}}
\titleclass{\jhchapter}{straight}[\part]
\ifbool{MakingPaperCopy}{%
  \titleformat{\jhchapter}[display]%
    {\normalfont\Large\bfseries}%  title format
    {}% label
    {0em}% sep
   {\makebox[0em][r]{\normalfont\scshape \begin{tabular}[b]{@{}r@{}}\Roman{chapter}\\[-0.15ex] \ \end{tabular}\hspace*{\margin@numberingspace}}\makebox[0em][l]{\normalfont\scshape \begin{tabular}[b]{@{}r@{}}Chapter\\[-0.15ex] \ \end{tabular}\hspace*{\margin@numberingspace}}}% before code
    %[] % after-code
  \titlespacing*{\jhchapter}
    {0pt}% left
    {4.85ex plus 1.5ex minus 0.3ex}% before sep
    {1.0ex plus 0.3ex minus 0.06ex}% after sep
    % [] % right sep
}{%  If not making paper copy
  \titleformat{\jhchapter}[display]%
    {\normalfont\Large\bfseries}%  title format
    {}% label
    {0em}% sep
    {\makebox[0em][r]{\normalfont\scshape \begin{tabular}[b]{@{}r@{}}Chapter\\[-0.15ex] \Roman{chapter}\end{tabular}\hspace*{\margin@numberingspace}}}% before code
    %[] % after-code
  \titlespacing*{\jhchapter}
    {0pt}% left
    {4.85ex plus 1.5ex minus 0.3ex}% before sep
    {1.0ex plus 0.3ex minus 0.06ex}% after sep
    % [] % right sep
}


% jhchapter for notes and biblio  
\newcounter{jhchapterstarred}
  \newcommand{\thejhcounterstarred}{\relax}
\titleclass{\jhchapterstarred}{straight}[\part]
\titleformat{\jhchapterstarred}[display]%
  {\normalfont\Large\bfseries}%  title format
  {}% label
  {0em}% sep
  {}% before code
  %[] % after-code
\titlespacing*{\jhchapterstarred}
  {0pt}% left
  {4.85ex plus 1.5ex minus 0.3ex}% before sep
  {1.0ex plus 0.3ex minus 0.06ex}% after sep
  % [] % right sep

% TOC
  \def\toclevel@jhchapter{0}
  \def\toclevel@jhchapterstarred{100}
  % l@jhchapter is defined elsewhere to make roman numeral
  % \def\l@jhchapter{\@dottedtocline{0}{0em}{1.5em}}
  % Don't want two TOC entries for Notes and Biblio
  % \def\l@jhchapterstarred{\@dottedtocline{0}{0em}{1.5em}}  Don't want 
  \newcommand{\l@jhchapterstarred}[2]{\relax}

% \let\jhaddcontentsline=\addcontentsline %
% \renewcommand{\chapter}[1]{%
\newcommand{\jhchapter@nostar}[1]{%
  \stepcounter{chapter}%
  \addcontentsline{toc}{chapter}{\protect\numberline{\Roman{chapter}\protect\hspace{\cftchapnumwidth} #1}}
  % \jhaddcontentsline{toc}{chapter}{\protect\numberline{\Roman{chapter}} #1}
  % \pdfbookmark[1]{Beginning of Document}{beg}
  \global\togglefalse{insideextrasection}% find this by searching for: EXTRA TOGGLE RESET
  \renewcommand{\thesection}{\arabic{section}}% set theorem numbering to be as outside Extra sections
  % \renewcommand{\thesubsection}{\arabic{subsection}}%
  \renewcommand{\thesubsection}{\relax}%
  \renewcommand{\thetheorem}{\arabic{section}.\arabic{theorem}} % Extra sections change this so change it back
  \global\def\exercisecounterstart{\Roman{chapter}.\arabic{section}}% put in the margin to count exercises env
  \renewcommand{\the@exercisenumber}{\arabic{section}.\arabic{@exercisenumber}}%
  % 
  \pagestyle{bookbody}%
  \thispagestyle{bookemptypage}%
  \jhchapter{#1}}
  
% Starred chapter
\newcommand{\jhchapter@star}[1]{%
  \stepcounter{chapter}%
  % \addcontentsline{toc}{chapter}{\protect\numberline{\protect\hspace{\cftchapnumwidth} #1}}
  \global\togglefalse{insideextrasection}% find this by searching for: EXTRA TOGGLE RESET
  \renewcommand{\thesection}{\arabic{section}}% set theorem numbering to be as outside Extra sections
  \renewcommand{\thesubsection}{\arabic{subsection}}%
  \renewcommand{\thetheorem}{\arabic{section}.\arabic{theorem}} % Extra sections change this so change it back
  \global\def\exercisecounterstart{\Roman{chapter}.\arabic{section}}% put in the margin to count exercises env
  \renewcommand{\the@exercisenumber}{\arabic{section}.\arabic{@exercisenumber}}%
  % 
  \pagestyle{bookbody}%
  \thispagestyle{bookemptypage}%
  \jhchapterstarred{#1}}
\renewcommand{\thechapter}{\Roman{chapter}}

% Section
\ifbool{MakingPaperCopy}{%
  \titleformat{\section}[hang]%
    {\normalfont\large\bfseries}%  title format
    {}% label
    {0em}% sep
    %{\makebox[0em][r]{\normalfont\scshape \begin{tabular}[b]{@{}r@{}}Section\\ \Roman{chapter}.\arabic{section}\end{tabular}\hspace*{\margin@numberingspace}}}% before code
    {\makebox[0em][r]{\normalfont\scshape \begin{tabular}[b]{@{}r@{}}\Roman{chapter}.\arabic{section}\\ \ \end{tabular}\hspace*{\margin@numberingspace}}\makebox[0em][l]{\normalfont\scshape \begin{tabular}[b]{@{}r@{}}Section\\ \ \end{tabular}\hspace*{\margin@numberingspace}}}% before code
    %[] % after-code
  \titlespacing*{\section}
    {0pt}% left
    {3.5ex plus 1.5ex minus 0.3ex}% before sep
    {1.8ex plus 0.3ex minus 0.05ex}% after sep
    % [] % right sep
}{%
  \titleformat{\section}[hang]%
    {\normalfont\large\bfseries}%  title format
    {}% label
    {0em}% sep
    {\makebox[0em][r]{\normalfont\scshape \begin{tabular}[b]{@{}r@{}}Section\\ \Roman{chapter}.\arabic{section}\end{tabular}\hspace*{\margin@numberingspace}}}% before code
    %[] % after-code
  \titlespacing*{\section}
    {0pt}% left
    {3.5ex plus 1.5ex minus 0.3ex}% before sep
    {1.8ex plus 0.3ex minus 0.05ex}% after sep
    % [] % right sep
}

% Subsection
\titleformat{\subsection}[runin]%
  {\normalfont\bfseries}%  title format
  {}% label
  {0em}% sep
  {}% before code
  %[] % after-code

\titlespacing*{\subsection}
  {0pt}% left
  {1.3ex plus 0.5ex minus 0.1ex}% before sep, vertical
  {0.6em plus 0.1em}% after sep, horiz
  % [] % right sep
  
% Extra
\titleclass{\extrasection}{straight}[\chapter]
\newcounter{extrasection}[chapter]
  \renewcommand{\theextrasection}{\Alph{extra}}
\ifbool{MakingPaperCopy}{%
  \titleformat{\extrasection}[hang]
    {\normalfont\bfseries}% title format
    {}% label
    {0em}% sep
    {\makebox[0em][r]{\normalfont\scshape \begin{tabular}[b]{@{}r@{}}\Roman{chapter}.\Alph{extra}\\ \ \end{tabular}\hspace*{\margin@numberingspace}}\makebox[0em][l]{\normalfont\scshape \begin{tabular}[b]{@{}r@{}}Extra\\ \ \end{tabular}\hspace*{\margin@numberingspace}}}% before code  
  \titlespacing*{\extrasection}%
    {0pt}% left margin
    {3.25ex plus 1ex minus 0.2ex}% before sep
    {0.6em plus 0.1em}% aftersep
}{%
  \titleformat{\extrasection}[hang]
    {\normalfont\bfseries}% title format
    {}% label
    {0em}% sep
    {\makebox[0em][r]{\normalfont\scshape \begin{tabular}[b]{@{}r@{}}Extra\\ \Roman{chapter}.\Alph{extra}\end{tabular}\hspace*{\margin@numberingspace}}}% before code  
  \titlespacing*{\extrasection}%
    {0pt}% left margin
    {3.25ex plus 1ex minus 0.2ex}% before sep
    {0.6em plus 0.1em}% aftersep
}

% \newcommand{\extrasectionautorefname}{extra}

\setcounter{tocdepth}{2}
  \def\toclevel@extrasection{1}  % Make pdf bookmarks come out at right level
  \def\l@extrasection{\@dottedtocline{1}{1.5em}{2.3em}}

\newcounter{extra}[chapter]
% Counter for naming the extra sections
% \newcounter{extrasectionbookmarknumber}
%   \setcounter{extrasectionbookmarknumber}{0}
\newcommand{\extra}[1]{%
  % Put the bookmark in at the right level
  % \pdfbookmark[2]{#1}{extrasection.\theextrasectionbookmarknumber}
  % \stepcounter{extrasectionbookmarknumber}
  \stepcounter{extra}
  \setcounter{theorem}{0}
  \setcounter{section}{\value{extra}}
  \renewcommand{\thesection}{\Alph{section}} % Set theorem numbering for inside Extra sections
  \setcounter{subsection}{0}
  \renewcommand{\thetheorem}{\Alph{section}.\arabic{theorem}} 
  \renewcommand{\exercisecounterstart}{\Roman{chapter}.\Alph{section}} % put in the margin to count exercises env
  \renewcommand{\the@exercisenumber}{\Alph{section}.\arabic{@exercisenumber}}
  \markright{Extra \thesection{}. #1}%
\extrasection{#1}}

\newcommand{\extramark}[1]{
  \markright{Extra\ \thesubsection.\ #1}}% for page headers

% Note that the cleveref names are lower down, after loading cleveref

% ............ appendix ..............
\renewcommand{\appendix}{%
  \part{Appendices}
  \addcontentsline{toc}{chapter}{Appendix}
  \pagestyle{endmatter}
  \setcounter{section}{0}
  \renewcommand{\thesection}{\Alph{section}}
  \ifbool{MakingPaperCopy}{%
    \titleformat{\section}[hang]
       {\normalfont\scshape}
       {\llap{\thesection\hspace*{\margin@numberingspace}}Appendix\hspace*{1em}}
       {0em}
       {\Large\bfseries}
    \titlespacing*{\section}
      {0pt}  % increase of left margin
      {3.5ex plus 1.5ex minus 0.3ex}% before sep
      {1.8ex plus 0.3ex minus 0.05ex}% after sep
  }{%
    \titleformat{\section}[hang]
       {\normalfont\scshape}
       {\makebox[0em][r]{Appendix \thesection\hspace*{1em}}}
       {0em}
       {\Large\bfseries}
    \titlespacing*{\section}
      {0pt}  % increase of left margin
      {3.5ex plus 1.5ex minus 0.3ex}% before sep
      {1.8ex plus 0.3ex minus 0.05ex}% after sep
  }
 \def\exercisecounterstart{\relax}
}



% ============= Index ================
% Copied defn from book.cls.  Modified:
%  change size of "Index" to match the size of a chapter head
%  change spacing of it to match spacing above and below chapter head
% (except enlarged the space below from 1ex to 2ex)
\renewenvironment{theindex}
               {\if@twocolumn
                  \@restonecolfalse
                \else
                  \@restonecoltrue
                \fi
                \vspace*{4.85ex plus 1.5ex minus 0.3ex}
                \twocolumn[\mbox{\rule[-2ex]{0pt}{1pt}\normalfont\Large\bfseries\indexname}]%
                % \vspace*{1.0ex plus 0.3ex minus 0.06ex}
                \@mkboth{\MakeUppercase\indexname}%
                        {\MakeUppercase\indexname}%
                \thispagestyle{plain}\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \columnseprule \z@
                \columnsep 35\p@
                \let\item\@idxitem}
               {\if@restonecol\onecolumn\else\clearpage\fi}




%======================== hyperref ===========

% Depreciated?  Doc on CTAN says in next LaTeX release
\usepackage{xr-hyper}  % for cleveref; https://tex.stackexchange.com/a/244272/121234
% \usepackage[draft]{hyperref}  % remove the draft option at the end.
\usepackage{hyperref}  % remove the draft option at the end.
  % It is there to prevent errors like
  % "\pdfendlink ended up in different nesting level than \pdfstartlink";
  % see https://tex.stackexchange.com/a/154184/121234
\hypersetup{
%  warning says it is already set:    bookmarks=true,         % show bookmarks bar?
    unicode=false,          % non-Latin characters in Acrobat’s bookmarks
    pdftoolbar=true,        % show Acrobat’s toolbar?
    pdfmenubar=true,        % show Acrobat’s menu?
    pdffitwindow=false,     % window fit to page when opened
    pdfstartview={FitH},    % fits the width of the page to the window
    pdfpagemode=None,       % None, or UseOutlines, or UseThumbs, or FullScreen
    pdftitle={Computing},    % title
    pdfauthor={Jim Hefferon, University of Vermont},     % author
    pdfsubject={Theory of Computation},   % subject of the document
    pdfcreator={LaTeX, Asymptote},   % creator of the document; see https://tex.stackexchange.com/a/590921/339
    % pdfproducer={pdflatex}, % producer of the document; default is current pdflatex version
    pdfdisplaydoctitle=true, % show document title in window title
    pdfkeywords={theory of computation} {computation} {turing machines}, % list of keywords
    pdfnewwindow=true,      % links in new window
    colorlinks=true,       % false: boxed links; true: colored links
    linkcolor=black,          % color of internal links (change box color with linkbordercolor)
    citecolor=black,        % color of links to bibliography
    filecolor=black,      % color of file links
    urlcolor=black,           % color of external links
    plainpages=false   % prevent "destination with the same identifier" error
}
% \newcommand\href[2]{\relax}
% \newcommand\hyperref[2][\relax]{#2}

% These prevent annoying log messages like "
%  Package hyperref Info: bookmark level for unknown animatefigure defaults to 0 on input line 7949.
\providecommand*{\toclevel@animatefigure}{0}%

% 2022-Jun-05
\usepackage{breakurl}



% ======== clever references ===============
% This must come before cleveref
\usepackage{framed}
% \setlength{\fboxsep}{0ex}
% \usepackage[thmmarks,amsmath,framed]{ntheorem} % see https://tex.stackexchange.com/a/50602/121234
% \usepackage{amsthm}

% Must come before cleveref:
\usepackage{thmtools}


\usepackage{cleveref} % after hyperref
\def\thmt@refnamewithcomma #1#2#3,#4,#5\@nil{%
  \@xa\def\csname\thmt@envname #1utorefname\endcsname{#3}%
  \ifcsname #2refname\endcsname
    \csname #2refname\expandafter\endcsname\expandafter{\thmt@envname}{#3}{#4}%
  \fi
}




% ========== Exercises =======================

% Suppress page break between "Exercises" and top of list
%  see https://tex.stackexchange.com/a/210847/121234
\newlength{\jh@listtopsep}
  % \setlength{\jh@listtopsep}{2.3ex plus 0.2ex}
  \setlength{\jh@listtopsep}{0.8ex plus 0.2ex minus 0.1ex}
\newcommand{\nolisttopbreak}{\vspace{\jh@listtopsep}\nobreak\@afterheading} 

% Get the width of a single character; use it for the left margin
\newlength{\jh@widthofchar}
\newsavebox{\jh@widthofcharbox}
\savebox{\jh@widthofcharbox}{\scshape 0}
\settowidth{\jh@widthofchar}{\hbox{\scshape 0}}  

% ========= Define the exercises environment =======

% Allow exercises to be recommended
% In the exercise label it checks a toggle and prints the mark if the
% toggle is true.
\newtoggle{@recommended}
\newcommand{\recommended}{\toggletrue{@recommended}}
\newcommand{\recommendationmark}{\checkmark}
\newlength{\recommendation@length}  % Put the mark this far into margin
  \setlength{\recommendation@length}{1.25em}

% Mark an answer as verified by putting \verified in the source,
% before \begin{exercise}
% I may just go with marking the answer as verified after \begin{answer};
% see answer.cls.
\newtoggle{@showverified}  % Set to true to put something on the book.pdf page
\toggletrue{@showverified}  % comment out one of these two
% \togglefalse{@showverified} %
% This handles the logic; don't set by hand
\newtoggle{@verified}
\togglefalse{@verified}
\newcommand{\verified}{\toggletrue{@verified}}
\newcommand{\verifiedmark}{{\color{green}V}}
\newlength{\verified@length}  % Put the mark this far into margin
  \setlength{\verified@length}{2.25em}

% \newcommand{\verified}{\relax}

% Count the total number of exercises
\newcounter{numberofexercises}
  \setcounter{numberofexercises}{0}

% Exercises are a list
\newcounter{@exercisenumber}[section]
\renewcommand{\the@exercisenumber}{\Alph{section}.\arabic{@exercisenumber}}
\newcommand{\exercisecounterstart}{\Roman{chapter}.\arabic{section}}% put in the margin to count exercises env
\newcommand{\@exercisecounterlabel}{%
  \iftoggle{@recommended}{% put recommended mark in margin
    \llap{\makebox[\recommendation@length][l]{\recommendationmark}}%
  }{%
  }\global\togglefalse{@recommended}%
  \iftoggle{@showverified}{%
    \iftoggle{@verified}{% put verified mark in margin
        \llap{\makebox[\verified@length][l]{\verifiedmark}}%
      }{%
      }
    \global\togglefalse{@verified}%
  }{}
  \addtocounter{numberofexercises}{1}
  % \typeout{!!! Exercise target is exercise.\thechapter.\the@exercisenumber}
  \hyperref{answers.pdf}{exercise}{\thechapter.\the@exercisenumber}{\the@exercisenumber}\hypertarget{exercise.\thechapter.\the@exercisenumber}{}\hspace*{0.6em plus 0.1em minus 0.05em}}
  %\normalfont\scshape\the@exercisenumber\hspace*{0.6em plus 0.1em minus 0.05em}}
\AtEndDocument{\typeout{Number of exercises: \thenumberofexercises.}}

% exercises environment  Contents are
%      \begin{exercise} .. \begin{answer}..\end{answer}\end{exercise}
% The optional argument is for notes.
\newenvironment{exercises}[1][]{%
  \vspace{2.5ex plus 0.8ex minus 0.2ex}%
% \vspace{\jh@listtopsep}\llap{\normalfont\scshape \exercisecounterstart\hspace*{\margin@numberingspace}}{\normalfont\bfseries Exercises}\par\nobreak\@afterheading
  \par\noindent\llap{\normalfont\scshape \exercisecounterstart\hspace*{\margin@numberingspace}}{\normalfont\bfseries Exercises}%
  \ifstrempty{#1}{}{\vspace{\jh@listtopsep}\par\noindent\textit{#1}}%
  % \nolisttopbreak % causes a \nobreak to appear after the first item
  \begin{list}{\@exercisecounterlabel}%
     {\usecounter{@exercisenumber}
      \setcounter{@exercisenumber}{\value{theorem}}
      \renewcommand{\makelabel}[1]{{\normalfont\scshape ##1}}% 
      \setlength{\leftmargin}{\jh@widthofchar}
      \setlength{\labelwidth}{\leftmargin}
      \setlength{\labelsep}{0em}
      \setlength{\itemindent}{0em}
      \setlength{\listparindent}{0.8\parindent}
      \setlength{\topsep}{\jh@listtopsep}
      \setlength{\parsep}{0ex}
      \setlength{\itemsep}{0.5ex plus 0.15ex minus 0.05ex}
      \setlength{\rightmargin}{0em}
      % Encourage a page break betweeen items; LaTeX book.cls has
      % \@itempenalty     -\@lowpenalty
      \@itempenalty-\@medpenalty %
      % Also discourage clubs and widows
      \clubpenalty600 % % discourage breaking after first line
      \widowpenalty600 % discourage breaking before last line
    }
}{%
  \end{list}
}

\newenvironment{exercise}{%
  \let\item\fakeitem %  Make only the following \item be a \fakeitem so trivlists such as center don't fail
  \item %
  \let\item\realitem %
  \Writetofile{\answerbodyfilename}{\@percentchar}%  Give line number of source, for editing
  \Writetofile{\answerbodyfilename}{\@percentchar\space\showlineno\space is the exercise source}%
}{%
}

% Insert instructions that apply to a number of consecutive exercises into
% the middle of an exercises environment
\newcommand{\exerciseinstructions}[1]{%
  % ? not enough vertical space
  % \vspace{0.5ex plus 0.15ex minus 0.05ex}% \itemsep + \parsep
  \medskip %
  \parbox{\textwidth}{\it #1}}


% New exercises code
% exercises environment  Contents are
%      \begin{exercise} .. \begin{answer}..\end{answer}\end{exercise}
% Each \begin{exercise} .. \end{exercise} calls \item and writes the line number
% to the answer file to make it easier to find bugs in answers 
%
% That \item comes from a \begin{exerciselist} .. \end{exerciselist}.  Each
% of those is a modified enumerate environment, modified under enumitem.
% A key aspect there is that the top of the exerciselist list issues a 
% penalty so that the prior line (which says "Exercises") is not on a 
% separate page.
%
% That prior line comes from the \begin{exercises} .. \end{exercises} 
% environment.

\newlist{exerciselist}{enumerate}{1}
\setlist[exerciselist]{label=\thesection.\arabic*,
                       beginpenalty=10000, % Keep "Exercises" line with this list
                       midpenalty=-51,  % Good place for a page break here
                       endpenalty=-51,  % Also good place for a page break
                       topsep=\jh@listtopsep,
                       parsep=0ex,
                       itemsep=0.6ex plus 0.25ex minus 0.05ex,
                       leftmargin=0pt,
                       labelwidth=0pt,
                       labelsep=0ex, % \fakeitem includes spacing
                       itemindent=0em,
                       font=\normalfont\scshape,
                       before=\setcounter{exerciselisti}{\value{theorem}}\let\realitem\item\let\item\fakeitem,
                       after=\let\item\realitem,
}  % counter is exerciselisti


\newcommand\fakeitem[1][\relax]{% argument defaults to \relax
   \refstepcounter{exerciselisti}%  increment label counter
   \realitem[\iftoggle{@recommended}{% put recommended mark in margin
       \llap{\makebox[\recommendation@length][l]{\recommendationmark}}%
     }{%
     }]\global\togglefalse{@recommended}%
     \addtocounter{numberofexercises}{1}% Count for a whole-book number 
     \hyperref{answers.pdf}{exercise}{\thechapter.\theexerciselisti}{\theexerciselisti}\hypertarget{exercise.\thechapter.\theexerciselisti}{}\hspace*{0.6em plus 0.1em minus 0.05em}}

\renewenvironment{exercises}[1][]{%      
  \clubpenalty6000% discourage breaking after first line of a para
  \widowpenalty6000% discourage breaking before last line of a para
  \vspace{2.5ex plus 0.8ex minus 0.2ex}% space between text and "Exercises"  
  \par\noindent\llap{\normalfont\scshape \exercisecounterstart\hspace*{\margin@numberingspace}}{\normalfont\bfseries Exercises}%
  \ifstrempty{#1}{}{\vspace{\jh@listtopsep}\par\noindent\textit{#1}}%
  \begin{exerciselist}
}{%
  \end{exerciselist}
}


\newlist{exparts}{enumerate}{2}
\setlist[exparts]{beginpenalty=10000, % Keep "Exercises" line with this list
  midpenalty=-51,  % Good place for a page break here
  endpenalty=-51,  % Also good place for a page break
  topsep=0ex,
  itemsep=0ex,
  parsep=0ex,
  leftmargin=2em,labelwidth=0.5em,labelsep=.16667em,
  before=\setcounter{expartsii}{0}\let\item\realitem,
  label={\scshape{\small (}\alph*{\small )}\nobreak\hspace{.16667em plus .08333em}}
}  % 

\newlist{exparts*}{enumerate*}{2}
\setlist[exparts*]{label={\scshape(\alph*)\nobreak\hspace{.16667em plus .08333em}},
  itemsep=0em,labelsep=0em,labelindent=0em,itemindent=0em,
  itemjoin={\hspace{0.6em plus .1em minus .1em}\linebreak[2]},
  before=\setcounter{expartsii}{0}\let\item\realitem,
  beginpenalty=10000, % Keep "Exercises" line with this list
  midpenalty=-51,  % Good place for a page break here
  endpenalty=-51,  % Also good place for a page break
}  % 



% Exparts
% Some exercises have multiple parts: (1) .. (2) ..
% This can be on separate lines.
% \newenvironment{exparts}{%
%   \begin{enumerate}[topsep=0ex,
%                     itemsep=0ex, parsep=0ex,
%                     leftmargin=2em,labelwidth=0.5em,labelsep=.16667em,
%                     label={\scshape{\small (}\alph*{\small )}\nobreak\hspace{.16667em plus .08333em}}] 
% }{%
%   \end{enumerate}
% }

% % .. or inline
% \newenvironment{exparts*}{%
%   \begin{enumerate*}[label={\scshape(\alph*)\nobreak\hspace{.16667em plus .08333em}},
%                      itemsep=0em,labelsep=0em,labelindent=0em,itemindent=0em,
%                      itemjoin={\hspace{0.6em plus .1em minus .1em}\linebreak[2]},
%                      % before={\hspace{0.6em plus .1em minus .1em\linebreak[2]}}
%                      ]
% }{%
%   \end{enumerate*}
% }

\crefname{@exercisenumber}{Exercise}{Exercises}
\Crefname{@exercisenumber}{Exercise}{Exercises}
\crefname{exerciselisti}{Exercise}{Exercises}
\Crefname{exerciselisti}{Exercise}{Exercises}

% For naming a part of an exercise, as in \item \expartsname{Commutativity}
\newcommand{\expartsname}[1]{\textsc{(#1)}} 

% For a hint, or caution, for exercises
\newcommand{\hint}{\textit{Hint:}} % no space because want to use a tie: ~
\newcommand{\caution}{\textit{Caution:}} % no space because want to use a tie: ~





% ============ Theorems ========================
% Theorems
% These need to be numbered all as one, and the numbering in the margin

% The cleveref package requires that theorems be made with either amsthm
% or ntheorem.  \newheorem's must come after cleveref is loaded. 

\newlength{\lrmarginaroundshadedtheorems}
\newlength{\tbmarginaroundshadedtheorems}
\newlength{\resttbaroundshadedtheorems}
\setlength{\lrmarginaroundshadedtheorems}{2pt}
\setlength{\tbmarginaroundshadedtheorems}{2pt plus 0.5pt}
% \setlength{\tbmarginaroundshadedtheorems}{\lrmarginaroundshadedtheorems}
\setlength{\resttbaroundshadedtheorems}{\topsep-\tbmarginaroundshadedtheorems}
\newtheoremstyle{whitestyle}
{2pt plus 0.5pt}               %space above
{2pt plus 0.5pt}               %space below
{}                      %bodyfont
{0pt}                   %indent
{\scshape}              %headfont
{}                      %punctuation
{0.4em plus 0.2em}                 %space after head
{\llap{\thmnumber{#2}\hspace*{\margin@numberingspace}}\thmname{#1} \thmnote{(#3)}}       %theoremheadspec

\newtheoremstyle{coloredstyle}
{\tbmarginaroundshadedtheorems}               %space above
{\tbmarginaroundshadedtheorems}               %space below
{}                      %bodyfont
{0pt}                   %indent
{\scshape}              %headfont
{}                      %punctuation
{0.4em plus 0.2em}                 %space after head
{\llap{\thmnumber{#2}\hspace*{\margin@numberingspace}}\thmname{#1} \thmnote{(#3)}}       %theoremheadspec
 

% \usepackage{mdframed}
% \mdfsetup{skipabove=1.5pt plus 0.2pt minus 0.1pt,
%           skipbelow=1.5pt plus 0.2pt minus 0.1pt}  % small whitespace between theorems

\usepackage{tcolorbox}
\tcbset{beforeafter skip=2pt plus 0.2pt minus 0.1pt}


%================================================================
% FOOTNOTES
% Footnotes: Use footnote symbols (not numbers) on a per-page basis.
% \renewcommand{\thefootnote}{\fnsymbol{footnote}}
\RequirePackage[perpage,symbol*,para,multiple]{footmisc}
\setlength{\footnotemargin}{-1em}
\DefineFNsymbolsTM*{hefferon}{%
  \textdagger    \dagger
  \textdaggerdbl \ddagger
  \#  \#%
  \textsection   \mathsection
  a a
  b b
  c c
  d d
  e e 
  f f 
  g g
  h h
  i i
  j j
  k k
  1 2 3 4 5 6 7 8 9 0 a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z%
  1 2 3 4 5 6 7 8 9 0 a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z%
  1 2 3 4 5 6 7 8 9 0 a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z%
  1 2 3 4 5 6 7 8 9 0 a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z%
}%  lots of fn symbols, to avoid getting compilation error that are out of foonotes, because LaTeX doesn't know they are per-page until the second run. 
\setfnsymbol{hefferon}
\newlength{\footmarktotextglue}
\global\footmarktotextglue=.1em plus .05em minus .02em %
\global\footglue=0.65em plus.2em minus.1em % space between footnotes
\long\def\@makefntext#1{\leavevmode % hack footmisc line 391 to change space from footnote mark to footnote
\smash{\@makefnmark}\nobreak
\hskip\footmarktotextglue\relax#1% was .5em
}
\renewcommand\thempfootnote{\fnsymbol{mpfootnote}}


%================================================================
% THEOREM ENVIRONMENTS

\theoremstyle{coloredstyle}
\newtheorem{theorem}{Theorem}[section]
\renewcommand{\thetheorem}{\arabic{section}.\arabic{theorem}} % don't include the chapter
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{definition}[theorem]{Definition}
\newtheorem{churchsthesis}[theorem]{Church's Thesis}
\newtheorem{problem}[theorem]{Problem}

\theoremstyle{whitestyle}
\newtheorem{example}[theorem]{Example}
\newtheorem{remark}[theorem]{Remark}
\newtheorem{remarks}[theorem]{Remarks}
\newtheorem{discussion}[theorem]{Discussion}

\AtBeginEnvironment{theorem}{%
  \setcounter{mpfootnote}{\value{footnote}}}
\AtBeginEnvironment{lemma}{%
  \setcounter{mpfootnote}{\value{footnote}}}
\AtBeginEnvironment{corollary}{%
  \setcounter{mpfootnote}{\value{footnote}}}
\AtBeginEnvironment{definition}{%
  \setcounter{mpfootnote}{\value{footnote}}}
\AtBeginEnvironment{churchsthesis}{%
  \setcounter{mpfootnote}{\value{footnote}}}
\AtBeginEnvironment{problem}{%
  \setcounter{mpfootnote}{\value{footnote}}}
\AtBeginEnvironment{example}{%
  \setcounter{mpfootnote}{\value{footnote}}}
\AtBeginEnvironment{remark}{%
  \setcounter{mpfootnote}{\value{footnote}}}

\tcolorboxenvironment{theorem}{colback=backgroundcolor, 
  colframe=backgroundcolor,
  boxrule=0pt,
  arc=0pt,
  width=\textwidth,
  left=0pt,
  right=0pt,
  boxsep=2pt,
  bottom=0pt,
  top=0pt,
  beforeafter skip=3pt plus 0.5pt minus 0.1pt,
}
\tcolorboxenvironment{lemma}{colback=backgroundcolor,colframe=backgroundcolor,
  boxrule=0pt,arc=0pt,
  width=\textwidth,
  left=0pt,right=0pt,boxsep=2pt,bottom=0pt,top=0pt,
  beforeafter skip=3pt plus 0.5pt minus 0.1pt,
}
\tcolorboxenvironment{corollary}{colback=backgroundcolor,colframe=backgroundcolor,
  boxrule=0pt,arc=0pt,
  width=\textwidth,
  left=0pt,right=0pt,boxsep=2pt,bottom=0pt,top=0pt,
  beforeafter skip=3pt plus 0.5pt minus 0.1pt,
}
\tcolorboxenvironment{definition}{colback=backgroundcolor,colframe=backgroundcolor,
  boxrule=0pt,arc=0pt,
  width=\textwidth,
  left=0pt,right=0pt,boxsep=2pt,bottom=0pt,top=0pt,
  beforeafter skip=3pt plus 0.5pt minus 0.1pt,
}
\tcolorboxenvironment{churchsthesis}{colback=backgroundcolor,colframe=backgroundcolor,
  boxrule=0pt,arc=0pt,
  width=\textwidth,
  left=0pt,right=0pt,boxsep=2pt,bottom=0pt,top=0pt,
  beforeafter skip=3pt plus 0.5pt minus 0.1pt,
}
\tcolorboxenvironment{problem}{colback=backgroundcolor,colframe=backgroundcolor,
  boxrule=0pt,arc=0pt,
  width=\textwidth,
  left=0pt,right=0pt,boxsep=2pt,bottom=0pt,top=0pt,
  beforeafter skip=3pt plus 0.5pt minus 0.1pt,
}


% Proofs
% Forget amsthm's proof environment
\let\proof\relax % 
\let\endproof\relax %
% Halmos symbol
\renewcommand\qedsymbol{{\setlength{\fboxsep}{0pt}\setlength{\fboxrule}{0.7pt}%
  \fcolorbox{boldcolor}{white}{\color{white}\rule{4pt}{8.5pt}}}}
%  comes before cleveref: \usepackage{thmtools}
\declaretheoremstyle[%
  spaceabove=0.5\topsep,%
  spacebelow=0.5\topsep,%
  headfont=\normalfont\itshape,%
  headpunct={}, %
  postheadspace=0.6em,%
  qed=\qedsymbol%
]{proofstyle} 
\declaretheorem[name={Proof},
  style=proofstyle,
  unnumbered,
  ]{proof}



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
\crefname{tablefigure}{Table}{Table}
\Crefname{tablefigure}{Table}{Table}

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
% thmdescription
% An description list inside of a theorem, or lemma, or definition
\newcommand{\thmdescriptionlabel}[1]{%
    \hspace\labelsep \textsc{#1}%
  }
\newenvironment{thmdescription}{%
  \let\descriptionlabel=\thmdescriptionlabel
  \begin{description}[
                    align=left, 
                    ref={{}},
    topsep={0.25ex plus 0.05ex minus 0.025ex},
    leftmargin=0.8em,
    rightmargin=0em,
    labelwidth=0em,
    labelsep=0.5em plus 0.1em minus 0.05em,
    itemindent=-0.2em,
    parsep={0ex plus 0.1ex},
    listparindent=0.8\parindent,
    itemsep={0.4ex plus .1ex minus 0.1ex}
    ]
}{%
  \end{description}
}

% ========== Bibliography =============
% biblatex 
% \AtEndPreamble{\let\murray@saved@addtocontents\addtocontents} % see https://tex.stackexchange.com/a/513586/339
\usepackage[backend=biber,style=authoryear,sorting=nyt,firstinits=true]{biblatex}
% \AtEndPreamble{\let\addtocontents\murray@saved@addtocontents} % see https://tex.stackexchange.com/a/513586/339
  \renewcommand*{\bibfont}{\raggedright\small}  % Use \small font for the body
\addbibresource{computing.bib}
\renewcommand{\bibsetup}{\thispagestyle{endmatter}\pagestyle{endmatter}}

% 2022-Jun-05 From xurl docs, to minimize bad lines
\setcounter{biburllcpenalty}{100}
\setcounter{biburlucpenalty}{200}
\setcounter{biburlnumpenalty}{100}

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
   
\newlength{\jhendnotesoutdent} \setlength{\jhendnotesoutdent}{1.5em}
% \newcommand{\citetext}[2]{#1%
%   \endnote{\protect\hspace*{-\jh@endnotesoutdent}\textit{#1}\protect\hspace{.618em} #2}}
\newcommand{\citetext}[2]{#1%
  \writetoentfile{#1}{#2}}
\newcommand{\writetoentfile}[2]{%
  \endnote{\protect\hspace*{-\jhendnotesoutdent}\textit{#1}\protect\hspace{.618em} #2}}
\renewcommand{\makeenmark}{\relax} % leave no mark
\newcommand{\citeadd}[1]{\addtoendnotes{#1}}

\renewcommand{\notesname}{Endnotes}
% \renewcommand{\notesname}{\relax}

\usepackage{hanging} % make cited text be in hanging indented paragraphs
\def\enoteformat{\rightskip 4pt \leftskip 1.4em \parindent=0em% \hangpara{2em}{1}%
  \leavevmode\llap{\makeenmark}\ }
% \usepackage{needspace}   % prevent a page break between a chapter announcement and the citations on that chapter

% How headings for chapters, Preface, etc. are formatted on Citations page
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
    \fi%
    \def\@doanenote##1##2>{\def\@theenmark{##1}\par\begingroup
        \@ResetGT
        \edef\@currentlabel{\csname p@endnote\endcsname\@theenmark}%
        \enoteformat}%
    \def\@endanenote{\par\endgroup}%
    \enoteheading%
    \enotesize\small\thispagestyle{plain}%
    \jhendnoteshook%
    \input{\jobname.ent}%
  \endgroup}
% \def\enoteheading{\jhchapter*{\notesname
%   \@mkboth{\notesname}{\notesname}}%
%   \mbox{}\par\vskip-\baselineskip}
\def\enoteheading{\vspace*{4.85ex plus 1.5ex minus 0.3ex}\par\noindent\mbox{\normalfont\Large\bfseries\notesname}\vspace*{1.0ex plus 0.3ex minus 0.06ex}\@mkboth{\notesname}{\notesname}\par\noindent}%


  \newcommand{\jhendnoteshook}{%
  These are citations, sources, or discussions that
  supplement the text body.
  Each refers to a word or phrase from that text body, in italics, and 
  then the note is in plain text.
  Many of the entries include links to more detail.
  % Note that some of these are from general discussions and so are
  % more informal than statements that might appear in a paper.
  }

\newcommand{\printnotes}{%
  % Table of Contents 
  \addcontentsline{toc}{chapter}{Notes}  
  % \addtocontents{toc}{\protect\setlength{\protect\cftchapnumwidth}{0em}}
  \newpage
  \begingroup
  % \newgeometry{% papersize={7.5in,9.25in},  not allowed in newgeometry
  %               % textwidth=345pt, % textheight=550pt,  % LaTeX defaults
  %               textwidth=5.25in,
  %               inner=1.1in, top=1in, bottom=1in, %
  %               headsep=12pt,
  %               bindingoffset=0.6in,
  %               left=\jhendnotesoutdent, % change the left margin
  %               includeheadfoot}
  \setlength{\headwidth}{\textwidth}
  \parindent 0pt
  \parskip=1ex plus 0.2ex minus 0.1ex %
  \def\enotesize{\normalsize}
  % \hangparas{-2em}{-1}
  \renewcommand{\sectiontitlecontents}[1]{\relax} % Cause the "Section One.II" not to printed.
  \vspace*{0.25ex plus 0.02ex}
  \pagestyle{endmatter}\thispagestyle{bookemptypage}%
  \theendnotes
  \restoregeometry  % Matches the \newgeometry after the \begingroup
  \endgroup
  }


% ............ Credits ..........

% Name of file holding credits
\newcommand{\creditsfilename}{credits}

\Opensolutionfile{\creditsfilename}
\Newassociation{credit}{creditoutput}{\creditsfilename}
% Needs to happen before this: \AtEndDocument{\Closesolutionfile{\creditsfilename}}

% Write section title
\Writetofile{\creditsfilename}{\protect\noindent\protect\mbox{\protect\rule[-2ex]{0pt}{1pt}\protect\normalfont\protect\Large\protect\bfseries Credits}}
\Writetofile{\creditsfilename}{ } % blank line

\renewenvironment{creditoutput}[1]{%
  \par\noindent\textsc{#1}}{ }

% Print out the credits
% 2022-Jun-05
% Use a wide page and empty headers and footers.
\newcommand{\outputcredits}[1]{
  \begingroup
  % \newgeometry{% papersize={7.5in,9.25in},  not allowed in newgeometry
  %               % textwidth=345pt, % textheight=550pt,  % LaTeX defaults
  %               textwidth=6in,
  %               inner=.8in, top=1in, bottom=1in, %
  %               headsep=12pt,
  %               bindingoffset=0.4in,
  %               left=\jhendnotesoutdent, % change the left margin
  %               includeheadfoot}
  \setlength{\headwidth}{\textwidth}
  \parindent 0pt
  \parskip=0.25ex plus 0.1ex minus 0.05ex %
  % \def\enotesize{\normalsize}
  % \renewcommand{\sectiontitlecontents}[1]{\relax} % Cause the "Section One.II" not to printed.
  \vspace*{0.25ex plus 0.02ex}
  \pagestyle{endmatter}\thispagestyle{bookemptypage}%
  % \cleartoleftpage
  {\small\input{#1}}
  % \restoregeometry  % Matches the \newgeometry after the \begingroup
  \endgroup
}


% Write the title of the chapter to the end notes and to the credits area.
%  #1  Title of chapter, e.g., Background
% Causes stack overflow, but putting the same commands in each time does
% not.  Dunno.
\newcommand{\chaptertitletoendfiles}[1]{%
  \addtoendnotes{\vspace{3ex}\par\noindent\textbf{#1}}
  \Writetofile{\creditsfilename}{\protect\vspace{3ex}\protect\par\protect\noindent\protect\textbf{#1}\protect\vspace{1ex}}
}


% ==========================================================
% TABLE OF CONTENTS
\usepackage{tocloft}
\tocloftpagestyle{empty}
\setlength{\cftchapindent}{0em}
% \setlength{\cftchapnumwidth}{1.25em}  % see also \printnotes
\setlength{\cftchapnumwidth}{0.5em}  % see also \printnotes
\setlength{\cftsecindent}{1em}
\setlength{\cftsecnumwidth}{1.25em}
\setlength{\cftsubsecindent}{2.5em}
\setlength{\cftsubsecnumwidth}{1em}

\setlength{\cftbeforetoctitleskip}{2ex plus 0.05ex}
\setlength{\cftaftertoctitleskip}{2ex plus 0.05ex minus 0.01ex}
\renewcommand{\cfttoctitlefont}{\Large\bfseries}

% from tocloft.sty; hack to make it print roman chapter number
% I can't figure out how to have jhchapter work, so I am putting a
% \addcontentsline in the \chapter defn
\newcommand{\l@jhchapter}[2]{\relax}%
\let\l@extrasection\l@section%


%============= listings =============================
% \definecolor{listingsbackgroundcolor}{RGB}{244,245,213}
\colorlet{listingsbackgroundcolor}{lightcolor}
\usepackage{listings}
% from: http://en.wikibooks.org/wiki/LaTeX/Packages/Listings
\lstset{ %
  % language=Octave,                % the language of the code
  basicstyle=\scriptsize\ttfamily,       % the size of the fonts that are used for the code
  columns=fixed, basewidth=0.55em,  % 'fullflexible' makes code copy-and-pasteable
  keepspaces=true,  % don't omit spaces inside a line
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

\lstdefinestyle{grammar}{
  basicstyle=\scriptsize\ttfamily,       % the size of the fonts that are used for the code
  columns=fullflexible,  % make code copy-and-pasteable
  backgroundcolor=\color{white},  % choose the background color. You must add \usepackage{color}
  showspaces=false,               % show spaces adding particular underscores
  showstringspaces=false,         % underline spaces within strings
  showtabs=false,                 % show tabs within strings adding particular underscores
  tabsize=8,                      % sets default tabsize to 8 spaces (emacs scheme buffer formatting wants that)
  captionpos=b,                   % sets the caption-position to bottom
  mathescape=true,
  % literate=
  %   {=}{$\leftarrow{}$}{1}
  %   {==}{::=}{3},
}


% Don't want \lstinline!..! because it comes out too small.
\usepackage{relsize}
% \newcommand\codeinline{\lstinline[basicstyle=\smaller\ttfamily]}
\newcommand\codeinline{\lstinline[basicstyle=\ttfamily]}
\newcommand\pathname{\lstinline[basicstyle=\small\ttfamily]}




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

% fig  Figure goes here
% [#1] label
% #2 caption
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

% Cleveref name for extra sections
\crefname{extrasection}{Extra}{Extra}
\Crefname{extrasection}{Extra}{Extra}


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
% [#1] l or r  which margin; r is default
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

\usepackage{microtype}

% Blank line with optional label
%   \fillinblankLabelled[4em]{(a)}
% produces a blank line that is 4em long, with (a) halfway along. 
\newcommand{\fillinblankLabelled}[2][3.5em]{{% \setlength{\fboxsep}{0pt}%
  \underline{\hbox{}\rule[-1pt]{0pt}{9pt}\makebox[#1][c]{{\small #2}}}}}
% Just a blank line
\newcommand{\fillinblank}[1][2em]{\fillinblankLabelled[#1]{}}

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
            \setlength{\topsep}{0.65ex}%
            \setlength{\parsep}{\parskip}%
            \setlength{\itemsep}{-\parsep}%
            \setlength{\labelwidth}{0em}%
            \setlength{\listparindent}{0.7\parindent}%
            % \setlength{\labelsep}{4in}%
            \setlength{\itemindent}{\listparindent}%
            \setlength{\partopsep}{0ex}%
            \setlength{\leftmargin}{1.2\parindent}%
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




% ================ Display environment =========
% Like "center" except if fleqn is in effect, then it has a left margin
\newenvironment{display}{%
  \if@fleqn %
    \list{\relax}{%
      \setlength{\leftmargin}{\mathindent}
      \setlength{\itemindent}{0em}
      \setlength{\labelwidth}{0em}
      \setlength{\labelsep}{0em}
      \setlength{\rightmargin}{0em}
      \setlength{\listparindent}{0em}
      \setlength{\parsep}{\parskip}
      \setlength{\partopsep}{0ex}
      \setlength{\itemsep}{0ex}
      } 
    % \trivlist  \item \relax \hspace*{\mathindent}
  \else 
    \list{\relax}{%
      \setlength{\leftmargin}{0em}
      \setlength{\itemindent}{0em}
      \setlength{\labelwidth}{0em}
      \setlength{\labelsep}{0em}
      \setlength{\rightmargin}{0em}
      \setlength{\listparindent}{0em}
      \setlength{\parsep}{\parskip}
      \setlength{\partopsep}{0ex}
      \setlength{\itemsep}{0ex}
      } \centering
    % \trivlist  \centering \item \relax
  \fi
  \item \relax
}{%
  \endlist %
}





% ================ Content macros =========


% ==== Grammars ====
% This goes here rather than contentmacros because Asy's settexpreamble
% doesn't look in the src directory when running contentmacros, so I 
% handle it as a separate job 
\usepackage{\computingClsDir/grammar}

% Env to indent text
\newenvironment{clip}{%
  \begin{list}{}{\setlength{\leftmargin}{1.25em}
                 \setlength{\parsep}{\grammarparsep}}\item[]
}{%
  \end{list}%
}


% ==== Remaining content macros ======
% Broken out separately so they can be used in the
% Asymptotegraphics
\usepackage{\computingClsDir/contentmacros}


% =================
% For xkcd graphics
\newlength{\xkcdheight}
\setlength{\xkcdheight}{1.85cm}

