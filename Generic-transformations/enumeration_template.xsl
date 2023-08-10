<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" omit-xml-declaration="no" indent="yes" encoding="UTF-8"/>

    <xsl:template name="enumeration_template">
        <xsl:param name="enumeration_name"/>
        <xsl:param name="enumeration_project_name"/>
        <xsl:param name="enumeration_fully_qualified_name"/>
        <xsl:param name="enumeration_visibility"/>
        <xsl:param name="enumeration_literals"/>

        <xsl:element name="Enumeration">
            <xsl:attribute name="Name">
                <xsl:value-of select="$enumeration_name"/>
            </xsl:attribute>
            <xsl:attribute name="ProjectName">
                <xsl:value-of select="$enumeration_project_name"/>
            </xsl:attribute>
            <xsl:attribute name="FullyQualifiedName">
                <xsl:value-of select="$enumeration_fully_qualified_name"/>
            </xsl:attribute>
            <xsl:attribute name="Visibility">
                <xsl:value-of select="$enumeration_visibility"/>
            </xsl:attribute>
            <xsl:element name="EnumerationLiterals">
                <xsl:copy-of select="$enumeration_literals"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
