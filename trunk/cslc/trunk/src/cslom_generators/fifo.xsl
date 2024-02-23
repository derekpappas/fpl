<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
   <html>
   <body>
     <xsl:for-each select="design/fifo">
     <h2><A name="{@name}.xml">3.Fifo</A></h2>
     <table border="1" cellpadding="5">
     <tr bgcolor="#ff962f">
       <th align="left" colspan="2">Fifo <xsl:value-of select="@name"/></th>
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
     <h2>8.1.Ports</h2>
     <xsl:call-template name="port1"/>
   </xsl:for-each>
  </body>
   </html>
</xsl:template>

<xsl:template name="port">
    <xsl:for-each select="port">
      <tr><a href="#port{@name}"> Port <xsl:value-of select="@name"/></a></tr>
    </xsl:for-each>
</xsl:template>


<xsl:template name="port1">
     <xsl:for-each select="port">   
     <a name="port{@name}"></a>
        <table border="1">
        <tr bgcolor="#4e9258" colspan="4">
       <th align="left">Port name</th>
       <th align="left">Offset</th>
       <th align="left">Upper index</th>
       <th align="left">Lower index</th>
       <th align="left">Direction</th>
       <th align="left">Type</th>
       <th align="left">Attribute</th>
       <th align="left"> NoOfDim</th>
       </tr>     
       <tr colspan="4">
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
       <xsl:call-template name="port"/>  
       </table>
        <xsl:call-template name="port1"/>
     </xsl:for-each>
</xsl:template>

</xsl:stylesheet>