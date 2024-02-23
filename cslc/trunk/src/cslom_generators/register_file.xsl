<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
   <html>
   <body> 
   <xsl:for-each select="design/register_file">
    <h2><A name="{@name}.xml">5.Register File</A></h2>
   <table border="1" cellpadding="5">
     <tr bgcolor="#fdd017">
       <th align="left" colspan="2">Register_file <xsl:value-of select="@name"/></th>       
     </tr>
     <tr>
       <th align="left">Width</th>
       <td><xsl:value-of select="@width"/></td>
     </tr>
     <tr>  
       <th align="left">Depth</th>
       <td><xsl:value-of select="@depth"/></td>
     </tr>
     <xsl:call-template name="port"/>
   </table>
   </xsl:for-each>
   </body>
   </html>
</xsl:template>

<xsl:template name="port">
<h2>11.1.Ports</h2>
       <tr bgcolor="#4e9258" colspan="4">
       <th align="left">Csl</th>
       <th align="left">Name</th>
       <th align="left">Offset</th>
       <th align="left">Upper</th>
       <th align="left">Lower</th>
       <th align="left">Direction</th>
       <th align="left">Type</th>
       <th align="left">Attribute</th>
       <th align="left"> NoOfDim</th>
       </tr>
     <xsl:for-each select="port">
   
       <tr colspan="4">
         <td><xsl:text> port </xsl:text></td>
         <td><xsl:value-of select="@name"/></td>
         <xsl:choose>
         <xsl:when test="@noOfDims &gt; 1">
          <xsl:call-template name="dim"/>
         </xsl:when>
         <xsl:otherwise>
          <td><xsl:value-of select="@offset"/></td>
          <td><xsl:value-of select="@upper"/></td>
          <td><xsl:value-of select="@lower"/></td>         
         </xsl:otherwise>
         </xsl:choose>
         <td><xsl:value-of select="@direction"/></td>
         <td> <xsl:value-of select="@type"/></td>
         <xsl:choose>
         <xsl:when test="@attr">
         <td><xsl:value-of select="@attr"/></td>
         </xsl:when>
         <xsl:otherwise>
         <td align="center">---</td>
         </xsl:otherwise>
         </xsl:choose>
         <xsl:choose>
         <xsl:when test="@attr">
         <td><xsl:value-of select="@noOfDims"/></td>
         </xsl:when>
         <xsl:otherwise>
         <td align="center">---</td>
         </xsl:otherwise>
         </xsl:choose>
       </tr>
     </xsl:for-each>
</xsl:template>
</xsl:stylesheet>