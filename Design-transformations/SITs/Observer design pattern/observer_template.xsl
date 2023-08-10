<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" xmlns:uFN="uFN">
    
    <xsl:output method="xml" omit-xml-declaration="no" indent="yes" encoding="UTF-8"/>

    <xsl:template match="//Class[Stereotypes/Stereotype[@Name = 'Observer']]" mode="observer_template">
        <xsl:param name="container_project"/>


        <xsl:variable name="observer_imports">
            <xsl:call-template name="import_template" >
                <xsl:with-param name="import_package_name">DesignPatterns.ObserverDesignPattern</xsl:with-param>
                <xsl:with-param name="import_project_name"><xsl:value-of select="$container_project" /></xsl:with-param>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="observer_implement">
            <xsl:call-template name="implement_template">
                <xsl:with-param name="interface_name">Observer</xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        
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
            <xsl:with-param name="class_imports">
                <xsl:copy-of select="exsl:node-set($observer_imports)/node()"/>
            </xsl:with-param>
             <!-- <xsl:with-param name="class_package_name">
                <xsl:value-of select=""/>
            </xsl:with-param> -->
            <xsl:with-param name="class_project_name">
                <xsl:value-of select="$container_project"/>
            </xsl:with-param>
            <xsl:with-param name="class_fully_qualified_name">
                <xsl:value-of select="uFN:getFullyQualifiedName(.)"/>
            </xsl:with-param>
            <xsl:with-param name="class_description">
                <xsl:value-of select="@Documentation_plain"/>
            </xsl:with-param>
            <xsl:with-param name="class_implements">
                <xsl:copy-of select="exsl:node-set($observer_implement)/node()"/>
            </xsl:with-param>
            <xsl:with-param name="class_operations">
                <xsl:copy-of select="exsl:node-set($observer_operations)/node()"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

   
</xsl:stylesheet>
