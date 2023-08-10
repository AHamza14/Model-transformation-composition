<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:uFN="uFN">

    <xsl:template match="Enumerations">
        
        <xsl:variable name="enums_path">
            <xsl:value-of select="Enumeration[1]/@ProjectName" />
        </xsl:variable>

        <xsl:result-document href="Output/Code/{$enums_path}/enums.cs" method="text">

<xsl:text>namespace </xsl:text><xsl:value-of select="$enums_path" />
{    
    <xsl:for-each select="Enumeration">
            <xsl:variable name="enumeration_name" select="@Name"/>
    <xsl:value-of select="@Visibility"/><xsl:text> enum </xsl:text><xsl:value-of select="$enumeration_name"/> 
    {
        <xsl:for-each select="EnumerationLiterals/EnumerationLiteral">
        <xsl:value-of select="text()"/> = <xsl:value-of select="position()-1" />
        <xsl:if test="position()!=last()">, </xsl:if>
        </xsl:for-each>
    }
    <xsl:text>
    </xsl:text>
    </xsl:for-each>
}
        </xsl:result-document>

    </xsl:template>


</xsl:stylesheet>
