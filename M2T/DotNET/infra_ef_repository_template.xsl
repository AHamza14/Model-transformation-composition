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
            <xsl:text>.Repositories</xsl:text>
        </xsl:variable>

        <xsl:variable name="context_name">
            <xsl:value-of select="$projectName" />
            <xsl:text>Context</xsl:text>
        </xsl:variable>

        <xsl:result-document href="Output/Code/{$project_name}/Repositories/EfRepository.cs" method="text">
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using <xsl:value-of select="$projectName" />.SharedKernel.Interfaces;
using <xsl:value-of select="$projectName" />.SharedKernel;
using <xsl:value-of select="$projectName" />.Infrastructure;
using <xsl:value-of select="$projectName" />.Infrastructure.Specifications;

namespace <xsl:value-of select="$class_namespace" />
{
    public class EfRepository&#60;T&#62; : IAsyncRepository&#60;T&#62;, IRepository&#60;T&#62; where T : BaseEntity, IAggregateRoot
    {
        protected readonly <xsl:value-of select="$context_name" /> _<xsl:value-of select="$context_name" />;

        public EfRepository(<xsl:value-of select="$context_name" /><xsl:text> </xsl:text><xsl:value-of select="uFN:first-lower($context_name)" />)
        {
            _<xsl:value-of select="$context_name" /> = <xsl:value-of select="uFN:first-lower($context_name)" />;
        }

        public async Task&#60;T&#62; AddAsync(T entity)
        {
            await _<xsl:value-of select="$context_name" />.Set&#60;T&#62;().AddAsync(entity);
            await _<xsl:value-of select="$context_name" />.SaveChangesAsync();
            return entity;

        }

        public T Add(T entity)
        {
            _<xsl:value-of select="$context_name" />.Set&#60;T&#62;().Add(entity);
            _<xsl:value-of select="$context_name" />.SaveChanges();
            return entity;

        }

        public async Task UpdateAsync(T entity)
        {
            _<xsl:value-of select="$context_name" />.Entry(entity).State = EntityState.Modified;
            await _<xsl:value-of select="$context_name" />.SaveChangesAsync();
        }

        public int Update(T entity)
        {
            _<xsl:value-of select="$context_name" />.Entry(entity).State = EntityState.Modified;
            return _<xsl:value-of select="$context_name" />.SaveChanges();
        }

        public async Task DeleteAsync(T entity)
        {
            _<xsl:value-of select="$context_name" />.Set&#60;T&#62;().Remove(entity);
            await _<xsl:value-of select="$context_name" />.SaveChangesAsync();
        }

        public int Delete(T entity)
        {
            _<xsl:value-of select="$context_name" />.Set&#60;T&#62;().Remove(entity);
            return _<xsl:value-of select="$context_name" />.SaveChanges();
        }

        public async Task&#60;T&#62; GetByIdAsync(int id)
        {
            return await _<xsl:value-of select="$context_name" />.Set&#60;T&#62;().FindAsync(id);
        }

        public T GetById(int id)
        {
            return _<xsl:value-of select="$context_name" />.Set&#60;T&#62;().Find(id);
        }

        public async Task&#60;IReadOnlyList&#60;T&#62;> ListAllAsync()
        {
            return await _<xsl:value-of select="$context_name" />.Set&#60;T&#62;().ToListAsync();
        }

        public IReadOnlyList&#60;T&#62; ListAll()
        {
            return _<xsl:value-of select="$context_name" />.Set&#60;T&#62;().ToList();
        }

        public async Task&#60;IReadOnlyList&#60;T&#62;&#62; ListAsync(ISpecification&#60;T&#62; spec)
        {
            return await ApplySpecification(spec).ToListAsync();
        }

        public IReadOnlyList&#60;T&#62; List(ISpecification&#60;T&#62; spec)
        {
            return ApplySpecification(spec).ToList();
        }


        private IQueryable&#60;T&#62; ApplySpecification(ISpecification&#60;T&#62; spec)
        {
            return SpecificationEvaluator&#60;T&#62;.GetQuery(_<xsl:value-of select="$context_name" />.Set&#60;T&#62;().AsQueryable(), spec);
        }

        public async Task&#60;int&#62; CountAsync(ISpecification&#60;T&#62; spec)
        {
            return await ApplySpecification(spec).CountAsync();
        }

        public int Count(ISpecification&#60;T&#62; spec)
        {
            return ApplySpecification(spec).Count();
        }

    }
}

        </xsl:result-document>

    </xsl:template>


</xsl:stylesheet>
