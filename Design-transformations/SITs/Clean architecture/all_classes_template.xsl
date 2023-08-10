<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" xmlns:uFN="uFN">
    
    <xsl:output method="xml" omit-xml-declaration="no" indent="yes" encoding="UTF-8"/>

    <xsl:include href="while.xsl"/>


    <xsl:template match="Models/Package/ModelChildren/Class[not (.//AssociationClass | .//Stereotype[@Name='enumeration'] | .//Stereotype[@Name='NotImplemented'])]" mode="all_classes_template">
        <xsl:variable name="class_id" select="@Id"/>
        <xsl:variable name="context_name" select="@Name"/>

        <xsl:variable name="class_package" >
            <!-- <xsl:if test="/.//Class[@Id=/.//Generalization[@To=$class_id]/@From]//Stereotype[@Name='Entity']">
                <xsl:text>Entities</xsl:text>
            </xsl:if> -->
            
            <xsl:call-template name="while">
                <xsl:with-param name="class_id">
                    <xsl:value-of select="$class_id"/>
                </xsl:with-param>
            </xsl:call-template>

        </xsl:variable>
        
        <xsl:variable name="class_extends">
            <xsl:for-each select="/.//Class[@Id=/.//Generalization[@To=$class_id]/@From]">
                <xsl:call-template name="extend_template">
                    <xsl:with-param name="class_name">
                        <xsl:value-of select="@Name"/>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:for-each>
        </xsl:variable>

        <xsl:variable name="class_implements">
            <xsl:for-each select="/.//Class[@Id=/.//Realization[@To=$class_id]/@From]">
                <xsl:call-template name="implement_template">
                    <xsl:with-param name="interface_name">
                        <xsl:value-of select="@Name"/>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:for-each>
        </xsl:variable>

        <xsl:variable name="class_attributes">
            
            <xsl:for-each select="ModelChildren/Attribute">
                <xsl:call-template name="attribute_template">
                    <xsl:with-param name="attribute_initial_value">
                        <xsl:value-of select="@InitialValue"/>
                    </xsl:with-param>
                    <xsl:with-param name="attribute_scope">
                        <xsl:value-of select="@Scope"/>
                    </xsl:with-param>
                    <xsl:with-param name="attribute_is_abstract">
                        <xsl:value-of select="@Abstract"/>
                    </xsl:with-param>
                    <xsl:with-param name="attribute_name">
                        <xsl:value-of select="@Name"/>
                    </xsl:with-param>
                    <xsl:with-param name="attribute_type">
                        <xsl:value-of select="Type//@Name"/>
                    </xsl:with-param>
                    <xsl:with-param name="attribute_visibility">
                        <xsl:value-of select="@Visibility"/>
                    </xsl:with-param>
                    <xsl:with-param name="attribute_is_read_only">
                        <xsl:value-of select="@ReadOnly"/>
                    </xsl:with-param>
                    <xsl:with-param name="attribute_has_getter">
                        <xsl:value-of select="@HasGetter"/>
                    </xsl:with-param>
                    <xsl:with-param name="attribute_has_setter">
                        <xsl:value-of select="@HasSetter"/>
                    </xsl:with-param>
                    <xsl:with-param name="attribute_description">
                        <xsl:value-of select="@Documentation_plain"/>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:for-each>

            <!-- Associations -->

            <xsl:for-each select="/.//Association[ToEnd/AssociationEnd/@EndModelElement=$class_id and (FromEnd/AssociationEnd/@Multiplicity='1' or FromEnd/AssociationEnd/@Multiplicity='Unspecified' or FromEnd/AssociationEnd/@Multiplicity='0..1')]">
                
                <xsl:variable name="fromEndClass" select="uFN:typeUMLElement(FromEnd/AssociationEnd/@EndModelElement)"/>

                <xsl:variable name="attribute_annotations">
                    <xsl:if test = "$fromEndClass//Stereotype[@Name = 'NotMapped']">
                        <xsl:call-template name="annotation_template">
                            <xsl:with-param name="annotation_name">NotMappedAttribute</xsl:with-param>
                        </xsl:call-template>
                    </xsl:if>
                </xsl:variable>

                <xsl:variable name="attribute_nullable">
                    <xsl:if test= "FromEnd/AssociationEnd/@Multiplicity = '0..1'">true</xsl:if>
                    <xsl:if test= "FromEnd/AssociationEnd/@Multiplicity != '0..1'">false</xsl:if>
                </xsl:variable>

                <xsl:if test="$fromEndClass//Stereotype[@Name != 'NotImplemented']">
                    <xsl:call-template name="attribute_template">
                        <xsl:with-param name="attribute_name">
                            <xsl:value-of select="$fromEndClass/@Name"/><xsl:text>Id</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="attribute_type">
                            <xsl:text>int</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="attribute_has_setter">
                            <xsl:text>true</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="attribute_has_getter">
                            <xsl:text>true</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="attribute_is_nullable">
                            <xsl:value-of select="$attribute_nullable"></xsl:value-of>
                        </xsl:with-param>                 
                    </xsl:call-template>
                    <xsl:call-template name="attribute_template">
                        <xsl:with-param name="attribute_name">
                            <xsl:value-of select="$fromEndClass/@Name"/>
                        </xsl:with-param>
                        <xsl:with-param name="attribute_type">
                            <xsl:value-of select="$fromEndClass/@Name"/>
                        </xsl:with-param>
                        <xsl:with-param name="attribute_has_setter">
                            <xsl:text>true</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="attribute_has_getter">
                            <xsl:text>true</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="attribute_annotations" select="exsl:node-set($attribute_annotations)/node()"/>                    
                    </xsl:call-template>
                </xsl:if>
            </xsl:for-each>

            <!-- Association 2  -->

            <xsl:for-each select="/.//Association[FromEnd/AssociationEnd/@EndModelElement=$class_id and (ToEnd/AssociationEnd/@Multiplicity='1' or ToEnd/AssociationEnd/@Multiplicity='Unspecified' or ToEnd/AssociationEnd/@Multiplicity='0..1')]">

                <xsl:variable name="toEndClass" select="uFN:typeUMLElement(ToEnd/AssociationEnd/@EndModelElement)"/>


                <xsl:variable name="attribute_annotations">
                    <xsl:if test = "$toEndClass//Stereotype[@Name = 'NotMapped']">
                        <xsl:call-template name="annotation_template">
                            <xsl:with-param name="annotation_name">NotMappedAttribute</xsl:with-param>
                        </xsl:call-template>
                    </xsl:if>
                </xsl:variable>

                <xsl:variable name="attribute_nullable">
                    <xsl:if test= "ToEnd/AssociationEnd/@Multiplicity = '0..1'">true</xsl:if>
                    <xsl:if test= "ToEnd/AssociationEnd/@Multiplicity != '0..1'">false</xsl:if>
                </xsl:variable>

                <xsl:if test="$toEndClass//Stereotype[@Name != 'NotImplemented']">
                    <xsl:call-template name="attribute_template">
                        <xsl:with-param name="attribute_name">
                            <xsl:value-of select="$toEndClass/@Name"/>
                        </xsl:with-param>
                        <xsl:with-param name="attribute_type">
                            <xsl:value-of select="$toEndClass/@Name"/>
                        </xsl:with-param>
                        <xsl:with-param name="attribute_is_nullable">
                            <xsl:value-of select="$attribute_nullable"/>
                        </xsl:with-param>
                        <xsl:with-param name="attribute_has_setter">true</xsl:with-param>
                        <xsl:with-param name="attribute_has_getter">true</xsl:with-param>
                        <xsl:with-param name="attribute_annotations" select="exsl:node-set($attribute_annotations)/node()"/>                    
                    </xsl:call-template>
                </xsl:if>
            </xsl:for-each>

            <!-- Associations 3-->

            <xsl:for-each select="/.//Association[ToEnd/AssociationEnd/@EndModelElement=$class_id and (FromEnd/AssociationEnd/@Multiplicity='*' or FromEnd/AssociationEnd/@Multiplicity='0..*' or FromEnd/AssociationEnd/@Multiplicity='1..*')]">
                
                <xsl:variable name="fromEndClass" select="uFN:typeUMLElement(FromEnd/AssociationEnd/@EndModelElement)"/>

                <xsl:variable name="attribute_annotations">
                    <xsl:if test = "$fromEndClass//Stereotype[@Name = 'NotMapped']">
                        <xsl:call-template name="annotation_template">
                            <xsl:with-param name="annotation_name">NotMappedAttribute</xsl:with-param>
                        </xsl:call-template>
                    </xsl:if>
                </xsl:variable>

                <xsl:variable name="attribute_nullable">
                    <xsl:if test= "FromEnd/AssociationEnd/@Multiplicity = '0..*'">true</xsl:if>
                    <xsl:if test= "FromEnd/AssociationEnd/@Multiplicity != '0..*'">false</xsl:if>
                </xsl:variable>

                <xsl:if test="$fromEndClass//Stereotype[@Name != 'NotImplemented']">
                    <xsl:call-template name="attribute_template">
                        <xsl:with-param name="attribute_name">
                            <xsl:value-of select="$fromEndClass/@Name"/><xsl:text>s</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="attribute_type">
                            <xsl:value-of select="$fromEndClass/@Name"/>
                        </xsl:with-param>
                        <xsl:with-param name="attribute_has_setter">
                            <xsl:text>true</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="attribute_has_getter">
                            <xsl:text>true</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="attribute_is_list">
                            <xsl:text>true</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="attribute_is_instantiated">
                            <xsl:text>true</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="attribute_annotations" select="exsl:node-set($attribute_annotations)/node()"/>                    
                    </xsl:call-template>
                </xsl:if>
            </xsl:for-each>

            <!-- Many to Many association -->

            <xsl:for-each select="/.//Association[FromEnd/AssociationEnd/@EndModelElement=$class_id and (FromEnd/AssociationEnd/@Multiplicity='*' or FromEnd/AssociationEnd/@Multiplicity='0..*' or FromEnd/AssociationEnd/@Multiplicity='1..*') and (ToEnd/AssociationEnd/@Multiplicity='*' or ToEnd/AssociationEnd/@Multiplicity='0..*' or ToEnd/AssociationEnd/@Multiplicity='1..*')]">
                
                <xsl:variable name="toEndClass" select="uFN:typeUMLElement(ToEnd/AssociationEnd/@EndModelElement)"/>

                <!-- <xsl:variable name="attribute_annotations">
                    <xsl:if test = "$toEndClass//Stereotype[@Name = 'NotMapped']">
                        <xsl:call-template name="annotation_template">
                            <xsl:with-param name="annotation_name">NotMappedAttribute</xsl:with-param>
                        </xsl:call-template>
                    </xsl:if>
                </xsl:variable> -->

                <xsl:if test="$toEndClass//Stereotype[@Name != 'NotImplemented']">
                    <xsl:call-template name="attribute_template">
                        <xsl:with-param name="attribute_name">
                            <xsl:value-of select="$toEndClass/@Name"/>
                        </xsl:with-param>
                        <xsl:with-param name="attribute_type">
                            <xsl:value-of select="$toEndClass/@Name"/>
                        </xsl:with-param>
                        <!-- <xsl:with-param name="attribute_annotations" select="exsl:node-set($attribute_annotations)/node()"/>                     -->
                    </xsl:call-template>
                </xsl:if>
            </xsl:for-each>

        </xsl:variable>

        <xsl:variable name="class_operations">
            <xsl:for-each select="ModelChildren/Operation[not(.//Stereotype[@Name='ServiceOperation'] | .//Stereotype[@Name='Specification'])]">
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
            </xsl:for-each>
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
                <xsl:value-of select="$class_package"/>
            </xsl:with-param>
            <xsl:with-param name="class_project_name">
                <xsl:value-of select="$projectName"/>
                <xsl:text>.Core</xsl:text>
            </xsl:with-param>
            <xsl:with-param name="class_fully_qualified_name">
                <xsl:value-of select="uFN:getFullyQualifiedName(.)"/>
            </xsl:with-param>
            <xsl:with-param name="class_description">
                <xsl:value-of select="@Documentation_plain"/>
            </xsl:with-param>
            <!-- <xsl:with-param name="class_imports">
                <xsl:copy-of select="exsl:node-set($class_imports)/node()"/>
            </xsl:with-param> -->
            <xsl:with-param name="class_extends">
                <xsl:copy-of select="exsl:node-set($class_extends)/node()"/>
            </xsl:with-param>
            <xsl:with-param name="class_implements">
                <xsl:copy-of select="exsl:node-set($class_implements)/node()"/>
            </xsl:with-param>
            <xsl:with-param name="class_attributes">
                <xsl:copy-of select="exsl:node-set($class_attributes)/node()"/>
            </xsl:with-param>
            <xsl:with-param name="class_operations">
                <xsl:copy-of select="exsl:node-set($class_operations)/node()"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

   
</xsl:stylesheet>
