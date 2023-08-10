<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" omit-xml-declaration="no" indent="yes" encoding="UTF-8"/>

    <xsl:template name="attribute_template">
        <xsl:param name="attribute_name"/>
        <xsl:param name="attribute_type"/>
        <xsl:param name="attribute_visibility">private</xsl:param>
        <xsl:param name="attribute_initial_value"/>
        <xsl:param name="attribute_scope">instance</xsl:param>  <!-- instance scope (not static), classifier scope (static) -->
        <xsl:param name="attribute_is_instantiated">false</xsl:param>
        <xsl:param name="attribute_is_list">false</xsl:param>
        <xsl:param name="attribute_is_read_only">false</xsl:param>
        <xsl:param name="attribute_is_abstract">false</xsl:param>
        <xsl:param name="attribute_is_nullable">false</xsl:param>
        <xsl:param name="attribute_has_getter">false</xsl:param>
        <xsl:param name="attribute_has_setter">false</xsl:param>
        <xsl:param name="attribute_description"/>
        <xsl:param name="attribute_annotations"/>


        <xsl:element name="Attribute">
            <xsl:attribute name="Name">
                <xsl:value-of select="$attribute_name"/>
            </xsl:attribute>
            <xsl:attribute name="Abstract">
                <xsl:value-of select="$attribute_is_abstract"/>
            </xsl:attribute>
            <xsl:attribute name="Documentation_plain">
                <xsl:value-of select="$attribute_description"/>
            </xsl:attribute>
            <xsl:attribute name="HasGetter">
                <xsl:value-of select="$attribute_has_getter"/>
            </xsl:attribute>
            <xsl:attribute name="HasSetter">
                <xsl:value-of select="$attribute_has_setter"/>
            </xsl:attribute>
            <xsl:attribute name="Nullable">
                <xsl:value-of select="$attribute_is_nullable"/>
            </xsl:attribute>
            <xsl:attribute name="InitialValue">
                <xsl:value-of select="$attribute_initial_value"/>
            </xsl:attribute>
            <xsl:attribute name="Instantiated">
                <xsl:value-of select="$attribute_is_instantiated"/>
            </xsl:attribute>
            <xsl:attribute name="List">
                <xsl:value-of select="$attribute_is_list"/>
            </xsl:attribute>
            <xsl:attribute name="ReadOnly">
                <xsl:value-of select="$attribute_is_read_only"/>
            </xsl:attribute>
            <xsl:attribute name="Scope">
                <xsl:value-of select="$attribute_scope"/>
            </xsl:attribute>
            <xsl:attribute name="Visibility">
                <xsl:value-of select="$attribute_visibility"/>
            </xsl:attribute>
            <xsl:element name="Annotations">
                <xsl:copy-of select="$attribute_annotations"/>
            </xsl:element>
            <xsl:element name="Type">
                <xsl:element name="DataType">
                    <xsl:attribute name="Name">
                        <xsl:value-of select="$attribute_type"/>
                    </xsl:attribute>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
