<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" xmlns:uFN="uFN">
    
    <xsl:output method="xml" omit-xml-declaration="no" indent="yes" encoding="UTF-8"/>

    <xsl:template match="//Class[Stereotypes/Stereotype[@Name = 'enumeration']]" mode="enumerations_template">


        <xsl:variable name="enumeration_literals">
            <xsl:for-each select="ModelChildren/EnumerationLiteral">
                <xsl:call-template name="enum_literal_template">
                    <xsl:with-param name="enum_literal_name">
                        <xsl:value-of select="@Name" />
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:for-each>
        </xsl:variable>
        
        <xsl:call-template name="enumeration_template">
            <xsl:with-param name="enumeration_name">
                <xsl:value-of select="@Name"/>
            </xsl:with-param>
            <xsl:with-param name="enumeration_project_name">
                <xsl:value-of select="$projectName"/>
                <xsl:text>.Core</xsl:text>
            </xsl:with-param>
            <xsl:with-param name="enumeration_fully_qualified_name">
                <xsl:value-of select="uFN:getFullyQualifiedName(.)"/>
            </xsl:with-param>
            <xsl:with-param name="enumeration_visibility">
                <xsl:value-of select="@Visibility"/>
            </xsl:with-param>
            <xsl:with-param name="enumeration_literals">
                <xsl:copy-of select="exsl:node-set($enumeration_literals)/node()"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>
</xsl:stylesheet>
