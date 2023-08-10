<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" xmlns:uFN="uFN">
    
    <xsl:output method="xml" omit-xml-declaration="no" indent="yes" encoding="UTF-8"/>

    <xsl:template match="ProjectInfo" mode="core_project_template">

        <xsl:variable name="project_description" select="ancestor::Project/@Description" />
        
        <xsl:variable name="core_project_references">
            <xsl:call-template name="reference_template">
                <xsl:with-param name="reference_name">
                    <xsl:value-of select="$projectName" />
                    <xsl:text>.SharedKernel</xsl:text>
                </xsl:with-param>
                <xsl:with-param name="reference_type">
                    <xsl:text>Project</xsl:text>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        
        <xsl:call-template name="project_template">
            <xsl:with-param name="project_name">
                <xsl:value-of select="$projectName" />
                <xsl:text>.Core</xsl:text>
            </xsl:with-param>
            <xsl:with-param name="project_description">
                <xsl:value-of select="$project_description"/>
            </xsl:with-param>
            <xsl:with-param name="project_references">
                <xsl:copy-of select="exsl:node-set($core_project_references)/node()"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>
</xsl:stylesheet>
