<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" omit-xml-declaration="no" indent="yes" encoding="UTF-8"/>

    <xsl:template name="while">
        <xsl:param name="class_id"/>

        <!-- <xsl:variable name="super_class" select="/.//Class[@Id=/.//Generalization[@To=$class_id]/@From]"/> -->

        <xsl:variable name="super_class_id">
            <xsl:choose>
                <xsl:when test="/.//Generalization[@To=$class_id]">
                    <xsl:value-of select="/.//Class[@Id=/.//Generalization[@To=$class_id]/@From]/@Id"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>NoValue</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <!-- evaluate and recurse -->
        <xsl:choose>
            <xsl:when test="/.//Class[@Id=/.//Generalization[@To=$class_id]/@From]//Stereotype[@Name='Entity']">
                <xsl:text>Entities</xsl:text>
            </xsl:when> 

            <xsl:when test="$super_class_id='NoValue'">
                <xsl:text></xsl:text>
            </xsl:when>
            
            <xsl:otherwise>
                <xsl:call-template name="while">
                    <xsl:with-param name="class_id">
                        <xsl:value-of select="$super_class_id"/>
                    </xsl:with-param>
                </xsl:call-template>            
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
</xsl:stylesheet>
