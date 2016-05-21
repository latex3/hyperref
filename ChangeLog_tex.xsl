<?xml version="1.0" encoding="us-ascii"?>
<!DOCTYPE xsl:stylesheet [
<!ENTITY indent "    ">
]>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text" encoding="us-ascii"/>

  <xsl:template match="/">
    <xsl:text>% lualatex
\documentclass{article}
\usepackage[
  a4paper,
  ignorehead,
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
  pdfusetitle,
]{hyperref}

\usepackage{bmhydoc}

\setcounter{secnumdepth}{0}

\title{ChangeLog for hyperref bundle}
\author{Heiko Oberdiek, Sebastian Rathz}
\date{}

\newcommand*{\GobbleTwo}[2]{}

\AtBeginDocument{%
  \catcode`\*=\active
}
\begingroup
  \catcode`\*=\active
  \gdef*{%
    \leavevmode
    \begingroup
      \setbox0=\hbox{ }%
      \hbox to \wd0{\hss\string*\hss}%
    \endgroup
  }%
\endgroup

\begin{document}
\maketitle
    </xsl:text>
    <xsl:for-each select="//ENTRY">
      <xsl:variable name="year" select="substring(@date, 1, 4)"/>
      <xsl:if test="substring(preceding-sibling::ENTRY[1]/@date, 1, 4) != $year">
        <xsl:text>\pdfbookmark[1]{</xsl:text>
        <xsl:value-of select="$year"/>
        <xsl:text>}{</xsl:text>
        <xsl:value-of select="$year"/>
        <xsl:text>}&#10;</xsl:text>
      </xsl:if>
      <xsl:text>\subsection[</xsl:text>
      <xsl:value-of select="@date"/>
      <xsl:if test="@version">
        <xsl:text> </xsl:text>
        <xsl:value-of select="@version"/>
      </xsl:if>
      <xsl:text>]{</xsl:text>
      <xsl:value-of select="@date"/>
      <xsl:if test="@version">
        <xsl:text>  </xsl:text>
        <xsl:value-of select="@version"/>
      </xsl:if>
      <xsl:text>  </xsl:text>
      <xsl:value-of select="@by"/>
      <xsl:text>}&#10;\begin{itemize}\GobbleTwo</xsl:text>
      <xsl:apply-templates select="text()"/>
      <xsl:text>\end{verbatim}&#10;\end{itemize}&#10;</xsl:text>
    </xsl:for-each>
    <xsl:text>\end{document}&#10;</xsl:text>
  </xsl:template>

  <xsl:template match="text()">
    <xsl:choose>
      <xsl:when test="starts-with(., '&#10;')">
        <xsl:call-template name="text">
          <xsl:with-param name="text" select="substring-after(., '&#10;')"/>
        </xsl:call-template>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="text">
    <xsl:param name="text"/>
    <xsl:choose>
      <xsl:when test="string-length($text) = 0"/>
      <xsl:when test="substring-after($text, '&#10;') = ''">
        <xsl:call-template name="line">
          <xsl:with-param name="line" select="$text"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="line">
          <xsl:with-param name="line"
            select="concat(substring-before($text, '&#10;'), '&#10;')"/>
        </xsl:call-template>
        <xsl:call-template name="text">
          <xsl:with-param name="text" select="substring-after($text, '&#10;')"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="line">
    <xsl:param name="line"/>
    <xsl:choose>
      <xsl:when test="starts-with($line, '* ')">
        <xsl:text>\end{verbatim}&#10;</xsl:text>
        <xsl:text>\item \begin{verbatim}&#10;</xsl:text>
        <xsl:value-of select="substring($line, 2)"/>
      </xsl:when>
      <xsl:when test="starts-with($line, '  ')">
        <xsl:value-of select="substring($line, 2)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$line"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
