<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" xmlns:uFN="uFN">
    <xsl:import href="../../utilFunctions.xsl"/>

    <xsl:template match="Projects/Project">
        <xsl:variable name="project_name">
            <xsl:value-of select="@Name" />
        </xsl:variable>

        <xsl:result-document href="Output/Code/{$project_name}/{$project_name}.csproj" method="xml" indent="yes">
            <xsl:element name="Project">
                <xsl:attribute name="Sdk">
                    <xsl:text>Microsoft.NET.Sdk</xsl:text>
                </xsl:attribute>
                <xsl:element name ="PropertyGroup">
                    <xsl:element name ="TargetFramework">
                        <xsl:text>net7.0</xsl:text>
                    </xsl:element>
                    <xsl:element name ="ImplicitUsings">
                        <xsl:text>enable</xsl:text>
                    </xsl:element>
                    <xsl:element name ="Nullable">
                        <xsl:text>enable</xsl:text>
                    </xsl:element>
                </xsl:element>
                <xsl:if test="References/Reference[@Type = 'Package']">
                    <xsl:element name ="ItemGroup">
                        <xsl:for-each select="References/Reference">
                            <xsl:if test="@Type = 'Package'">
                                <xsl:element name ="PackageReference">
                                    <xsl:attribute name="Include">
                                        <xsl:value-of select="@Name"/>
                                    </xsl:attribute>
                                        <xsl:attribute name="Version">
                                            <xsl:value-of select="@Version"/>
                                        </xsl:attribute>
                                </xsl:element>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:if>
                <xsl:if test="References/Reference[@Type = 'Project']">
                    <xsl:element name ="ItemGroup">
                        <xsl:for-each select="References/Reference">
                            <xsl:if test="@Type = 'Project'">
                                <xsl:element name ="ProjectReference">
                                    <xsl:attribute name="Include">
                                        <xsl:text>..\</xsl:text>
                                        <xsl:value-of select="@Name"/>
                                        <xsl:text>\</xsl:text>
                                        <xsl:value-of select="@Name"/>
                                        <xsl:text>.csproj</xsl:text>
                                    </xsl:attribute>
                                </xsl:element>
                            </xsl:if> 
                        </xsl:for-each>
                    </xsl:element>
                </xsl:if>
            </xsl:element>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>
