<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" xmlns:uFN="uFN">
    
    <xsl:output method="xml" omit-xml-declaration="no" indent="yes" encoding="UTF-8"/>

    <xsl:template match="//Class[Stereotypes/Stereotype[@Name = 'AggregateRoot']]" mode="aggregate_root_template">

        <xsl:variable name="aggregate_root_imports">
            <xsl:call-template name="import_template">
                <xsl:with-param name="import_package_name">Interfaces</xsl:with-param>
                <xsl:with-param name="import_project_name">
                    <xsl:value-of select="$projectName" />
                    <xsl:text>.SharedKernel</xsl:text>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
    
        <xsl:variable name="aggregate_root_implements">
            <xsl:call-template name="implement_template">
                <xsl:with-param name="interface_name">IAggregateRoot</xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        
        <xsl:call-template name="class_template">
            <xsl:with-param name="class_is_abstract">
                <xsl:value-of select="@Abstract"/>
            </xsl:with-param>
            <xsl:with-param name="class_visibility">
                <xsl:value-of select="@Visibility"/>
            </xsl:with-param>
            <xsl:with-param name="class_is_leaf">
                <xsl:value-of select="@Leaf"/>
            </xsl:with-param>
            <xsl:with-param name="class_name">
                <xsl:value-of select="@Name"/>
            </xsl:with-param>
            <xsl:with-param name="class_package_name">
                <xsl:text>Entities</xsl:text>
            </xsl:with-param>
            <xsl:with-param name="class_project_name">
                <xsl:value-of select="$projectName"/>
                <xsl:text>.Core</xsl:text>
            </xsl:with-param>
            <xsl:with-param name="class_fully_qualified_name">
                <xsl:value-of select="uFN:getFullyQualifiedName(.)"/>
            </xsl:with-param>
            <xsl:with-param name="class_imports">
                <xsl:copy-of select="exsl:node-set($aggregate_root_imports)/node()"/>
            </xsl:with-param>
            <xsl:with-param name="class_description">
                <xsl:value-of select="@Documentation_plain"/>
            </xsl:with-param>
            <xsl:with-param name="class_implements">
                <xsl:copy-of select="exsl:node-set($aggregate_root_implements)/node()"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>
</xsl:stylesheet>
