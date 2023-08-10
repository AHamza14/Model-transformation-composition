<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" xmlns:uFN="uFN">
    <xsl:import href="../../utilFunctions.xsl"/>

    <xsl:template match="Project">
        <xsl:variable name="project_name">
            <xsl:value-of select="$projectName" />
            <xsl:text>.Core</xsl:text>
        </xsl:variable>

        <xsl:result-document href="Output/Code/{$project_name}/Util.cs" method="text">
using System;
using System.Collections.Generic;
using System.Data;

//Steve Gagné 2007-11-01

//Cette classe contient des procédures et fonctions qui peuvent être utilisées n'importe où.
//Le seul but de cette classe est de centraliser et d'économiser le code.
public static class Util
{

    #region Conversion

    public static int StringToInt(string psString)
    {
        if (isNULL(psString))
            return int.MinValue;
        if (psString.Length == 0)
            return int.MinValue;
        try
        {
            int liTemp = int.Parse(psString);

            return liTemp;
        }
        catch
        {
            return int.MinValue;
        }
    }
    
    #endregion
    
    #region TraitementChaine
    
    public static string RemoveDoubleSpaces(string psString)
    {
        string lsTemp = "";

        psString = psString.Trim();
        while (lsTemp != psString)
        {
            lsTemp = psString;
            psString = psString.Replace("  ", " ");
        }
        return psString;
    }
    
    public static string FillLenghtString(string psStringToBeFilled, int piLenght, bool pbFromStart, char pcFillingChar)
    {
        int liLenght = psStringToBeFilled.Length;

        while (piLenght &#62; liLenght)
        {
            if (pbFromStart)
                psStringToBeFilled = pcFillingChar + psStringToBeFilled;
            else
                psStringToBeFilled += pcFillingChar;
            liLenght += 1;
        }
        return psStringToBeFilled;
    }
    
    public static string ZeroFill(int piNumber, int piQtyOfZero)
    {
        return ZeroFill(piNumber.ToString(), piQtyOfZero);
    }
    
    public static string ZeroFill(string psToBeFilled, int piQtyOfZero)
    {
        if (isNULL(psToBeFilled))
            return null;
        while (psToBeFilled.Length &#60; piQtyOfZero)
            psToBeFilled = "0" + psToBeFilled;
        return psToBeFilled;
    }
    
    #endregion
    
    #region Validation

    public static bool isNULL(object pNullableObj)
    {
        return (pNullableObj == null);
    }

    public static bool isValidGuid(string psGuid)
    {
        if (isNULL(psGuid))
            return false;
        if (psGuid == "")
            return false;
        try
        {
            Guid lGuid = new Guid(psGuid);
            return true;
        }
        catch
        {
            return false;
        }
    }
    
    public static bool isCharAlphaNum(char pcChar)
    {
        if (isNULL(pcChar))
            return false;

        int liChar = Convert.ToInt32(pcChar);

        //48..57        = 0..9
        //65..90        = A..Z
        //97..122       = a..z
        //128..154      = ÇüéâäàåçêëèïîìÄÅÉæÆôöòûùÿÖÜ
        //160..165      = áíóúñÑ
        //181..183      = ÁÂÀ
        //198           = ã
        //199           = Ã
        //210..212      = ÊËÈ
        //214..216      = ÍÎÏ
        //222           = Ì
        //224           = Ó
        //226..229      = ÔÒõÕ
        //233..237      = ÚÛÙýÝ
        return ((liChar &#62;= 48 &#38;&#38; liChar &#60;= 57) || (liChar &#62;= 65 &#38;&#38; liChar &#60;= 90) || (liChar &#62;= 97 &#38;&#38; liChar &#60;= 122) ||
                (liChar &#62;= 128 &#38;&#38; liChar &#60;= 154) || (liChar &#62;= 160 &#38;&#38; liChar &#60;= 165) || (liChar &#62;= 181 &#38;&#38; liChar &#60;= 183) ||
                (liChar == 198) || (liChar == 199) || (liChar &#62;= 210 &#38;&#38; liChar &#60;= 212) ||
                (liChar &#62;= 214 &#38;&#38; liChar &#60;= 216) || (liChar == 222) || (liChar == 224) ||
                (liChar &#62;= 226 &#38;&#38; liChar &#60;= 229) || (liChar &#62;= 233 &#38;&#38; liChar &#60;= 237));
    }

    #endregion
}
        </xsl:result-document>

    </xsl:template>


</xsl:stylesheet>
