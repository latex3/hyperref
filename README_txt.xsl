<?xml version="1.0" encoding="us-ascii"?>
<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#10;">
<!ENTITY secA " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz/`&quot;1234567890&lt;&gt;:\.">
<!ENTITY secB "=======================================================================">
<!ENTITY secC "-----------------------------------------------------------------------">
<!ENTITY lc "abcdefghijklmnopqrstuvwxyz">
<!ENTITY uc "ABCDEFGHIJKLMNOPQRSTUVWXYZ">
]>
<xsl:stylesheet
  version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="text" encoding="us-ascii"/>

  <xsl:template match="/">
    <xsl:apply-templates select="readme/date"/>
    <xsl:call-template name="toc"/>
    <xsl:apply-templates select="readme/section"/>
  </xsl:template>

  <xsl:template match="date">
    <xsl:text>README for hyperref bundle, </xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>&nl;</xsl:text>
    <xsl:text>&nl;</xsl:text>
  </xsl:template>

  <xsl:template name="toc">
    <xsl:text>&nl;</xsl:text>
    <xsl:text>TABLE OF CONTENTS&nl;</xsl:text>
    <xsl:text>=================&nl;</xsl:text>
    <xsl:text>&nl;</xsl:text>
    <xsl:apply-templates select="/readme/section/title" mode="toc"/>
    <xsl:text>&nl;</xsl:text>
  </xsl:template>

  <xsl:template match="title" mode="toc">
    <xsl:value-of select="position()"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>&nl;</xsl:text>
  </xsl:template>

  <xsl:template match="section/title">
    <xsl:variable name="num"
      select="count(preceding::section/title) + 1"/>
    <xsl:text>&nl;</xsl:text>
    <xsl:value-of select="$num"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="translate(., '&lc;', '&uc;')"/>
    <xsl:text>&nl;</xsl:text>
    <xsl:value-of select="translate(translate(string($num), '&secA;', '&secB;'), &quot;'&quot;, '=')"/>
    <xsl:text>=</xsl:text>
    <xsl:value-of select="translate(translate(., '&secA;', '&secB;'), &quot;'&quot;, '=')"/>
    <xsl:text>&nl;</xsl:text>
    <xsl:text>&nl;</xsl:text>
  </xsl:template>

  <xsl:template match="subsection/title">
    <xsl:text></xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>&nl;</xsl:text>
    <xsl:value-of select="translate(translate(., '&secA;', '&secC;'), &quot;'&quot;, '-')"/>
    <xsl:text>&nl;</xsl:text>
  </xsl:template>

  <xsl:template match="p">
    <xsl:apply-templates select="text()|*"/>
    <xsl:text>&nl;</xsl:text>
  </xsl:template>

  <xsl:template match="text()">
    <xsl:choose>
      <xsl:when test="normalize-space(.) = ''"/>
      <xsl:when test="starts-with(., '&nl;')">
        <xsl:value-of select="substring-after(., '&nl;')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="."/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
