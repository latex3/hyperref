<?xml version="1.0" encoding="us-ascii"?>
<!DOCTYPE xsl:stylesheet [
<!ENTITY indent "    ">
]>
<xsl:stylesheet
  version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text" encoding="us-ascii"/>

  <xsl:template match="/">
    <xsl:for-each select="//ENTRY">
      <xsl:value-of select="@date"/>
      <xsl:if test="@version">
        <xsl:text>  </xsl:text>
        <xsl:value-of select="@version"/>
      </xsl:if>
      <xsl:text>  </xsl:text>
      <xsl:value-of select="@by"/>
      <xsl:text>&#10;</xsl:text>
      <xsl:apply-templates select="text()"/>
      <xsl:text>&#10;</xsl:text>
    </xsl:for-each>
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
        <xsl:text>&indent;</xsl:text>
        <xsl:value-of select="$text"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>&indent;</xsl:text>
        <xsl:value-of select="substring-before($text, '&#10;')"/>
        <xsl:text>&#10;</xsl:text>
        <xsl:call-template name="text">
          <xsl:with-param name="text" select="substring-after($text, '&#10;')"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
