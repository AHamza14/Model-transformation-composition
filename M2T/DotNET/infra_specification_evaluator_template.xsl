<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" xmlns:uFN="uFN">
    <xsl:import href="../../utilFunctions.xsl"/>

    <xsl:template match="Project">
        <xsl:variable name="project_name">
            <xsl:value-of select="$projectName" />
            <xsl:text>.Infrastructure</xsl:text>
        </xsl:variable>

        <xsl:variable name="class_namespace">
            <xsl:value-of select="$project_name" />
            <xsl:text>.Specifications</xsl:text>
        </xsl:variable>

        <xsl:result-document href="Output/Code/{$project_name}/Specifications/SpecificationEvaluator.cs" method="text">
using System.Linq;
using Microsoft.EntityFrameworkCore;
using <xsl:value-of select="$projectName" />.SharedKernel;
using <xsl:value-of select="$projectName" />.Core;
using <xsl:value-of select="$projectName" />.SharedKernel.Interfaces;

namespace <xsl:value-of select="$class_namespace" />
{
    public class SpecificationEvaluator&#60;T&#62; where T : BaseEntity
    {
        public static IQueryable&#60;T&#62; GetQuery(IQueryable&#60;T&#62; inputQuery, ISpecification&#60;T&#62; specification)
        {
            var query = inputQuery;

            // modify the IQueryable using the specification's criteria expression
            if (specification.Criteria != null)
            {
                query = query.Where(specification.Criteria);
            }

            // Includes all expression-based includes
            query = specification.Includes.Aggregate(query,
                                    (current, include) => current.Include(include));

            // Include any string-based include statements
            query = specification.IncludeStrings.Aggregate(query,
                                    (current, include) => current.Include(include));

            // Apply ordering if expressions are set
            if (specification.OrderBy != null)
            {
                query = query.OrderBy(specification.OrderBy);
            }
            else if (specification.OrderByDescending != null)
            {
                query = query.OrderByDescending(specification.OrderByDescending);
            }

            if (specification.GroupBy != null)
            {
                query = query.GroupBy(specification.GroupBy).SelectMany(x => x);
            }

            // Apply paging if enabled
            if (specification.IsPagingEnabled)
            {
                query = query.Skip(specification.Skip)
                                .Take(specification.Take);
            }
            return query;
        }
    }
}       
        </xsl:result-document>

    </xsl:template>


</xsl:stylesheet>
