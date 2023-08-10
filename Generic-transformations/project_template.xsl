<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" omit-xml-declaration="no" indent="yes" encoding="UTF-8"/>

    <xsl:template name="project_template">
        <xsl:param name="project_name"/>
        <xsl:param name="project_description"/>
        <xsl:param name="project_references"/>

        <xsl:element name="Project">
            <xsl:attribute name="Name">
                <xsl:value-of select="$project_name"/>
            </xsl:attribute>
            <xsl:attribute name="Description">
                <xsl:value-of select="$project_description"/>
            </xsl:attribute>
            <xsl:element name="References">
                <xsl:copy-of select="$project_references"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
