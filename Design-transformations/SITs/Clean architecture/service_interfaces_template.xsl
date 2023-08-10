<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" xmlns:uFN="uFN">
    
    <xsl:output method="xml" omit-xml-declaration="no" indent="yes" encoding="UTF-8"/>

    <xsl:template match="//Class[Stereotypes/Stereotype[@Name='Service']]" mode="service_interfaces_template">

        <xsl:variable name="first_class_name" select="@Name" />

        <xsl:variable name="class_name">
            <xsl:if test="TaggedValues/TaggedValueContainer/ModelChildren/TaggedValue[@Name = 'ServiceContainer' and @Value = 'self']">
                <xsl:value-of select="$first_class_name"></xsl:value-of>
            </xsl:if>
            <xsl:if test="not(TaggedValues/TaggedValueContainer/ModelChildren/TaggedValue[@Name = 'ServiceContainer' and @Value = 'self'])">
                <xsl:value-of select="TaggedValues/TaggedValueContainer/ModelChildren/TaggedValue[@Name = 'ServiceContainer']/@Value"></xsl:value-of>
            </xsl:if>
        </xsl:variable>

        <xsl:variable name="class_id" select="@Id" />

        <xsl:variable name="service_interface_name">
            <xsl:text>I</xsl:text>
            <xsl:value-of select="$class_name" />
            <xsl:text>Service</xsl:text>
        </xsl:variable>

        <xsl:variable name="service_interface_imports">
            <xsl:call-template name="import_template">
                <xsl:with-param name="import_package_name">Entities</xsl:with-param>
                <xsl:with-param name="import_project_name">
                    <xsl:value-of select="$projectName" />
                    <xsl:text>.Core</xsl:text>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="current_class_parameter">
            <xsl:call-template name="parameter_template">
                <xsl:with-param name="parameter_name">
                    <xsl:value-of select="$first_class_name" />
                </xsl:with-param>
                <xsl:with-param name="parameter_type">
                    <xsl:value-of select="$first_class_name" />
                </xsl:with-param>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="service_interface_operations">
            <xsl:variable name="crud_operations" select="'[Get,Add,Update,Delete]'"/>
            <xsl:for-each select="tokenize(replace($crud_operations, '^\[|\]$', ''), ',')">
                <xsl:variable name="crud_operation_name" select="."/>
                <xsl:variable name="crud_operation_return_type">
                    <xsl:if test="($crud_operation_name = 'Delete') or ($crud_operation_name = 'Update')">
                        <xsl:text>int</xsl:text>
                    </xsl:if>
                    <xsl:if test="($crud_operation_name = 'Get') or ($crud_operation_name = 'Add')">
                        <xsl:value-of select="$first_class_name" />
                    </xsl:if>
                </xsl:variable>
                <xsl:call-template name="operation_template">
                    <xsl:with-param name="operation_name">
                        <xsl:value-of select="$crud_operation_name" />
                        <xsl:value-of select="$first_class_name"/>
                    </xsl:with-param>
                    <xsl:with-param name="operation_return_type">
                        <xsl:value-of select="$crud_operation_return_type" />
                    </xsl:with-param>
                    <xsl:with-param name="operation_parameters" select="exsl:node-set($current_class_parameter)/node()"/>        
                </xsl:call-template>
                <xsl:call-template name="operation_template">
                    <xsl:with-param name="operation_name">
                        <xsl:value-of select="$crud_operation_name" />
                        <xsl:value-of select="$first_class_name"/>
                        <xsl:text>Async</xsl:text>
                    </xsl:with-param>
                    <xsl:with-param name="operation_is_async">true</xsl:with-param>
                    <xsl:with-param name="operation_return_type">
                        <xsl:value-of select="$crud_operation_return_type" />
                    </xsl:with-param>
                    <xsl:with-param name="operation_parameters" select="exsl:node-set($current_class_parameter)/node()"/>        
                </xsl:call-template>
            </xsl:for-each>

            <xsl:for-each select="ModelChildren/Operation[.//Stereotype[@Name='ServiceOperation']]">
                <xsl:variable name="operation_parameters">
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
                <xsl:call-template name="operation_template">
                    <xsl:with-param name="operation_name">
                        <xsl:value-of select="@Name"/>
                    </xsl:with-param>
                    <xsl:with-param name="operation_return_type">
                        <xsl:value-of select="ReturnType//@Name"/>
                    </xsl:with-param>
                    <xsl:with-param name="operation_visibility">
                        <xsl:value-of select="@Visibility"/>
                    </xsl:with-param>
                    <xsl:with-param name="operation_scope">
                        <xsl:value-of select="@Scope"/>
                    </xsl:with-param>
                    <xsl:with-param name="operation_is_abstract">
                        <xsl:value-of select="@Abstract"/>
                    </xsl:with-param>
                    <xsl:with-param name="operation_body_condition">
                        <xsl:value-of select="@BodyCondition"/>
                    </xsl:with-param>
                    <xsl:with-param name="operation_description">
                        <xsl:value-of select="@Documentation_plain"/>
                    </xsl:with-param>
                    <xsl:with-param name="operation_parameters" select="exsl:node-set($operation_parameters)/node()"/>
                </xsl:call-template>
                <xsl:call-template name="operation_template">
                    <xsl:with-param name="operation_name">
                        <xsl:value-of select="@Name"/>
                        <xsl:text>Async</xsl:text>
                    </xsl:with-param>
                    <xsl:with-param name="operation_is_async">true</xsl:with-param>
                    <xsl:with-param name="operation_return_type">
                        <xsl:value-of select="ReturnType//@Name"/>
                    </xsl:with-param>
                    <xsl:with-param name="operation_visibility">
                        <xsl:value-of select="@Visibility"/>
                    </xsl:with-param>
                    <xsl:with-param name="operation_scope">
                        <xsl:value-of select="@Scope"/>
                    </xsl:with-param>
                    <xsl:with-param name="operation_is_abstract">
                        <xsl:value-of select="@Abstract"/>
                    </xsl:with-param>
                    <xsl:with-param name="operation_body_condition">
                        <xsl:value-of select="@BodyCondition"/>
                    </xsl:with-param>
                    <xsl:with-param name="operation_description">
                        <xsl:value-of select="@Documentation_plain"/>
                    </xsl:with-param>
                    <xsl:with-param name="operation_parameters" select="exsl:node-set($operation_parameters)/node()"/>
                </xsl:call-template>
            </xsl:for-each>
        </xsl:variable>
        
        <xsl:call-template name="interface_template">
            <xsl:with-param name="interface_visibility">public</xsl:with-param>
            <xsl:with-param name="interface_name">
                <xsl:value-of select="$service_interface_name" />
            </xsl:with-param>
            <xsl:with-param name="interface_package_name">Interfaces</xsl:with-param>
            <xsl:with-param name="interface_project_name" >
                <xsl:value-of select="$projectName" />
                <xsl:text>.Core</xsl:text>
            </xsl:with-param>
            <xsl:with-param name="interface_fully_qualified_name">
                <xsl:value-of select="concat($projectName, '.Interfaces.', $service_interface_name)"/>
            </xsl:with-param>
            <xsl:with-param name="interface_imports">
                <xsl:copy-of select="exsl:node-set($service_interface_imports)/node()"/>
            </xsl:with-param>
            <xsl:with-param name="interface_operations">
                <xsl:copy-of select="exsl:node-set($service_interface_operations)/node()"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>
</xsl:stylesheet>
