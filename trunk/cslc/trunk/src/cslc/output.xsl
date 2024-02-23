<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
   <html>
   <body> 
   <h2>Design</h2>
   <table border="1">
   <xsl:for-each select="design/enum">
     <table border="1">
     <tr bgcolor="#e3332f">
       <th align="left" colspan="2">Enum <xsl:value-of select="@name"/></th>
     </tr>
     <xsl:for-each select="item">
     <tr>
       <td><xsl:text> Item </xsl:text></td>
       <xsl:call-template name="item"/>             
     </tr>
     </xsl:for-each>
     </table>
    </xsl:for-each>
    <xsl:for-each select="design/field" >
     <table border="1"  cellpadding="5">
     <tr bgcolor="#5acdff">
       <th align="left" colspan="4">Field <xsl:value-of select="@name"/></th>
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
       <td><xsl:value-of select="@enum | @value | @enumItem"/></td>
     </tr>
     <tr>
     <xsl:call-template name="field"/>
     </tr>
     </table>
     </xsl:for-each>
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
       <td><xsl:value-of select="@enum | @value | @enumItem"/></td>
     </tr>
     <tr>
     <xsl:call-template name="isaField"/>
     </tr>
     </table>
     </xsl:for-each>
     <xsl:for-each select="design/isaElement" >
     <table border="1"  cellpadding="5">
     <tr bgcolor="#facdff">
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
       <td><xsl:value-of select="@enum | @value | @enumItem"/></td>
     </tr>
     <tr>
     <xsl:call-template name="isaField"/>
     </tr>
     </table>
     </xsl:for-each>
     <xsl:for-each select="design/fifo">
     <table border="1">
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
   </xsl:for-each>
   <xsl:for-each select="design/register_file">
   <table border="1">
     <tr bgcolor="#f2cc27">
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
   <xsl:for-each select="design/register">
   <table border="1">
     <tr bgcolor="#f26c27">
       <th align="left" colspan="2">Register <xsl:value-of select="@name"/></th>
     </tr>
     <tr>
       <th align="left">Width</th>
       <td><xsl:value-of select="@width"/></td>
     </tr>
     <tr>  
       <th align="left">Type</th>
       <td><xsl:value-of select="@type"/></td>
    </tr>   
    <tr>   
       <th align="left">Direction</th>
       <td><xsl:value-of select="@direction"/></td>
     </tr>
    <td colspan="2"> <xsl:call-template name="port"/></td>
   </table>
   </xsl:for-each>
   <xsl:for-each select="design/memory">
   <table border="1">
     <tr bgcolor="#e3ee2f">
       <th align="left" colspan="2">Memory <xsl:value-of select="@name"/></th>
     </tr>
     <tr>
       <th align="left">Width</th>
       <td><xsl:value-of select="@width"/></td>
     </tr>
     <tr>  
       <th align="left">Depth</th>
       <td><xsl:value-of select="@depth"/></td>
     </tr>
     <tr><xsl:call-template name="interface"/></tr>
   </table>
   </xsl:for-each>
   <xsl:for-each select="design/unit">  
   <table border="1" >
     <tr bgcolor="#1acdd2">
       <th align="left" colspan="9">Unit <xsl:value-of select="@name"/></th>
     </tr>
     <xsl:call-template name="port"/>
     <tr><xsl:call-template name="interface"/></tr>
     <xsl:call-template name="signal"/>
     <td colspan="9"><xsl:call-template name="signalgroup"/></td>
   </table>
   </xsl:for-each>
   </table>
   </body>
   </html>
</xsl:template>

<xsl:template name="field">
     <xsl:for-each select="field">
     <td colspan="4">
     <table border="1" align="center" cellpadding="5">
     <tr bgcolor="#5acdff">
       <th align="left" colspan="4">Field <xsl:value-of select="@name"/></th>
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
       <td><xsl:value-of select="@enum | @value | @enumItem"/></td>
     </tr>
     <tr>
     <xsl:call-template name="field"/>
     </tr>
     </table>
     </td>
     </xsl:for-each>
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
       <td><xsl:value-of select="@enum | @value | @enumItem"/></td>
     </tr>
     <tr>
     <xsl:call-template name="isaField"/>
     </tr>
     </table>
     </td>
     </xsl:for-each>
</xsl:template>

<xsl:template name="item">
  <td><xsl:value-of select="@name"/></td>
</xsl:template>

<xsl:template name="dim">
<xsl:for-each select="dim">
<xsl:if test="@no &lt;1">
<td><xsl:value-of select="@offset"/></td>
<td><xsl:value-of select="@upper"/></td>
<td><xsl:value-of select="@lower"/></td>
</xsl:if>
</xsl:for-each>
</xsl:template>

<xsl:template name="port">
       <tr bgcolor="#9acd52" colspan="4">
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
         <td><xsl:value-of select="@attr"/></td>
         <td><xsl:value-of select="@noOfDims"/></td>
       </tr>
     </xsl:for-each>
</xsl:template>

<xsl:template name="interface">
<xsl:for-each select="interface">
      <td colspan="9">
       <table border="1" align="center" cellpadding="3">
       <tr bgcolor="#3acd22" >
         <th align="left" colspan="9">Interface <xsl:value-of select="@name"/></th>
       </tr>
       <xsl:call-template name="port"/>
       <tr><xsl:call-template name="interface"/></tr>
       </table>
</td>
</xsl:for-each>
</xsl:template>  

<xsl:template name="signal">
   <xsl:for-each select="signal">
     <tr bgcolor="#ff3277" colspan="4">
       <th align="left">Csl</th>
       <th align="left">Name</th>
       <th align="left">Offset</th>
       <th align="left">Upper</th>
       <th align="left">Lower</th>
       <th align="left">Type</th>
       <th align="left">Attribute</th>
       <th align="left"> NoOfDim</th>
     </tr>
     <tr colspan="4">
         <td><xsl:text> signal </xsl:text></td>
         <td><xsl:value-of select="@name"/></td>
          <xsl:choose>
         <xsl:when test="@noOfDims &gt;0">
            <xsl:call-template name="dim"/>  
         </xsl:when>
         <xsl:otherwise>
         <td><xsl:value-of select="@offset"/></td>
         <td><xsl:value-of select="@upper"/></td>
         <td><xsl:value-of select="@lower"/></td>
                
         </xsl:otherwise>
         </xsl:choose>
         <td><xsl:value-of select="@type"/></td>
         <td><xsl:value-of select="@attr"/></td>
         <td><xsl:value-of select="@noOfDims"/></td>
     </tr>
    </xsl:for-each>
</xsl:template>

<xsl:template name="signalgroup">
<xsl:for-each select="signalgroup">
       <table border="1" >
       <tr bgcolor="#ed33f2" colspan="8">
         <th align="left" colspan="8">Signal_group <xsl:value-of select="@name"/></th>
       </tr>
       <xsl:call-template name="signal"/>
       <xsl:call-template name="signalgroup"/>
</table>
</xsl:for-each>
</xsl:template>  
</xsl:stylesheet>