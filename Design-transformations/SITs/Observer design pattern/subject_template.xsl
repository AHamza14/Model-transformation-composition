<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" xmlns:uFN="uFN">
    
    <xsl:output method="xml" omit-xml-declaration="no" indent="yes" encoding="UTF-8"/>

    <xsl:template match="//Class[Stereotypes/Stereotype[@Name = 'Subject']]" mode="subject_template">
        <xsl:param name="container_project"/>

        
        <xsl:variable name="subject_imports">
            <xsl:call-template name="import_template" >
                <xsl:with-param name="import_package_name">DesignPatterns.ObserverDesignPattern</xsl:with-param>
                <xsl:with-param name="import_project_name">
                    <xsl:value-of select="$container_project" />
                </xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        
        <xsl:variable name="subject_implement">
            <xsl:call-template name="implement_template" >
                <xsl:with-param name="interface_name">Subject</xsl:with-param>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="subject_attributes">
            <xsl:call-template name="attribute_template" >
                <xsl:with-param name="attribute_name">observers</xsl:with-param>
                <xsl:with-param name="attribute_type">Observer</xsl:with-param>
                <xsl:with-param name="attribute_visibility">private</xsl:with-param>
                <xsl:with-param name="attribute_is_list">true</xsl:with-param>
                <xsl:with-param name="attribute_is_instantiated">true</xsl:with-param>
                <xsl:with-param name="attribute_is_read_only">true</xsl:with-param>
                <xsl:with-param name="attribute_description">This attribute is a list and must be instantiated.</xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        
        <xsl:variable name="attach_detach_parameters">
            <xsl:call-template name="parameter_template" >
                <xsl:with-param name="parameter_name">o</xsl:with-param>
                <xsl:with-param name="parameter_type">Observer</xsl:with-param>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="subject_operations">
            <xsl:call-template name="operation_template" >
                <xsl:with-param name="operation_name">Attach</xsl:with-param>
                <xsl:with-param name="operation_return_type">void</xsl:with-param>
                <xsl:with-param name="operation_visibility">public</xsl:with-param>        
                <xsl:with-param name="operation_parameters" select="exsl:node-set($attach_detach_parameters)/node()"/>        
            </xsl:call-template>
            <xsl:call-template name="operation_template" >
                <xsl:with-param name="operation_name">Detach</xsl:with-param>
                <xsl:with-param name="operation_return_type">void</xsl:with-param>
                <xsl:with-param name="operation_visibility">public</xsl:with-param>        
                <xsl:with-param name="operation_parameters" select="exsl:node-set($attach_detach_parameters)/node()"/>        
            </xsl:call-template>
             <xsl:call-template name="operation_template" >
                <xsl:with-param name="operation_name">Notify</xsl:with-param>
                <xsl:with-param name="operation_return_type">void</xsl:with-param>
                <xsl:with-param name="operation_visibility">public</xsl:with-param>        
            </xsl:call-template>
        </xsl:variable>

        <xsl:call-template name="class_template" >
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
            <xsl:with-param name="class_imports">
                <xsl:copy-of select="exsl:node-set($subject_imports)/node()"/>
            </xsl:with-param>
            <xsl:with-param name="class_implements">
                <xsl:copy-of select="exsl:node-set($subject_implement)/node()"/>
            </xsl:with-param>
            <xsl:with-param name="class_attributes">
                <xsl:copy-of select="exsl:node-set($subject_attributes)/node()"/>
            </xsl:with-param>
            <xsl:with-param name="class_operations">
                <xsl:copy-of select="exsl:node-set($subject_operations)/node()"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

   
</xsl:stylesheet>
