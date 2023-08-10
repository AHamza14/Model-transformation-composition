<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" omit-xml-declaration="no" indent="yes" encoding="UTF-8"/>

    <xsl:template name="interface_template">
        <xsl:param name="interface_name"/>
        <xsl:param name="interface_package_name"/>
        <xsl:param name="interface_project_name"/>
        <xsl:param name="interface_fully_qualified_name"/>
        <xsl:param name="interface_visibility"/>
        <xsl:param name="interface_description"/>
        <xsl:param name="interface_imports"/>
        <xsl:param name="interface_implements"/>
        <xsl:param name="interface_operations"/>

        <xsl:element name="Interface">
            <xsl:attribute name="Name">
                <xsl:value-of select="$interface_name"/>
            </xsl:attribute>
            <xsl:attribute name="PackageName">
                <xsl:value-of select="$interface_package_name"/>
            </xsl:attribute>
            <xsl:attribute name="ProjectName">
                <xsl:value-of select="$interface_project_name"/>
            </xsl:attribute>
            <xsl:attribute name="FullyQualifiedName">
                <xsl:value-of select="$interface_fully_qualified_name"/>
            </xsl:attribute>
            <xsl:attribute name="Documentation_plain">
                <xsl:value-of select="$interface_description"/>
            </xsl:attribute>
            <xsl:attribute name="Visibility">
                <xsl:value-of select="$interface_visibility"/>
            </xsl:attribute>
            <xsl:element name="Imports">
                <xsl:copy-of select="$interface_imports"/>
            </xsl:element>
            <xsl:element name="Implementations">
                <xsl:copy-of select="$interface_implements"/>
            </xsl:element>
            <!-- <xsl:element name="Constantes">
                <xsl:copy-of select="$interface_constant_attributes"/>
            </xsl:element> -->
            <xsl:element name="Operations">
                <xsl:copy-of select="$interface_operations"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
