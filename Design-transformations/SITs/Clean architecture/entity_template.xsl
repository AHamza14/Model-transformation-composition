<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" xmlns:uFN="uFN">
    
    <xsl:output method="xml" omit-xml-declaration="no" indent="yes" encoding="UTF-8"/>

    <xsl:template match="//Class[Stereotypes/Stereotype[@Name = 'Entity']]" mode="entity_template">

        <xsl:variable name="entity_imports">
            <xsl:call-template name="import_template">
                <xsl:with-param name="import_project_name">
                    <xsl:value-of select="$projectName" />
                    <xsl:text>.SharedKernel</xsl:text>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="entity_extend">
            <xsl:call-template name="extend_template">
                <xsl:with-param name="class_name">BaseEntity</xsl:with-param>
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
            <!-- <xsl:with-param name="class_package">
                <xsl:value-of select="$entity_package"/>
            </xsl:with-param> -->
            <xsl:with-param name="class_description">
                <xsl:value-of select="@Documentation_plain"/>
            </xsl:with-param>
            <xsl:with-param name="class_imports">
                <xsl:copy-of select="exsl:node-set($entity_imports)/node()"/>
            </xsl:with-param>
            <xsl:with-param name="class_extends">
                <xsl:copy-of select="exsl:node-set($entity_extend)/node()"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>
</xsl:stylesheet>
