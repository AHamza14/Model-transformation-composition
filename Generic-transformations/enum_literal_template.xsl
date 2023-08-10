<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" omit-xml-declaration="no" indent="yes" encoding="UTF-8"/>

    <xsl:template name="enum_literal_template">
        <xsl:param name="enum_literal_name"/>

        <xsl:element name="EnumerationLiteral">
            <xsl:value-of select="$enum_literal_name"/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
