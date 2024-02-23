<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
   <html>
   <body> 
   <h2><A name="isa.xml">3.Isa </A></h2>
     <h2>3.1.Isa field</h2>
     <xsl:for-each select="design/isaField" >
     <table border="1"  cellpadding="5">
     <tr bgcolor="#9acdff">
       <th align="left" colspan="4">Isa_field <xsl:value-of select="@name"/></th>
     </tr>
     <tr>  
       <th align="left">Offset</th>
       <th align="left">Upper</th>
       <th align="left">Lower</th>
       <th align="left">Enum/Value/Enum Item</th>
     </tr>
     <tr>
       <td><xsl:value-of select="@offset"/></td>
       <td><xsl:value-of select="@upper"/></td>
       <td><xsl:value-of select="@lower"/></td>
       <xsl:choose>
       <xsl:when test="@enum | @value | @enumItem">
       <td><xsl:value-of select="@enum | @value | @enumItem"/></td>
       </xsl:when>
       <xsl:otherwise>
       <td align="center">---</td>
       </xsl:otherwise>
       </xsl:choose>
     </tr>
     <tr>
     <xsl:call-template name="isaField"/>
     </tr>
     </table>
     </xsl:for-each>
     <h2>3.2.Isa Element</h2>     
     <xsl:for-each select="design/isaElement" >
     <table border="1"  cellpadding="5">
     <tr bgcolor="#157dec">
       <th align="left" colspan="4">Isa_element <xsl:value-of select="@name"/></th>
     </tr>
     <tr>  
       <th align="left">Offset</th>
       <th align="left">Upper</th>
       <th align="left">Lower</th>
       <th align="left">Enum/Value/Enum Item</th>
     </tr>
     <tr>
       <td><xsl:value-of select="@offset"/></td>
       <td><xsl:value-of select="@upper"/></td>
       <td><xsl:value-of select="@lower"/></td>
       <xsl:choose>
       <xsl:when test="@enum | @value | @enumItem">
       <td><xsl:value-of select="@enum | @value | @enumItem"/></td>
       </xsl:when>
       <xsl:otherwise>
       <td align="center">---</td>
       </xsl:otherwise>
       </xsl:choose>
     </tr>
     <tr>
     <xsl:call-template name="isaField"/>
     </tr>
     </table>
     </xsl:for-each>
 </body>
   </html>
</xsl:template>

<xsl:template name="isaField">
     <xsl:for-each select="isaField">
     <td colspan="4">
     <table border="1" align="center" cellpadding="5">
     <tr bgcolor="#9acdff">
       <th align="left" colspan="4">Isa_field <xsl:value-of select="@name"/></th>
     </tr>
     <tr>  
       <th align="left">Offset</th>
       <th align="left">Upper</th>
       <th align="left">Lower</th>
       <th align="left">Enum/Value/Enum Item</th>
     </tr>
     <tr>
       <td><xsl:value-of select="@offset"/></td>
       <td><xsl:value-of select="@upper"/></td>
       <td><xsl:value-of select="@lower"/></td>
       <xsl:choose>
       <xsl:when test="@enum | @value | @enumItem">
       <td><xsl:value-of select="@enum | @value | @enumItem"/></td>
       </xsl:when>
       <xsl:otherwise>
       <td align="center">---</td>
       </xsl:otherwise>
       </xsl:choose>
     </tr>
     <tr>
     <xsl:call-template name="isaField"/>
     </tr>
     </table>
     </td>
     </xsl:for-each>
</xsl:template>

</xsl:stylesheet>