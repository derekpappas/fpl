<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
   <html>
   <body> 
   <h2><A name="enum.xml">1.Enum</A></h2>
   <table border="1" cellpadding="3">
    <tr bgcolor="#f88158">
       <th align="left">Enum name </th>
       <th align="left">Enum item </th>
       <th align="left">Item value </th>
     </tr>
   <xsl:for-each select="design/enum">
     <tr rowspan="10">
     <th><xsl:value-of select="@name"/></th>
     <td>
     <xsl:for-each select="item">
     <tr>
       <td><xsl:value-of select="@name"/></td>
     </tr>
     </xsl:for-each>
     </td>
      <td>
     <xsl:for-each select="item">
     <tr>
       <td><xsl:value-of select="@value"/></td>     
     </tr>
     </xsl:for-each>
     </td>
     </tr>
    </xsl:for-each>
    </table>
   </body>
   </html>
</xsl:template>

<xsl:template name="item">
<tr>
  <td align="left"><xsl:value-of select="@name"/></td>
  <td align="left"><xsl:value-of select="@value"/></td>
</tr>
</xsl:template>

</xsl:stylesheet>