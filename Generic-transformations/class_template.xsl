<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" omit-xml-declaration="no" indent="yes" encoding="UTF-8"/>

    <xsl:template name="class_template">
        <xsl:param name="class_name"/>
        <xsl:param name="class_package_name"/>
        <xsl:param name="class_project_name"/>
        <xsl:param name="class_fully_qualified_name"/>
        <xsl:param name="class_is_abstract">false</xsl:param>
        <xsl:param name="class_visibility"/>
        <xsl:param name="class_is_leaf">false</xsl:param>  <!-- isLeaf (sealed in C#, final in java) can not be instantiated -->
        <xsl:param name="class_description"/>
        <xsl:param name="class_imports"/>
        <!-- <xsl:param name="class_package"/> -->
        <xsl:param name="class_annotations"/>
        <xsl:param name="class_implements"/>
        <xsl:param name="class_extends"/>
        <xsl:param name="class_has_default_constructor">true</xsl:param>
        <xsl:param name="class_constructors"/>
        <xsl:param name="class_attributes"/>
        <xsl:param name="class_operations"/>

        <xsl:element name="Class">
            <xsl:attribute name="Name">
                <xsl:value-of select="$class_name"/>
            </xsl:attribute>
            <xsl:attribute name="PackageName">
                <xsl:value-of select="$class_package_name"/>
            </xsl:attribute>
            <xsl:attribute name="ProjectName">
                <xsl:value-of select="$class_project_name"/>
            </xsl:attribute>
            <xsl:attribute name="FullyQualifiedName">
                <xsl:value-of select="$class_fully_qualified_name"/>
            </xsl:attribute>
            <!-- <xsl:attribute name="Package">
                <xsl:value-of select="$class_package"/>
            </xsl:attribute> -->
            <xsl:attribute name="Abstract">
                <xsl:value-of select="$class_is_abstract"/>
            </xsl:attribute>
            <xsl:attribute name="Documentation_plain">
                <xsl:value-of select="$class_description"/>
            </xsl:attribute>
            <xsl:attribute name="Leaf">
                <xsl:value-of select="$class_is_leaf"/>
            </xsl:attribute>
            <xsl:attribute name="Visibility">
                <xsl:value-of select="$class_visibility"/>
            </xsl:attribute>
            <xsl:attribute name="DefaultConstructor">
                <xsl:value-of select="$class_has_default_constructor"/>
            </xsl:attribute>
            <xsl:element name="Imports">
                <xsl:copy-of select="$class_imports"/>
            </xsl:element>
            <xsl:element name="Annotations">
                <xsl:copy-of select="$class_annotations"/>
            </xsl:element>
            <xsl:element name="Implementations">
                <xsl:copy-of select="$class_implements"/>
            </xsl:element>
            <xsl:element name="Extensions">
                <xsl:copy-of select="$class_extends"/>
            </xsl:element>
            <xsl:element name="Constructors">
                <xsl:copy-of select="$class_constructors"/>
            </xsl:element>
            <xsl:element name="Attributes">
                <xsl:copy-of select="$class_attributes"/>
            </xsl:element>
            <xsl:element name="Operations">
                <xsl:copy-of select="$class_operations"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
