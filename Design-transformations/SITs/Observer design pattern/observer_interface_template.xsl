<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" xmlns:uFN="uFN">
    
    <xsl:output method="xml" omit-xml-declaration="no" indent="yes" encoding="UTF-8"/>

    <xsl:template name="observer_interface_template">
        <xsl:param name="container_project"/>
        
        <xsl:variable name="update_parameters">
            <xsl:call-template name="parameter_template">
                <xsl:with-param name="parameter_name">subject</xsl:with-param>
                <xsl:with-param name="parameter_type">object</xsl:with-param>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="observer_operations">
            <xsl:call-template name="operation_template">
                <xsl:with-param name="operation_name">Update</xsl:with-param>
                <xsl:with-param name="operation_return_type">void</xsl:with-param>
                <xsl:with-param name="operation_visibility">public</xsl:with-param>        
                <xsl:with-param name="operation_parameters" select="exsl:node-set($update_parameters)/node()"/>        
            </xsl:call-template>
        </xsl:variable>

        <xsl:call-template name="interface_template">
            <xsl:with-param name="interface_visibility">public</xsl:with-param>
            <xsl:with-param name="interface_name">Observer</xsl:with-param>
            <xsl:with-param name="interface_package_name">DesignPatterns.ObserverDesignPattern</xsl:with-param>
            <xsl:with-param name="interface_project_name" select="$container_project"></xsl:with-param>
            <xsl:with-param name="interface_fully_qualified_name">
                <xsl:value-of select="concat($container_project, '.DesignPatterns.ObserverDesignPattern.Observer')"/>
            </xsl:with-param>
            <xsl:with-param name="interface_operations">
                <xsl:copy-of select="exsl:node-set($observer_operations)/node()"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

   
</xsl:stylesheet>
