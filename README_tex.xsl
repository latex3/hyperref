<?xml version="1.0" encoding="us-ascii"?>
<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#10;">
<!ENTITY secA " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz/&quot;">
<!ENTITY secB "=======================================================">
<!ENTITY secC "-------------------------------------------------------">
<!ENTITY lc "abcdefghijklmnopqrstuvwxyz">
<!ENTITY uc "ABCDEFGHIJKLMNOPQRSTUVWXYZ">
]>
<xsl:stylesheet
  version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text" encoding="us-ascii"/>

  <xsl:strip-space elements="p"/>

  <xsl:template match="/">
    <xsl:text>% lualatex
\documentclass{article}
\usepackage[
  a4paper,
  hmargin=20mm,
  includehead,
  includefoot,
  vmargin=20mm,
]{geometry}
\usepackage{ifluatex,ifxetex}
\ifnum 0\ifluatex 1\else\ifxetex 1\fi\fi=0 %
  \usepackage[T1]{fontenc}%
  \usepackage{lmodern}%
  \renewcommand*{\ttdefault}{lmvtt}%
\else
  \usepackage{fontspec}%
  \renewcommand*{\ttdefault}{lmvtt}%
\fi
\usepackage[
  colorlinks,
  pdfusetitle,
  bookmarksnumbered,
]{hyperref}

\usepackage{bmhydoc}

\pagestyle{headings}
\setcounter{secnumdepth}{1}

\title{README for hyperref bundle}
\author{Heiko Oberdiek, Sebastian Rahtz}
    </xsl:text>
    <xsl:text>\newcommand*{\DATE}{</xsl:text>
    <xsl:value-of select="readme/date"/>
    <xsl:text>}</xsl:text>
    <xsl:text>
\date{\DATE}
\hypersetup{pdfsubject=Date: \DATE}

\begingroup
  \makeatletter
  \catcode`\*=\active
  \gdef*{%
    \leavevmode
    \begingroup
      \setbox0=\hbox{ }%
      \hbox to \wd0{\hss\string*\hss}%
    \endgroup
  }%
  \global\let\org@verbatim\verbatim
  \gdef\verbatim{%
    \catcode`\*=\active
    \org@verbatim
  }%
\endgroup

\begin{document}
\maketitle
\pdfbookmark[1]{\contentsname}{toc}
\tableofcontents
    </xsl:text>
    <xsl:apply-templates select="readme/section"/>
    <xsl:text>&nl;\end{document}&nl;</xsl:text>
  </xsl:template>

  <xsl:template match="section/title">
    <xsl:text>\section{</xsl:text>
    <xsl:call-template name="sectiontext">
      <xsl:with-param name="text" select="."/>
    </xsl:call-template>
    <xsl:text>}&nl;</xsl:text>
  </xsl:template>

  <xsl:template match="subsection/title">
    <xsl:text>\subsection{</xsl:text>
    <xsl:call-template name="sectiontext">
      <xsl:with-param name="text" select="."/>
    </xsl:call-template>
    <xsl:text>}&nl;</xsl:text>
  </xsl:template>

  <xsl:template match="p">
    <xsl:apply-templates select="text()|*"/>
    <xsl:text>&nl;</xsl:text>
  </xsl:template>

  <xsl:template match="text()">
    <xsl:choose>
      <xsl:when test="normalize-space(.) = ''"/>
      <xsl:when test="starts-with(., '&nl;')">
        <xsl:call-template name="text">
          <xsl:with-param name="text" select="substring-after(., '&nl;')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>\begin{verbatim}&nl;</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>\end{verbatim}&nl;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="text">
    <xsl:param name="text"/>
    <xsl:choose>
      <xsl:when test="substring($text, string-length($text), 1) = ' '">
        <xsl:call-template name="text">
          <xsl:with-param name="text"
            select="substring($text, 1, string-length($text) - 1)"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>\begin{verbatim}&nl;</xsl:text>
        <xsl:value-of select="$text"/>
        <xsl:text>\end{verbatim}&nl;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="sectiontext">
    <xsl:param name="text"/>
    <xsl:choose>
      <xsl:when test="string-length($text) = 0"/>
      <xsl:when test="contains($text, '\')">
        <xsl:value-of select="substring-before($text, '\')"/>
        <xsl:text>\textbackslash </xsl:text>
        <xsl:call-template name="sectiontext">
          <xsl:with-param name="text"
            select="substring-after($text, '\')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
