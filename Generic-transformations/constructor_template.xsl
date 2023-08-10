<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" omit-xml-declaration="no" indent="yes" encoding="UTF-8"/>

    <xsl:template name="constructor_template">
        <xsl:param name="constructor_name"/>
        <xsl:param name="constructor_visibility">public</xsl:param>
        <xsl:param name="constructor_initialize_all">false</xsl:param>
        <xsl:param name="constructor_body_condition"/>
        <xsl:param name="constructor_description"/>
        <xsl:param name="constructor_call_parent_member">false</xsl:param>
        <xsl:param name="constructor_parent_member"/>
        <xsl:param name="constructor_parameters"/>

        <xsl:element name="Constructor">
            <xsl:attribute name="Name">
                <xsl:value-of select="$constructor_name"/>
            </xsl:attribute>
            <xsl:attribute name="InitializeAll">
                <xsl:value-of select="$constructor_initialize_all"/>
            </xsl:attribute>
            <xsl:attribute name="BodyCondition">
                <xsl:value-of select="$constructor_body_condition"/>
            </xsl:attribute>
            <xsl:attribute name="Documentation_plain">
                <xsl:value-of select="$constructor_description"/>
            </xsl:attribute>
            <xsl:attribute name="Visibility">
                <xsl:value-of select="$constructor_visibility"/>
            </xsl:attribute>
            <xsl:attribute name="CallParentMember">
                <xsl:value-of select="$constructor_call_parent_member"/>
            </xsl:attribute>
            <xsl:element name="ParentMembers">
                <xsl:copy-of select="$constructor_parent_member"/>
            </xsl:element>
            <xsl:element name="ModelChildren">
                <xsl:copy-of select="$constructor_parameters"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
