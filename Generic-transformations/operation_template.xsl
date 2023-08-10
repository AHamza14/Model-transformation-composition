<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" omit-xml-declaration="no" indent="yes" encoding="UTF-8"/>

    <xsl:template name="operation_template">
        <xsl:param name="operation_name"/>
        <xsl:param name="operation_return_type"/>
        <xsl:param name="operation_visibility"/>
        <xsl:param name="operation_scope">instance</xsl:param>
        <xsl:param name="operation_is_abstract">false</xsl:param>
        <xsl:param name="operation_is_async">false</xsl:param>
        <xsl:param name="operation_body_condition"/>
        <xsl:param name="operation_description"/>
        <xsl:param name="operation_parameters"/>

        <xsl:element name="Operation">
            <xsl:attribute name="Name">
                <xsl:value-of select="$operation_name"/>
            </xsl:attribute>
            <xsl:attribute name="Abstract">
                <xsl:value-of select="$operation_is_abstract"/>
            </xsl:attribute>
            <xsl:attribute name="Async">
                <xsl:value-of select="$operation_is_async"/>
            </xsl:attribute>
            <xsl:attribute name="BodyCondition">
                <xsl:value-of select="$operation_body_condition"/>
            </xsl:attribute>
            <xsl:attribute name="Documentation_plain">
                <xsl:value-of select="$operation_description"/>
            </xsl:attribute>
            <xsl:attribute name="Scope">
                <xsl:value-of select="$operation_scope"/>
            </xsl:attribute>
            <xsl:attribute name="Visibility">
                <xsl:value-of select="$operation_visibility"/>
            </xsl:attribute>
            
            
            <xsl:element name="ReturnType">
                <xsl:element name="DataType">
                    <xsl:attribute name="Name">
                        <xsl:value-of select="$operation_return_type"/>
                    </xsl:attribute>
                </xsl:element>
            </xsl:element>
            <xsl:element name="ModelChildren">
                <xsl:copy-of select="$operation_parameters"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
