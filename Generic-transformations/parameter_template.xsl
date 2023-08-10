<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" omit-xml-declaration="no" indent="yes" encoding="UTF-8"/>

    <xsl:template name="parameter_template">
        <xsl:param name="parameter_name"/>
        <xsl:param name="parameter_type"/>
        <xsl:param name="parameter_direction">in</xsl:param>
        <xsl:param name="parameter_default_value"/>
        <xsl:param name="parameter_description"/>

        <xsl:element name="Parameter">
            <xsl:attribute name="Name">
                <xsl:value-of select="$parameter_name"/>
            </xsl:attribute>
            <xsl:attribute name="DefaultValue">
                <xsl:value-of select="$parameter_default_value"/>
            </xsl:attribute>
            <xsl:attribute name="Direction">
                <xsl:value-of select="$parameter_direction"/>
            </xsl:attribute>
            <xsl:attribute name="Documentation_plain">
                <xsl:value-of select="$parameter_description"/>
            </xsl:attribute>
            
            <xsl:element name="Type">
                <xsl:element name="DataType">
                    <xsl:attribute name="Name">
                        <xsl:value-of select="$parameter_type"/>
                    </xsl:attribute>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
