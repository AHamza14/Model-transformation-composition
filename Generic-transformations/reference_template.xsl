<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" omit-xml-declaration="no" indent="yes" encoding="UTF-8"/>

    <xsl:template name="reference_template">
        <xsl:param name="reference_name"/>
        <xsl:param name="reference_type"/> 
        <!-- projectReference or packageReference (contains version) -->
        <xsl:param name="reference_version"/>

        <xsl:element name="Reference">
            <xsl:attribute name="Name">
                <xsl:value-of select="$reference_name"/>
            </xsl:attribute>
            <xsl:attribute name="Type">
                <xsl:value-of select="$reference_type"/>
            </xsl:attribute>
            <xsl:attribute name="Version">
                <xsl:value-of select="$reference_version"/>
            </xsl:attribute>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
