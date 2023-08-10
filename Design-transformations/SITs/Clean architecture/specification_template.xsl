<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" xmlns:uFN="uFN">
    
    <xsl:output method="xml" omit-xml-declaration="no" indent="yes" encoding="UTF-8"/>

    <xsl:template match="Models/Package/ModelChildren/Class/ModelChildren/Operation[Stereotypes/Stereotype[@Name = 'Specification']]" mode="specification_template">
        
        <xsl:variable name="class_name" select="ancestor::Class/@Name" />
        <xsl:variable name="specification_name" select="@Name" />

        <xsl:variable name="specification_imports">
            <xsl:call-template name="import_template">
                <xsl:with-param name="import_package_name">Entities</xsl:with-param>
                <xsl:with-param name="import_project_name">
                    <xsl:value-of select="$projectName" />
                    <xsl:text>.Core</xsl:text>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        
        <xsl:variable name="specification_extends">
            <xsl:call-template name="extend_template">
                <xsl:with-param name="class_name">
                    <xsl:text>BaseSpecification&#60;</xsl:text>
                    <xsl:value-of select="$class_name" />
                    <xsl:text>&#62;</xsl:text>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="constructor_parameters">
            <xsl:for-each select="ModelChildren/Parameter">
                <xsl:call-template name="parameter_template">
                    <xsl:with-param name="parameter_name">
                        <xsl:value-of select="@Name"/>
                    </xsl:with-param>
                    <xsl:with-param name="parameter_type">
                        <xsl:value-of select="Type//@Name"/>
                    </xsl:with-param>
                    <xsl:with-param name="parameter_direction">
                        <xsl:value-of select="@Direction"/>
                    </xsl:with-param>
                    <xsl:with-param name="parameter_default_value">
                        <xsl:value-of select="@DefaultValue"/>
                    </xsl:with-param>   
                    <xsl:with-param name="parameter_description">
                        <xsl:value-of select="@Documentation_plain"/>
                    </xsl:with-param>  
                </xsl:call-template>
            </xsl:for-each>
        </xsl:variable>

        <xsl:variable name="constructor_parent_member">
            <xsl:call-template name="parent_member_template">
                <xsl:with-param name="parent_memeber_is_specification">
                    <xsl:text>true</xsl:text>
                </xsl:with-param>
                <xsl:with-param name="parent_member_parameters">
                    <xsl:copy-of select="exsl:node-set($constructor_parameters)/node()" />
                </xsl:with-param>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="specification_constructor">
            <xsl:call-template name="constructor_template" >
                <xsl:with-param name="constructor_name">
                    <xsl:value-of select="$specification_name" />
                </xsl:with-param>
                <xsl:with-param name="constructor_call_parent_member">
                    <xsl:text>true</xsl:text>
                </xsl:with-param>
                <xsl:with-param name="constructor_parameters">
                    <xsl:copy-of select="exsl:node-set($constructor_parameters)/node()" />
                </xsl:with-param>
                <xsl:with-param name="constructor_parent_member">
                    <xsl:copy-of select="exsl:node-set($constructor_parent_member)/node()" />
                </xsl:with-param>
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
                    <xsl:value-of select="$specification_name"/>
                </xsl:with-param>
                <xsl:with-param name="class_package_name">
                    <xsl:text>Specifications</xsl:text>
                </xsl:with-param>
                <xsl:with-param name="class_project_name">
                    <xsl:value-of select="$projectName"/>
                    <xsl:text>.Core</xsl:text>
                </xsl:with-param>
                <xsl:with-param name="class_fully_qualified_name">
                    <!-- <xsl:value-of select="uFN:getFullyQualifiedName(.)"/> -->
                    <xsl:value-of select="$projectName"/>
                    <xsl:text>.Specifications.</xsl:text>
                    <xsl:value-of select="$specification_name"></xsl:value-of>
                </xsl:with-param>
                <xsl:with-param name="class_has_default_constructor">
                    <xsl:text>false</xsl:text>
                </xsl:with-param>
                <xsl:with-param name="class_description">
                    <xsl:value-of select="@Documentation_plain"/>
                </xsl:with-param>
                <xsl:with-param name="class_imports">
                    <xsl:copy-of select="exsl:node-set($specification_imports)/node()"/>
                </xsl:with-param>
                <xsl:with-param name="class_extends">
                    <xsl:copy-of select="exsl:node-set($specification_extends)/node()"/>
                </xsl:with-param>
                <xsl:with-param name="class_constructors">
                    <xsl:copy-of select="exsl:node-set($specification_constructor)/node()"/>
                </xsl:with-param>
            </xsl:call-template>
    </xsl:template>
</xsl:stylesheet>
