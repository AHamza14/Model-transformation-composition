<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" omit-xml-declaration="no" indent="yes" encoding="UTF-8"/>

    <xsl:template name="parent_member_template">
        <xsl:param name="parent_memeber_is_specification">false</xsl:param>
        <xsl:param name="parent_member_description"/>
        <xsl:param name="parent_member_parameters"/>

        <xsl:element name="ParentMember">
            <xsl:attribute name="Documentation_plain">
                <xsl:value-of select="$parent_member_description"/>
            </xsl:attribute>
            <xsl:attribute name="IsSpecification">
                <xsl:value-of select="$parent_memeber_is_specification"/>
            </xsl:attribute>
            <xsl:element name="ModelChildren">
                <xsl:copy-of select="$parent_member_parameters"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
