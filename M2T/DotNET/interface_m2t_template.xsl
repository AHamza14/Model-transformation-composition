<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:uFN="uFN">
    <xsl:import href="../../utilFunctions.xsl"/>


    <xsl:template match="Classifiers/Interfaces/Interface">
        <xsl:variable name="interface_name" select="@Name"/>
        <!-- <xsl:variable name="interface_package_name" select="@PackageName"/> -->
        <xsl:variable name="interface_project_name" select="@ProjectName"/>

        <xsl:variable name="interface_package_path" select="translate(@PackageName,'.','/')"/>

        <xsl:variable name="interface_package_name" select="@PackageName"/>
        
        <xsl:variable name="interface_path" select="concat($interface_project_name,'/',$interface_package_path,'/',$interface_name)"/>

        <xsl:variable name="interface_namespace">
            <xsl:value-of select="$interface_project_name" />
            <xsl:if test="$interface_package_name != ''">
                <xsl:text>.</xsl:text><xsl:value-of select="$interface_package_name" />
            </xsl:if>
        </xsl:variable>

        <xsl:result-document href="Output/Code/{$interface_path}.cs" method="text">

using System.Threading.Tasks;
<xsl:for-each select="Imports/Import">
    <xsl:text>using </xsl:text><xsl:value-of select="@ProjectName"/>
    <xsl:text>.</xsl:text>
    <xsl:value-of select="@PackageName"/>;
</xsl:for-each>

<xsl:text>
</xsl:text>

<xsl:text>namespace </xsl:text><xsl:value-of select="$interface_namespace" />
{
    <xsl:value-of select="@Visibility"/><xsl:text> interface </xsl:text><xsl:value-of select="$interface_name"/> 
            <xsl:if test="Implementations/Implement"> : </xsl:if><xsl:value-of select="uFN:getClassExtends(.)"/> 
    {
        <xsl:for-each select="Operations/Operation">
            <xsl:variable name="return_type" select="uFN:UML-DotNet-DataType(ReturnType//@Name)"/>
            <xsl:variable name="final_return_type">
                <xsl:if test="@Async='true'">
                    <xsl:text>Task&#60;</xsl:text>
                </xsl:if>
                <xsl:value-of select="$return_type" />
                <xsl:if test="@Async='true'">
                    <xsl:text>&#62;</xsl:text>
                </xsl:if>
            </xsl:variable>

            <xsl:value-of select="@Visibility"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="$final_return_type"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="@Name"/>(<xsl:copy-of select="uFN:operationSignature(.)"/>);
        </xsl:for-each>
    }
}
        </xsl:result-document>

    </xsl:template>


</xsl:stylesheet>
