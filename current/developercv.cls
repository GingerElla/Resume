%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Developer CV
% LaTeX Class
% Version 1.0 (28/1/19)
%
% This class originates from:
% http://www.LaTeXTemplates.com
%
% Authors:
% Jan Vorisek (jan@vorisek.me)
% Based on a template by Jan Küster (info@jankuester.com)
% Modified for LaTeX Templates by Vel (vel@LaTeXTemplates.com)
% Downloaded by Eleanor Nicolson on 09/07/2019, thereafter modified.
%
% License:
% The MIT License (see included LICENSE file)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%----------------------------------------------------------------------------------------
%	CLASS CONFIGURATION
%----------------------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{developercv}[2019/01/28 Developer CV class v1.0]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}} % Pass through any options to the base class
\ProcessOptions\relax % Process given options

\LoadClass{extarticle} % Load the base class

%----------------------------------------------------------------------------------------
%	PACKAGES AND OTHER DOCUMENT CONFIGURATIONS
%----------------------------------------------------------------------------------------

\setlength{\parindent}{0mm} % Suppress paragraph indentation

\usepackage{xcolor, soul} % used with package hyperref

\usepackage{tcolorbox} % used for dividers

\usepackage[hidelinks]{hyperref} % Required for links but hide the default boxes around links

\newcommand{\link}[2]{\href{#1}{\setul{0.4ex}{0.15ex}\setulcolor{blue}\ul{#2}}}

\newcommand{\lorem}{Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec a diam lectus.} % Dummy text

\pagestyle{empty} % No headers or footers

\usepackage{moresize} % Provides more font size commands (\HUGE and \ssmall)

\definecolor{theme-color}{HTML}{0057af} % blue used for colorboxes, use https://accessible-colors.com/ before changing the color
\definecolor{light-blue}{HTML}{0070e2} % lighter blue used for icons

%-------------------------------------------------------------------------------
%	PAGE LAYOUT
%-------------------------------------------------------------------------------

\usepackage{geometry} % Required for adjusting page dimensions and margins

\geometry{
	paper=a4paper, % Paper size, change to letterpaper for US letter size
	top=1.75cm, % Top margin
	bottom=1.75cm, % Bottom margin
	left=2cm, % Left margin
	right=2cm, % Right margin
	headheight=0.75cm, % Header height
	footskip=1cm, % Space from the bottom margin to the baseline of the footer
	headsep=0.5cm, % Space from the top margin to the baseline of the header
	%showframe, % Uncomment to show how the type block is set on the page
}

\usepackage{fancyhdr}
\fancyfoot[R]{Last Updated \today}
\pagestyle{fancy}

%-------------------------------------------------------------------------------
%	FONTS
%-------------------------------------------------------------------------------

\usepackage[utf8]{inputenc} % Required for inputting international characters
\usepackage[T1]{fontenc} % Output font encoding for international characters

%usepackage[default]{raleway}
%\usepackage[defaultsans]{droidsans}
%\usepackage{cmbright}
%\usepackage{fetamont}
\usepackage[default]{gillius}% removes warnings about text bullets
%\usepackage{roboto}

\renewcommand*\familydefault{\sfdefault} % Force the sans-serif version of any font used

% For properly formatted underscores regardless of font use \_
\chardef\_=`_

%------------------------------------------------

\usepackage{fontawesome5} % Required for FontAwesome icons

% Command to output an icon in a black square box with text to the right
\newcommand{\icon}[3]{% The first parameter is the FontAwesome icon name, the second is the box size and the third is the text
	\vcenteredhbox{\colorbox{theme-color}{\makebox(#2, #2){\textcolor{white}{\large\csname fa#1\endcsname}}}}% Icon and box
	\hspace{0.2cm}% Whitespace
	\vcenteredhbox{\textcolor{black}{#3}} % Text
}

%-------------------------------------------------------------------------------
%	GRAPHICS DEFINITIONS
%------------------------------------------------------------------------------- 

\usepackage{tikz} % Required for creating the plots
\usetikzlibrary{shapes, backgrounds}
\tikzset{x=1cm, y=1cm} % Default tikz units

% Command to vertically centre adjacent content
\newcommand{\vcenteredhbox}[1]{% The only parameter is for the content to centre
	\begingroup%
		\setbox0=\hbox{#1}\parbox{\wd0}{\box0}%
	\endgroup%
}

%-------------------------------------------------------------------------------
%	CHARTS
%------------------------------------------------------------------------------- 

\newcounter{barcount}

% Environment to hold a new bar chart
\newenvironment{barchart}[1]{ % The only parameter is the maximum bar width, in cm
	\newcommand{\barwidth}{0.35}
	\newcommand{\barsep}{0.2}
	
	% Command to add a bar to the bar chart
	\newcommand{\baritem}[2]{ % The first argument is the bar label and the second is the percentage the current bar should take up of the total width
		\pgfmathparse{##2}
		\let\perc\pgfmathresult
		
		\pgfmathparse{#1}
		\let\barsize\pgfmathresult
		
		\pgfmathparse{\barsize*##2/100}
		\let\barone\pgfmathresult
		
		\pgfmathparse{(\barwidth*\thebarcount)+(\barsep*\thebarcount)}
		\let\barx\pgfmathresult
		
		\filldraw[fill=black, draw=none] (0,-\barx) rectangle (\barone,-\barx-\barwidth);
		
		%\node [label=180:\colorbox{black}{\textcolor{white}{##1}}] at (0,-\barx-0.175) {};
		\node [label=180:\textbf{##1}] at (0,-\barx-0.175) {};
		\addtocounter{barcount}{1}
	}
	\begin{tikzpicture}
		\setcounter{barcount}{0}
}{
	\end{tikzpicture}
}

%------------------------------------------------

\newcounter{a}
\newcounter{b}
\newcounter{c}

% Command to output a number of automatically-sized bubbles from a string in the format of '<size>/<label>', e.g. \bubbles{5/Eclipse, 6/git, 4/Office, 3/Inkscape, 3/Blender}
\newcommand{\bubbles}[1]{
	% Reset counters
	\setcounter{a}{0}
	\setcounter{c}{150}
	
	\begin{tikzpicture}[scale=3]
		\foreach \p/\t in {#1} {
			\addtocounter{a}{1}
			\bubble{\thea/1.5}{\theb}{\p/25}{\t}{1\p0}
		}
	\end{tikzpicture}
}

% Command to output a bubble at a specific position with a specific size
\newcommand{\bubble}[5]{
	\filldraw[fill=black, draw=none] (#1,0.5) circle (#3); % Bubble
	%\node[label=\colorbox{light-blue}{\textcolor{white}{#4}}] at (#1,0.7) {}; % Label
	\node[label=#4] at (#1,0.7) {}; % Label
}

% Command to output a row of five dots, the first #1 of which are filled
\newcommand{\dotrating}[1]{%
	\foreach \i in {1,...,5}{%
		\ifnum\i>#1\relax
			\tikz[baseline=-0.55ex]{\draw[theme-color, line width=0.4pt] (0,0) circle (1.5pt);}%
		\else
			\tikz[baseline=-0.55ex]{\fill[theme-color] (0,0) circle (1.5pt);}%
		\fi
		\kern2pt%
	}%
}

% Command to output a single pie filled to #1 fifths
\newcommand{\pierating}[1]{%
	\begin{tikzpicture}[baseline=-0.7ex]
		\pgfmathsetmacro\ang{#1/5*360}%
		\fill[theme-color] (0,0) -- (90:3.6pt) arc (90:90-\ang:3.6pt) -- cycle;%
		\draw[theme-color, line width=0.4pt] (0,0) circle (3.6pt);%
	\end{tikzpicture}%
}

% Command for a labelled five-dot skill rating with dots aligned to the right: \dotskill{Label}{n}
\newcommand{\skillrating}{\dotrating}% swap to \pierating to preview the pie style
\newcommand{\dotskill}[2]{\makebox[\linewidth][l]{{\small\textbf{#1}}\hfill\skillrating{#2}}\par\vspace{2pt}}

%-------------------------------------------------------------------------------
%	CUSTOM SECTIONS & DIVIDERS
%-------------------------------------------------------------------------------

% Command to output section title headings
\newlength{\cvsectskip} % Uniform whitespace above every section heading
\setlength{\cvsectskip}{0.6\baselineskip}
\newcommand{\cvsect}[1]{% The only parameter is the section text
	\vspace{\cvsectskip} % Uniform whitespace before the section title
	\colorbox{theme-color}{\textcolor{white}{\MakeUppercase{\textbf{#1}}}}% Section title
	\vspace{\baselineskip} % Whitespace after the section title
}

\newcommand{\divider}[1]{% The only parameter is the divider text
	\tcbset{width=\textwidth,boxrule=0pt,colback=theme-color,arc=0pt,auto outer arc,left=0pt,right=0pt,boxsep=0pt}
	%\vspace{\baselineskip} % Whitespace before the divider
	\begin{tcolorbox}
	\centering\textcolor{white}{\MakeUppercase{\textbf{#1}}}
	\end{tcolorbox}
	%\vspace{\baselineskip} % Whitespace after divider
}

%-------------------------------------------------------------------------------
%	ENTRY LIST
%-------------------------------------------------------------------------------

\usepackage{longtable} % Required for tables that span multiple pages
\setlength{\LTpre}{0pt} % Remove default whitespace before longtable
\setlength{\LTpost}{0pt} % Remove default whitespace after longtable

\setlength{\tabcolsep}{0pt} % No spacing between table columns

% Environment to hold a new list of entries
\newenvironment{entrylist}{
	\begin{longtable}[H]{l l}
}{
	\end{longtable}
	\vspace{-\entryskip}% Cancel the trailing gap after the last entry so section spacing stays uniform
}

\newlength{\entryskip} % Tunable vertical gap between entries
\setlength{\entryskip}{2mm}

% Optional first argument is the role (appended to the heading); then date, heading, right-aligned qualifier, and description
\newcommand{\entry}[5][]{%
	\parbox[t]{0.175\textwidth}{% 17.5% of the text width of the page
		{\footnotesize #2} % Leftmost entry date(s) text
	}%
	&\parbox[t]{0.825\textwidth}{% 82.5% of the text width of the page
		\textbf{#3}% Entry heading (team) text
		\def\cventryrole{#1}\ifx\cventryrole\empty\else, \textbf{#1}.\fi% Optional role at the end of the heading
		\hfill% Horizontal whitespace
		{\footnotesize \textbf{\textcolor{black}{#4}}}\\% Right-aligned entry qualifier text
		#5 % Entry description text
		\par\vspace{\entryskip}% Tunable gap below the entry
	}\\}

\newcommand{\smallentry}[3]{% First argument for the leftmost date(s) text, second is for the bold entry heading, third is for the bold right-aligned entry qualifier
	\parbox[t]{0.175\textwidth}{% 17.5% of the text width of the page
		{\footnotesize #1} % Leftmost entry date(s) text
	}%
	&\parbox[t]{0.825\textwidth}{% 82.5% of the text width of the page
		\textbf{#2}% Entry heading text
		\hfill% Horizontal whitespace
		{\footnotesize \textbf{\textcolor{black}{#3}}}% Right-aligned entry qualifier text
	}\\\\}

% Command to output a separator slash between lists, e.g. '  /  '
\newcommand{\slashsep}{\hspace{3mm}/\hspace{3mm}}

%-------------------------------------------------------------------------------
%	SINGLE LINE LIST LIST
%-------------------------------------------------------------------------------
\newcommand{\onelinelist}[1]{ %
	\foreach \n [count=\ni] in {#1} {%
		\ifnum\ni=1%
			\texttt{\n}%
    	\else%
        	\slashsep \texttt{\n}%
    	\fi%
	}%
}%

%-------------------------------------------------------------------------------
%	NO SEP LINE LIST LIST
%-------------------------------------------------------------------------------
\usepackage{enumitem}
\newcommand{\noseplist}[1]{ %
	\begin{itemize}[noitemsep,nosep]%
	#1%
	\end{itemize}%
}%