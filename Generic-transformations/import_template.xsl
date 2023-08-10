<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" omit-xml-declaration="no" indent="yes" encoding="UTF-8"/>

    <xsl:template name="import_template">
        <xsl:param name="import_package_name"/>
        <xsl:param name="import_project_name"/>

        <xsl:element name="Import">
            <xsl:attribute name="ProjectName">
                <xsl:value-of select="$import_project_name"/>
            </xsl:attribute>
            <xsl:attribute name="PackageName">
                <xsl:value-of select="$import_package_name"/>
            </xsl:attribute>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
