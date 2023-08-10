<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" xmlns:uFN="uFN">

    <xsl:import href="../../utilFunctions.xsl"/>

    <xsl:output method="xml" omit-xml-declaration="no" indent="yes" encoding="UTF-8"/>

    <xsl:include href="../SITs/Observer design pattern/subject_template.xsl"/>
    <xsl:include href="../SITs/Observer design pattern/subject_interface_template.xsl"/>
    <xsl:include href="../SITs/Observer design pattern/observer_template.xsl"/>
    <xsl:include href="../SITs/Observer design pattern/observer_interface_template.xsl"/>
    <xsl:include href="../SITs/Clean architecture/entity_template.xsl"/>
    <xsl:include href="../SITs/Clean architecture/aggregate_root_template.xsl"/>
    <xsl:include href="../SITs/Clean architecture/repository_interfaces_template.xsl"/>
    <xsl:include href="../SITs/Clean architecture/repository_classes_template.xsl"/>
    <xsl:include href="../SITs/Clean architecture/specification_template.xsl"/>
    <xsl:include href="../SITs/Clean architecture/service_interfaces_template.xsl"/>
    <xsl:include href="../SITs/Clean architecture/service_classes_template.xsl"/>
    <xsl:include href="../SITs/Clean architecture/all_classes_template.xsl"/>
    <xsl:include href="../SITs/Clean architecture/not_mapped_classes_template.xsl"/>
    <xsl:include href="../SITs/Clean architecture/enumerations_template.xsl"/>
   
    <xsl:include href="../SITs/Entity framework/ef_context_template.xsl"/>


    <xsl:include href="../../Generic-transformations/attribute_template.xsl"/>
    <xsl:include href="../../Generic-transformations/operation_template.xsl"/>
    <xsl:include href="../../Generic-transformations/class_template.xsl"/>
    <xsl:include href="../../Generic-transformations/interface_template.xsl"/>
    <xsl:include href="../../Generic-transformations/parameter_template.xsl"/>
    <xsl:include href="../../Generic-transformations/implement_template.xsl"/>
    <xsl:include href="../../Generic-transformations/extend_template.xsl"/>
    <xsl:include href="../../Generic-transformations/import_template.xsl"/>
    <xsl:include href="../../Generic-transformations/annotation_template.xsl"/>
    <xsl:include href="../../Generic-transformations/enum_literal_template.xsl"/>
    <xsl:include href="../../Generic-transformations/enumeration_template.xsl"/>
    <xsl:include href="../../Generic-transformations/constructor_template.xsl"/>
    <xsl:include href="../../Generic-transformations/parent_member_template.xsl"/>


    <xsl:template match="Project">

        <!-- Observer desing pattern transformations -->

        <xsl:variable name="subject_classes">
            <xsl:element name="Classes">
                <xsl:apply-templates mode="subject_template" select="node()">
                    <xsl:with-param name="container_project">
                        <xsl:value-of select="$projectName" />
                        <xsl:text>.Core</xsl:text>
                    </xsl:with-param>
                </xsl:apply-templates>
            </xsl:element>
        </xsl:variable>
        
        <xsl:variable name="subject_interface">
            <xsl:element name="Interfaces">
                <xsl:call-template name="subject_interface_template">
                    <xsl:with-param name="container_project">
                        <xsl:value-of select="$projectName" />
                        <xsl:text>.Core</xsl:text>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:element>
        </xsl:variable>

        <xsl:variable name="observer_classes">
            <xsl:element name="Classes">
                <xsl:apply-templates mode="observer_template" select="node()">
                    <xsl:with-param name="container_project">
                        <xsl:value-of select="$projectName" />
                        <xsl:text>.Core</xsl:text>
                    </xsl:with-param>
                </xsl:apply-templates>
            </xsl:element>
        </xsl:variable>

        <xsl:variable name="observer_interface">
            <xsl:element name="Interfaces">
                <xsl:call-template name="observer_interface_template">
                    <xsl:with-param name="container_project">
                        <xsl:value-of select="$projectName" />
                        <xsl:text>.Core</xsl:text>
                    </xsl:with-param>
                </xsl:call-template>   
            </xsl:element>
        </xsl:variable>

        <!-- Clean architecture transformations -->

        <xsl:variable name="entity_classes">
            <xsl:element name="Classes">
                <xsl:apply-templates mode="entity_template" select="node()" />
            </xsl:element>
        </xsl:variable>

        <xsl:variable name="aggregate_root_classes">
            <xsl:element name="Classes">
                <xsl:apply-templates mode="aggregate_root_template" select="node()" />
            </xsl:element>
        </xsl:variable>

        <xsl:variable name="repository_interfaces">
            <xsl:element name="Interfaces">
                <xsl:apply-templates mode="repository_interfaces_template" select="node()" />
            </xsl:element>
        </xsl:variable>

        <xsl:variable name="repository_classes">
            <xsl:element name="Classes">
                <xsl:apply-templates mode="repository_classes_template" select="node()" />
            </xsl:element>
        </xsl:variable>

        <xsl:variable name="specification_classes">
            <xsl:element name="Classes">
                <xsl:apply-templates mode="specification_template" select="node()" />
            </xsl:element>
        </xsl:variable>

        <xsl:variable name="service_interfaces">
            <xsl:element name="Interfaces">
                <xsl:apply-templates mode="service_interfaces_template" select="node()" />
            </xsl:element>
        </xsl:variable>

        <xsl:variable name="service_classes">
            <xsl:element name="Classes">
                <xsl:apply-templates mode="service_classes_template" select="node()" />
            </xsl:element>
        </xsl:variable>
        
        <xsl:variable name="all_classes">
            <xsl:element name="Classes">
                <xsl:apply-templates mode="all_classes_template" select="node()" />
            </xsl:element>
        </xsl:variable>

        <xsl:variable name="not_mapped_classes">
            <xsl:element name="Classes">
                <xsl:apply-templates mode="not_mapped_classes_template" select="node()" />
            </xsl:element>
        </xsl:variable>

        <xsl:variable name="enumeration_classes">
            <xsl:element name="Enumerations">
                <xsl:apply-templates mode="enumerations_template" select="node()" />
            </xsl:element>
        </xsl:variable>

        <xsl:variable name="project_files">
            <xsl:element name="Projects">
                <xsl:apply-templates mode="core_project_template" select="node()" />
                <xsl:apply-templates mode="infra_project_template" select="node()" />
            </xsl:element>
        </xsl:variable>

        <xsl:variable name="ef_context_classes">
            <xsl:element name="Classes">
                <xsl:apply-templates mode="ef_context_template" select="node()" />
            </xsl:element>
        </xsl:variable>

        <!-- <xsl:variable name="context_classes">
            <xsl:element name="Classes">
                <xsl:apply-templates mode="repo_context_template" select="node()" />
            </xsl:element>
        </xsl:variable> -->

        <!-- <xsl:variable name="ef_context_classes">
            <xsl:element name="Classes">
                <xsl:apply-templates mode="ef_context_template" select="node()" />
            </xsl:element>
        </xsl:variable> -->

        <!-- For testing Operations-->
        <xsl:result-document href="Output/Models/subject_classes.xml">
		    <xsl:copy-of select="exsl:node-set($subject_classes)/node()"/>
        </xsl:result-document>
        <!-- End Testing Operations -->

         <!-- For testing Operations-->
        <xsl:result-document href="Output/Models/subject_interface.xml">
		    <xsl:copy-of select="exsl:node-set($subject_interface)/node()"/>
        </xsl:result-document>
        <!-- End Testing Operations -->

        <!-- For testing Operations-->
        <xsl:result-document href="Output/Models/observer_classes.xml">
		    <xsl:copy-of select="exsl:node-set($observer_classes)/node()"/>
        </xsl:result-document>
        <!-- End Testing Operations -->

         <!-- For testing Operations-->
        <xsl:result-document href="Output/Models/observer_interface.xml">
		    <xsl:copy-of select="exsl:node-set($observer_interface)/node()"/>
        </xsl:result-document>
        <!-- End Testing Operations -->

        <!-- For testing Operations-->
        <xsl:result-document href="Output/Models/entity_classes.xml">
		    <xsl:copy-of select="exsl:node-set($entity_classes)/node()"/>
        </xsl:result-document>
        <!-- End Testing Operations -->

        <!-- For testing Operations-->
        <xsl:result-document href="Output/Models/aggregate_root_classes.xml">
		    <xsl:copy-of select="exsl:node-set($aggregate_root_classes)/node()"/>
        </xsl:result-document>
        <!-- End Testing Operations -->

        <!-- For testing Operations-->
        <xsl:result-document href="Output/Models/repository_interfaces.xml">
            <xsl:copy-of select="exsl:node-set($repository_interfaces)/node()"/>
        </xsl:result-document>
        <!-- End Testing Operations -->

        <!-- For testing Operations-->
        <xsl:result-document href="Output/Models/repository_classes.xml">
            <xsl:copy-of select="exsl:node-set($repository_classes)/node()"/>
        </xsl:result-document>
        <!-- End Testing Operations -->

         <!-- For testing Operations-->
         <xsl:result-document href="Output/Models/specification_classes.xml">
         <xsl:copy-of select="exsl:node-set($specification_classes)/node()"/>
     </xsl:result-document>
     <!-- End Testing Operations -->

        <!-- For testing Operations-->
        <xsl:result-document href="Output/Models/service_interfaces.xml">
            <xsl:copy-of select="exsl:node-set($service_interfaces)/node()"/>
        </xsl:result-document>
        <!-- End Testing Operations -->

        <!-- For testing Operations-->
        <xsl:result-document href="Output/Models/service_classes.xml">
            <xsl:copy-of select="exsl:node-set($service_classes)/node()"/>
        </xsl:result-document>
        <!-- End Testing Operations -->


        <!-- For testing Operations-->
        <xsl:result-document href="Output/Models/all_classes.xml">
		    <xsl:copy-of select="exsl:node-set($all_classes)/node()"/>
        </xsl:result-document>
        <!-- End Testing Operations -->

        <!-- For testing Operations-->
        <xsl:result-document href="Output/Models/not_mapped_classes.xml">
		    <xsl:copy-of select="exsl:node-set($not_mapped_classes)/node()"/>
        </xsl:result-document>
        <!-- End Testing Operations -->

        <!-- For testing Operations-->
        <xsl:result-document href="Output/Models/enumerations.xml">
		    <xsl:copy-of select="exsl:node-set($enumeration_classes)/node()"/>
        </xsl:result-document>
        <!-- End Testing Operations -->

        <!-- For testing Operations-->
        <xsl:result-document href="Output/Models/clean_architecture_projects.xml">
            <xsl:copy-of select="exsl:node-set($project_files)/node()"/>
        </xsl:result-document>
        <!-- End Testing Operations -->

        <!-- For testing Operations-->
        <xsl:result-document href="Output/Models/ef_context_classes.xml">
            <xsl:copy-of select="exsl:node-set($ef_context_classes)/node()"/>
        </xsl:result-document>
        <!-- End Testing Operations -->

         <!-- For testing Operations-->
        <!-- <xsl:result-document href="Output/Models/context_classes.xml">
            <xsl:copy-of select="exsl:node-set($context_classes)/node()"/>
        </xsl:result-document> -->
        <!-- End Testing Operations -->
        <!-- For testing Operations-->
        <!-- <xsl:result-document href="Output/Models/ef_context_classes.xml">
            <xsl:copy-of select="exsl:node-set($ef_context_classes)/node()"/>
        </xsl:result-document> -->
        <!-- End Testing Operations -->
    </xsl:template>

</xsl:stylesheet>