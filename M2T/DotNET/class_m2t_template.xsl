<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" xmlns:uFN="uFN">
    <xsl:import href="../../utilFunctions.xsl"/>

    <xsl:template match="Classifiers/Classes/Class">
        <xsl:variable name="class_name" select="@Name"/>
        <xsl:variable name="class_package_path" select="translate(@PackageName,'.','/')"/>
        <xsl:variable name="class_package_name" select="@PackageName"/>
        <xsl:variable name="class_project_name" select="@ProjectName"/>
        
        <xsl:variable name="class_is_abstract">
            <xsl:if test="@Abstract = 'true'"> abstract</xsl:if>
        </xsl:variable>

        <xsl:variable name="class_path" select="concat($class_project_name, '/', $class_package_path, '/', $class_name)"/>

        <xsl:variable name="class_namespace">
            <xsl:value-of select="$class_project_name" />
            <xsl:if test="$class_package_name != ''">
                <xsl:text>.</xsl:text><xsl:value-of select="$class_package_name" />
            </xsl:if>
        </xsl:variable>

        <xsl:result-document href="Output/Code/{$class_path}.cs" method="text">

    using System;
    using System.Collections;
    using System.Collections.Generic;
    using System.Text;
    using System.Threading.Tasks;
    using System.ComponentModel.DataAnnotations.Schema;

    <xsl:for-each select="Imports/Import">
    <xsl:text>using </xsl:text><xsl:value-of select="@ProjectName"/>
    <xsl:if test="@PackageName != ''">
        <xsl:text>.</xsl:text>
        <xsl:value-of select="@PackageName"/>
    </xsl:if>
    <xsl:text>;</xsl:text>
    <xsl:text>
    </xsl:text>
    </xsl:for-each>
    
    <xsl:text>
    </xsl:text>
    
    <xsl:text>namespace </xsl:text><xsl:value-of select="$class_namespace" />
    {
        
        <xsl:for-each select="Annotations/Annotation">
            [<xsl:value-of select="text()"/>]
        </xsl:for-each> 
        <xsl:value-of select="@Visibility"/><xsl:value-of select="$class_is_abstract"/><xsl:text> class </xsl:text><xsl:value-of select="$class_name"/> 
        <xsl:if test="Implementations/Implement | Extensions/Extend"> : </xsl:if><xsl:value-of select="uFN:getClassExtends(.)"/> {


            <xsl:for-each select="Attributes/Attribute">

            <xsl:variable name="attribute_visibility">
                <xsl:if test="@HasGetter = 'true' or @HasSetter = 'true'">public</xsl:if>
                <xsl:if test="@HasGetter = 'false' and @HasSetter = 'false'"><xsl:value-of select="@Visibility"/></xsl:if>
            </xsl:variable>

            <xsl:variable name="attribute_type">
                <xsl:if test="@List = 'true'">List&#60;<xsl:value-of select="uFN:UML-DotNet-DataType(Type//@Name)"/>&#62;</xsl:if>
                <xsl:if test="@List = 'false'"><xsl:value-of select="uFN:UML-DotNet-DataType(Type//@Name)"/></xsl:if>
            </xsl:variable>

            <xsl:variable name="attribute_name">
                <xsl:if test="@Visibility = 'private' and (@HasGetter = 'false' or @HasSetter = 'false')">
                    <xsl:text>_</xsl:text>
                    <xsl:value-of select="@Name"/>
                </xsl:if>
                <xsl:if test="not(@Visibility = 'private' and (@HasGetter = 'false' or @HasSetter = 'false'))">
                    <xsl:value-of select="uFN:first-upper(@Name)"/>
                </xsl:if>
            </xsl:variable>

            <xsl:for-each select="Annotations/Annotation">
            [<xsl:value-of select="text()"/>]
            </xsl:for-each>
            <xsl:value-of select="$attribute_visibility"/>
            <xsl:text> </xsl:text>
            <xsl:if test="@ReadOnly = 'true'">readonly </xsl:if>
            <xsl:value-of select="$attribute_type"/>
            <xsl:if test="@Nullable = 'true'">? </xsl:if>
            <xsl:text> </xsl:text>
            <xsl:value-of select="$attribute_name"/>
            <xsl:value-of select="uFN:attributeGetterSetter(.)"/>
            <xsl:if test="@Instantiated = 'true'"> = new  <xsl:value-of select="$attribute_type"/>();</xsl:if>
            <xsl:if test="@InitialValue != ''"> = <xsl:value-of select="@InitialValue"/>
            </xsl:if>
            <xsl:if test="@Instantiated = 'false' and (@HasGetter = 'false' or @HasSetter = 'false')">;</xsl:if>
            <xsl:text>

            </xsl:text>
            </xsl:for-each>

            <!-- constructors -->
            <xsl:if test="@DefaultConstructor = 'true'">
            <xsl:text>public </xsl:text><xsl:value-of select="$class_name" />() { }
            </xsl:if>

            <xsl:for-each select="Constructors/Constructor">
                <xsl:variable name="constructor_parameters">
                    <xsl:if test="@InitializeAll = 'true'">
                        <xsl:copy-of select="uFN:constructorSignature(ancestor::Class)"/>
                    </xsl:if>
                    <xsl:if test="not(@InitializeAll = 'true')">
                        <xsl:copy-of select="uFN:operationSignature(.)"/>
                    </xsl:if>
                </xsl:variable>
                
                <xsl:value-of select="@Visibility"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="@Name"/>(<xsl:value-of select="$constructor_parameters"/>)
                <xsl:if test="@CallParentMember = 'true'">
                    <xsl:if test="ParentMembers/ParentMember/@IsSpecification = 'true'">
                        <xsl:text> : base(c => </xsl:text>
                        <xsl:copy-of select="uFN:constructorSpecificationBase(.)"/>)
                    </xsl:if>
                    <xsl:if test="not(ParentMembers/ParentMember/@IsSpecification = 'true')">
                        <xsl:text> : base(</xsl:text><xsl:copy-of select="uFN:constructorBase(.)"/>)
                    </xsl:if>
                </xsl:if>
            {
                #region Constructor initialisation
                //<xsl:value-of select="@BodyCondition"/>
                <xsl:text>
                </xsl:text>
                <xsl:if test="@InitializeAll = 'true'">
                <xsl:for-each select="ancestor::Class/Attributes/Attribute">
                    <xsl:text>_</xsl:text>
                    <xsl:value-of select="@Name" />
                    <xsl:text> = </xsl:text>
                    <xsl:value-of select="@Name" />;
                </xsl:for-each>
                </xsl:if>
                #endregion
            }

            </xsl:for-each>
            
            <!-- Operations -->
            <xsl:for-each select="Operations/Operation">
                <xsl:variable name="returnType" select="uFN:UML-DotNet-DataType(ReturnType//@Name)"/>
                <xsl:variable name="final_return_type">
                    <xsl:if test="@Async='true'">
                        <xsl:text>Task&#60;</xsl:text>
                    </xsl:if>
                    <xsl:value-of select="$returnType" />
                    <xsl:if test="@Async='true'">
                        <xsl:text>&#62;</xsl:text>
                    </xsl:if>
                </xsl:variable>

                <xsl:value-of select="@Visibility"/>
                <xsl:text> </xsl:text>
                <xsl:if test="@Abstract = 'true'">abstract </xsl:if>
                <xsl:value-of select="$final_return_type"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="@Name"/>(<xsl:copy-of select="uFN:operationSignature(.)"/>)
            {
                #region Operation body
                // <xsl:value-of select="@BodyCondition"/>
                #endregion
                <xsl:if test="$final_return_type != 'void'">return <xsl:value-of select="uFN:default-init($final_return_type)"/>;</xsl:if>
            }

            </xsl:for-each>
        }

    }
        </xsl:result-document>

    </xsl:template>
</xsl:stylesheet>
