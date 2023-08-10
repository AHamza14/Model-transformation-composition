<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" xmlns:uFN="uFN">
    
    <xsl:output method="xml" omit-xml-declaration="no" indent="yes" encoding="UTF-8"/>

    <xsl:template match="//Class[Stereotypes/Stereotype[@Name='Repository']]" mode="repository_classes_template">

        <xsl:variable name="class_name" select="@Name" />
        <xsl:variable name="class_id" select="@Id" />

        <xsl:variable name="repository_class_name">
            <xsl:value-of select="$class_name" />
            <xsl:text>Repository</xsl:text>
        </xsl:variable>

        <xsl:variable name="repository_class_imports">
            <xsl:call-template name="import_template">
                <xsl:with-param name="import_package_name">Interfaces</xsl:with-param>
                <xsl:with-param name="import_project_name">
                    <xsl:value-of select="$projectName" />
                    <xsl:text>.Core</xsl:text>
                </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="import_template">
                <xsl:with-param name="import_package_name">Entities</xsl:with-param>
                <xsl:with-param name="import_project_name">
                    <xsl:value-of select="$projectName" />
                    <xsl:text>.Core</xsl:text>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="respository_class_implements">
            <xsl:call-template name="implement_template">
                <xsl:with-param name="interface_name">
                    <xsl:text>EfRepository&#60;</xsl:text>
                    <xsl:value-of select="$class_name" />
                    <xsl:text>&#62;</xsl:text>
                </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="implement_template">
                <xsl:with-param name="interface_name">
                    <xsl:text>I</xsl:text>
                    <xsl:value-of select="$repository_class_name" />
                </xsl:with-param>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="constructor_parameter">
            <xsl:variable name="parameter_name_type">
                <xsl:value-of select="$projectName" />
                <xsl:text>Context</xsl:text>
            </xsl:variable>
            <xsl:call-template name="parameter_template">
                <xsl:with-param name="parameter_name">
                    <xsl:value-of select="uFN:first-lower($parameter_name_type)" />
                </xsl:with-param>
                <xsl:with-param name="parameter_type">
                    <xsl:value-of select="$parameter_name_type" />
                </xsl:with-param>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="repo_class_constructor">
            <xsl:call-template name="constructor_template" >
                <xsl:with-param name="constructor_name">
                    <xsl:value-of select="$repository_class_name" />
                </xsl:with-param>
                <xsl:with-param name="constructor_call_parent_member">
                    <xsl:text>true</xsl:text>
                </xsl:with-param>
                <xsl:with-param name="constructor_parameters">
                    <xsl:copy-of select="exsl:node-set($constructor_parameter)/node()" />
                </xsl:with-param>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="id_parameter">
            <xsl:call-template name="parameter_template">
                <xsl:with-param name="parameter_name">id</xsl:with-param>
                <xsl:with-param name="parameter_type">int</xsl:with-param>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="repository_class_operations">
            <!-- GetByIdWith Operation FromEnd -->
            <xsl:for-each select="/.//Association[ToEnd/AssociationEnd/@EndModelElement=$class_id and (FromEnd/AssociationEnd/@Multiplicity='1' or FromEnd/AssociationEnd/@Multiplicity='Unspecified' or FromEnd/AssociationEnd/@Multiplicity='0..1')]">
                <xsl:variable name="fromEndClass" select="uFN:typeUMLElement(FromEnd/AssociationEnd/@EndModelElement)"/>
                <xsl:if test="not($fromEndClass//Stereotype[@Name = 'NotImplemented']) and not($fromEndClass//Stereotype[@Name = 'NotMapped'])">
                    <xsl:call-template name="operation_template">
                        <xsl:with-param name="operation_name">
                            <xsl:text>GetByIdWith</xsl:text>
                            <xsl:value-of select="$fromEndClass/@Name"/>
                        </xsl:with-param>
                        <xsl:with-param name="operation_visibility">
                            <xsl:text>public</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="operation_return_type">
                            <xsl:value-of select="$class_name" />
                        </xsl:with-param>
                        <xsl:with-param name="operation_parameters" select="exsl:node-set($id_parameter)/node()"/>        
                    </xsl:call-template>
                    <xsl:call-template name="operation_template">
                        <xsl:with-param name="operation_name">
                            <xsl:text>GetByIdWith</xsl:text>
                            <xsl:value-of select="$fromEndClass/@Name"/>
                            <xsl:text>Async</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="operation_visibility">
                            <xsl:text>public</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="operation_is_async">true</xsl:with-param>
                        <xsl:with-param name="operation_return_type">
                            <xsl:value-of select="$class_name" />
                        </xsl:with-param>
                        <xsl:with-param name="operation_parameters" select="exsl:node-set($id_parameter)/node()"/>        
                    </xsl:call-template>
                </xsl:if>
            </xsl:for-each>

            <!-- GetByIdWith Operation ToEnd -->
            <xsl:for-each select="/.//Association[FromEnd/AssociationEnd/@EndModelElement=$class_id and (ToEnd/AssociationEnd/@Multiplicity='1' or ToEnd/AssociationEnd/@Multiplicity='Unspecified' or ToEnd/AssociationEnd/@Multiplicity='0..1')]">
            <xsl:variable name="toEndClass" select="uFN:typeUMLElement(ToEnd/AssociationEnd/@EndModelElement)"/>
                <xsl:if test="not($toEndClass//Stereotype[@Name = 'NotImplemented']) and not($toEndClass//Stereotype[@Name = 'NotMapped'])">
                    <xsl:call-template name="operation_template">
                        <xsl:with-param name="operation_name">
                            <xsl:text>GetByIdWith</xsl:text>
                            <xsl:value-of select="$toEndClass/@Name"/>
                        </xsl:with-param>
                        <xsl:with-param name="operation_visibility">
                            <xsl:text>public</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="operation_return_type">
                            <xsl:value-of select="$class_name" />
                        </xsl:with-param>
                        <xsl:with-param name="operation_parameters" select="exsl:node-set($id_parameter)/node()"/>        
                    </xsl:call-template>
                    <xsl:call-template name="operation_template">
                        <xsl:with-param name="operation_name">
                            <xsl:text>GetByIdWith</xsl:text>
                            <xsl:value-of select="$toEndClass/@Name"/>
                            <xsl:text>Async</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="operation_visibility">
                            <xsl:text>public</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="operation_is_async">true</xsl:with-param>
                        <xsl:with-param name="operation_return_type">
                            <xsl:value-of select="$class_name" />
                        </xsl:with-param>
                        <xsl:with-param name="operation_parameters" select="exsl:node-set($id_parameter)/node()"/>        
                    </xsl:call-template>
                </xsl:if>
            </xsl:for-each>

            <!-- GetByIdWith Operation FromEnd with list-->
            <xsl:for-each select="/.//Association[ToEnd/AssociationEnd/@EndModelElement=$class_id and (FromEnd/AssociationEnd/@Multiplicity='*' or FromEnd/AssociationEnd/@Multiplicity='0..*' or FromEnd/AssociationEnd/@Multiplicity='1..*')]">

                <xsl:variable name="fromEndClass" select="uFN:typeUMLElement(FromEnd/AssociationEnd/@EndModelElement)"/>

                <xsl:if test="not($fromEndClass//Stereotype[@Name = 'NotImplemented']) and not($fromEndClass//Stereotype[@Name = 'NotMapped'])">
                    <xsl:call-template name="operation_template">
                        <xsl:with-param name="operation_name">
                            <xsl:text>GetByIdWith</xsl:text>
                            <xsl:value-of select="$fromEndClass/@Name"/>
                            <xsl:text>s</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="operation_visibility">
                            <xsl:text>public</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="operation_return_type">
                            <xsl:value-of select="$class_name" />
                        </xsl:with-param>
                        <xsl:with-param name="operation_parameters" select="exsl:node-set($id_parameter)/node()"/>        
                    </xsl:call-template>
                    <xsl:call-template name="operation_template">
                        <xsl:with-param name="operation_name">
                            <xsl:text>GetByIdWith</xsl:text>
                            <xsl:value-of select="$fromEndClass/@Name"/>
                            <xsl:text>sAsync</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="operation_visibility">
                            <xsl:text>public</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="operation_is_async">true</xsl:with-param>
                        <xsl:with-param name="operation_return_type">
                            <xsl:value-of select="$class_name" />
                        </xsl:with-param>
                        <xsl:with-param name="operation_parameters" select="exsl:node-set($id_parameter)/node()"/>        
                    </xsl:call-template>
                </xsl:if>
            </xsl:for-each>

        </xsl:variable>
        
        <xsl:call-template name="class_template">
            <xsl:with-param name="class_visibility">public</xsl:with-param>
            <xsl:with-param name="class_name">
                <xsl:value-of select="$repository_class_name" />
            </xsl:with-param>
            <xsl:with-param name="class_package_name">Repositories</xsl:with-param>
            <xsl:with-param name="class_project_name">
                <xsl:value-of select="$projectName" />
                <xsl:text>.Infrastructure</xsl:text>
            </xsl:with-param>
            <xsl:with-param name="class_has_default_constructor">
                <xsl:text>false</xsl:text>
            </xsl:with-param>
            <xsl:with-param name="class_fully_qualified_name">
                <xsl:value-of select="concat($projectName, '.Repositories.', $repository_class_name)"/>
            </xsl:with-param>
            <xsl:with-param name="class_imports">
                <xsl:copy-of select="exsl:node-set($repository_class_imports)/node()"/>
            </xsl:with-param>
            <xsl:with-param name="class_implements">
                <xsl:copy-of select="exsl:node-set($respository_class_implements)/node()"/>
            </xsl:with-param>
            <xsl:with-param name="class_constructors">
                <xsl:copy-of select="exsl:node-set($repo_class_constructor)/node()"/>
            </xsl:with-param>
            <xsl:with-param name="class_operations">
                <xsl:copy-of select="exsl:node-set($repository_class_operations)/node()"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>
</xsl:stylesheet>
