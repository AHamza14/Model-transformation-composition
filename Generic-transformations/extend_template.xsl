<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" omit-xml-declaration="no" indent="yes" encoding="UTF-8"/>

    <xsl:template name="extend_template">
        <xsl:param name="class_name"/>

        <xsl:element name="Extend">
            <xsl:value-of select="$class_name"/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
