<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" xmlns:uFN="uFN">
    
    <xsl:output method="xml" omit-xml-declaration="no" indent="yes" encoding="UTF-8"/>

    <xsl:template match="ProjectInfo" mode="ef_context_template">

        <xsl:variable name="project_name">
            <xsl:value-of select="$projectName"/>
            <xsl:text>.Infrastructure</xsl:text>
        </xsl:variable>

        <xsl:variable name="class_name">
            <xsl:value-of select="$projectName"/>
            <xsl:text>Context</xsl:text>
        </xsl:variable>

        <xsl:variable name="context_imports">
            <xsl:call-template name="import_template">
                <xsl:with-param name="import_package_name">
                    <xsl:text>Entities</xsl:text>
                </xsl:with-param>
                <xsl:with-param name="import_project_name">
                    <xsl:value-of select="$projectName" />
                    <xsl:text>.Core</xsl:text>
                </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="import_template">
                <xsl:with-param name="import_project_name">
                    <xsl:text>Microsoft.EntityFrameworkCore</xsl:text>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="context_extend">
            <xsl:call-template name="extend_template">
                <xsl:with-param name="class_name">DbContext</xsl:with-param>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="context_attributs">
            <xsl:for-each select="//Class[Stereotypes/Stereotype[@Name = 'Entity']]">
                <xsl:call-template name="attribute_template">
                    <xsl:with-param name="attribute_name">
                        <xsl:value-of select="@Name"/>
                        <xsl:text>s</xsl:text>
                    </xsl:with-param>
                    <xsl:with-param name="attribute_type">
                        <xsl:text>DbSet&#60;</xsl:text>
                        <xsl:value-of select="@Name"/>
                        <xsl:text>&#62;</xsl:text>
                    </xsl:with-param>
                    <xsl:with-param name="attribute_visibility">
                        <xsl:text>public</xsl:text>
                    </xsl:with-param>
                    <xsl:with-param name="attribute_has_getter">
                        <xsl:text>true</xsl:text>
                    </xsl:with-param>
                    <xsl:with-param name="attribute_has_setter">
                        <xsl:text>true</xsl:text>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="/.//Models/Package/ModelChildren/Class[@Id=/.//Generalization/@To]">
                <xsl:variable name="attribute_class_id" select="@Id" />
                <xsl:if test="/.//Class[@Id=/.//Generalization[@To=$attribute_class_id]/@From]//Stereotype[@Name='Entity']">
                    <xsl:call-template name="attribute_template">
                        <xsl:with-param name="attribute_name">
                            <xsl:value-of select="@Name"/>
                            <xsl:text>s</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="attribute_type">
                            <xsl:text>DbSet&#60;</xsl:text>
                            <xsl:value-of select="@Name"/>
                            <xsl:text>&#62;</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="attribute_visibility">
                            <xsl:text>public</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="attribute_has_getter">
                            <xsl:text>true</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="attribute_has_setter">
                            <xsl:text>true</xsl:text>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        
        <xsl:variable name="constructor_parameters_1">
            <xsl:call-template name="parameter_template">
                <xsl:with-param name="parameter_name">
                    <xsl:text>options</xsl:text>
                </xsl:with-param>
                <xsl:with-param name="parameter_type">
                    <xsl:text>DbContextOptions</xsl:text>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
                    
        <!-- <xsl:variable name="constructor_parameters_2">
            <xsl:call-template name="parameter_template">
                <xsl:with-param name="parameter_name">
                    <xsl:text> new DbContextOptionsBuilder&#60;</xsl:text>
                    <xsl:value-of select="$class_name" />
                    <xsl:text>&#62;().UseSqlServer(@"Server=.;Database=</xsl:text>
                    <xsl:value-of select="$projectName" />
                    <xsl:text>DB;Trusted_Connection=True;").Options</xsl:text>
                </xsl:with-param>
                <xsl:with-param name="parameter_type">
                    <xsl:text> </xsl:text>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:variable> -->

        <xsl:variable name="context_constructor">
            <xsl:call-template name="constructor_template" >
                <xsl:with-param name="constructor_name">
                    <xsl:value-of select="$class_name" />
                </xsl:with-param>
                <xsl:with-param name="constructor_call_parent_class">
                    <xsl:text>true</xsl:text>
                </xsl:with-param>
                <xsl:with-param name="constructor_parameters">
                    <xsl:copy-of select="exsl:node-set($constructor_parameters_1)/node()" />
                </xsl:with-param>
            </xsl:call-template>
            <!-- <xsl:call-template name="constructor_template" >
                <xsl:with-param name="constructor_name">
                    <xsl:value-of select="$class_name" />
                </xsl:with-param>
                <xsl:with-param name="constructor_call_parent_class">
                    <xsl:text>true</xsl:text>
                </xsl:with-param>
                <xsl:with-param name="constructor_parameters">
                    <xsl:copy-of select="exsl:node-set($constructor_parameters_2)/node()" />
                </xsl:with-param>
            </xsl:call-template> -->
        </xsl:variable>

        <xsl:call-template name="class_template">
            <xsl:with-param name="class_visibility">
                <xsl:text>public</xsl:text>
            </xsl:with-param>
            <xsl:with-param name="class_name">
                <xsl:value-of select="$class_name"/>
            </xsl:with-param>
            <xsl:with-param name="class_project_name">
                <xsl:value-of select="$project_name"/>
            </xsl:with-param>
            <xsl:with-param name="class_fully_qualified_name">
                <xsl:value-of select="$project_name"/>
                <xsl:text>.</xsl:text>
                <xsl:value-of select="$class_name"/>
            </xsl:with-param>
            <!-- <xsl:with-param name="class_has_default_constructor">
                <xsl:text>false</xsl:text>
            </xsl:with-param> -->
            <xsl:with-param name="class_imports">
                <xsl:copy-of select="exsl:node-set($context_imports)/node()"/>
            </xsl:with-param>
            <xsl:with-param name="class_extends">
                <xsl:copy-of select="exsl:node-set($context_extend)/node()"/>
            </xsl:with-param>
            <xsl:with-param name="class_attributes">
                <xsl:copy-of select="exsl:node-set($context_attributs)/node()"/>
            </xsl:with-param>
            <xsl:with-param name="class_constructors">
                <xsl:copy-of select="exsl:node-set($context_constructor)/node()"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>
</xsl:stylesheet>
