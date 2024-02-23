<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
   <html>
   <body> 
   <xsl:for-each select="design/unit">  
    <H2><A name="{@name}.xml">8. Unit</A></H2>
   <table border="1" >
     <tr bgcolor="#9e7bff">
       <th align="left" colspan="9">Unit <xsl:value-of select="@name"/></th>
     </tr>
     <h2>8.1. Ports</h2>
     <xsl:call-template name="port"/>
     <h2>8.2. Interfaces</h2>
     <xsl:call-template name="interface"/>
      <h2>8.3. Signals</h2>
     <xsl:call-template name="signal"/>
     <h2>8.4. Signal Groups</h2>
     <xsl:call-template name="signalgroup"/>
     <h2>8.5 Unit type instances</h2>
     <xsl:call-template name="instantiation"/>
   </table>
   <h2>8.1. Ports</h2>
    <xsl:call-template name="port1"/>
    <h2>8.2. Interfaces</h2>
   <xsl:call-template name="interface1"/>
    <h2>8.3. Signals</h2>
    <xsl:call-template name="signal1"/>
    <h2>8.4. Signal Groups</h2>
   <xsl:call-template name="signalgroup1"/>
   <h2>8.5 Unit type instances</h2>
   <xsl:call-template name="instantiation1"/>
   </xsl:for-each>
   </body>
   </html>
</xsl:template>

<xsl:template name="instantiation">
<xsl:for-each select="instantiation">
  <tr> <a href="#inst{@type}"> Unit type instance <xsl:value-of select="@type"/> </a></tr>
</xsl:for-each>
</xsl:template>

<xsl:template name="instantiation1">
<xsl:for-each select="instantiation">
<a name="inst{@type}"></a>
<table border="1">
<tr bgcolor="#ee927f" colspan="4">
       <th align="left">Instance type</th>
       <th align="left">Instance name</th>
       <th align="left" colspan="2">Formal to actual</th>
</tr>
<tr colspan="4">
       <td><a href="{@type}.xml"><xsl:value-of select="@type"/></a></td>
       <xsl:for-each select="instance">
          <td><xsl:value-of select="@name"/></td>
          <xsl:choose>
          <xsl:when test="f2a">
       <xsl:for-each select="f2a">
          <td >.<xsl:value-of select="@formal"/>(<xsl:value-of select="@actual"/>)</td>
          </xsl:for-each>
           </xsl:when>       
           <xsl:otherwise>
           <td align="center">---</td>
       </xsl:otherwise>
       </xsl:choose>
       </xsl:for-each>
      <xsl:call-template name="instantiation"/>
</tr>
</table>
<xsl:call-template name="instantiation1"/>
</xsl:for-each>
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
       <th align="left">NoOfDim</th>
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
         <xsl:when test="@noOfDims">
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

<xsl:template name="dim">
<xsl:for-each select="dim">
 <xsl:if test="@no &lt;1">
  <td><xsl:value-of select="@offset"/></td>
  <td><xsl:value-of select="@upper"/></td>
  <td><xsl:value-of select="@lower"/></td>
 </xsl:if>
</xsl:for-each>
</xsl:template>

<xsl:template name="interface">
<xsl:for-each select="interface">
   <tr><a href="#interface{@name}">Interface <xsl:value-of select="@name"/></a></tr>
</xsl:for-each>
</xsl:template> 

<xsl:template name="interface1">
<xsl:for-each select="interface">
<tr><a name="interface{@name}"></a></tr>
<tr>
      <td colspan="9">
       <table border="1"  cellpadding="5">
       <tr bgcolor="#348781" >
         <th align="left" colspan="9">Interface <xsl:value-of select="@name"/></th>
       </tr>
       <xsl:call-template name="port"/>
       <xsl:call-template name="interface"/>
       </table>
        <xsl:call-template name="interface1"/>
        <h2>8.1. Ports</h2>
        <xsl:call-template name="port1"/>
</td>
</tr>
</xsl:for-each>
<br></br>
</xsl:template>

<xsl:template name="signal">
    <xsl:for-each select="signal">
     <tr> <a href="#signal{@name}">Signal <xsl:value-of select="@name"/></a></tr>
    </xsl:for-each>
</xsl:template>


<xsl:template name="signal1">
   <xsl:for-each select="signal">
   <a name="signal{@name}"></a>
   <tr>
   <td colspan="4">
   <table border="1"  align="left" cellpadding="5">
     <tr bgcolor="#d16587" colspan="8">
       <th align="left">Signal name</th>
       <th align="left">Offset</th>
       <th align="left">Upper index</th>
       <th align="left">Lower index</th>
       <th align="left">Type</th>
       <th align="left">Attribute</th>
       <th align="left"> NoOfDim</th>
     </tr>
     <tr colspan="4">
         <td><xsl:value-of select="@name"/></td>
          <xsl:choose>
         <xsl:when test="@noOfDims &gt;0">
            <xsl:call-template name="dim"/>  
         </xsl:when>
         <xsl:otherwise>
         <xsl:choose>
         <xsl:when test="@offset &lt;0">
         <td><xsl:value-of select="@offset"/></td>
         <td><xsl:value-of select="@upper"/></td>
         <td><xsl:value-of select="@lower"/></td>
         </xsl:when>
         <xsl:otherwise>
         <td><xsl:value-of select="@offset"/></td>
         <td><xsl:value-of select="@upper"/></td>
         <td><xsl:value-of select="@lower"/></td>
         </xsl:otherwise>
         </xsl:choose>
         </xsl:otherwise>
         </xsl:choose>
         <td><xsl:value-of select="@type"/></td>
         <xsl:choose>
         <xsl:when test="@attr">
         <td><xsl:value-of select="@attr"/></td>
         </xsl:when>
         <xsl:otherwise>
         <td align="center">---</td>
         </xsl:otherwise>
         </xsl:choose>
         <xsl:choose>
         <xsl:when test="@noOfDims">
         <td><xsl:value-of select="@noOfDims"/></td>
         </xsl:when>
         <xsl:otherwise>
         <td align="center">---</td>
         </xsl:otherwise>
         </xsl:choose>
     </tr>
     <xsl:call-template name="field"/>
     </table>
     <br></br>
     </td>
     </tr>
     <br></br>
     <xsl:call-template name="field1"/>
    </xsl:for-each>
</xsl:template>


<xsl:template name="signalgroup">
<xsl:for-each select="signalgroup">
   <a href="#siggr{@name}">Signal group <xsl:value-of select="@name"/></a>
</xsl:for-each>
</xsl:template>  

<xsl:template name="signalgroup1">
<xsl:for-each select="signalgroup">
<a name="siggr{@name}"></a>
<tr>
<td colspan="4">
       <table border="1" cellpadding="5">
       <tr bgcolor="#b93b8f" colspan="4">
         <th align="left" colspan="4">Signal_group <xsl:value-of select="@name"/></th>
       </tr>
       <xsl:call-template name="signal"/>
       <xsl:call-template name="signalgroup"/>

</table>
 <xsl:call-template name="signalgroup1"/>
 <h2>8.3. Signals</h2>
 <xsl:call-template name="signal1"/>
</td>
</tr>
</xsl:for-each>
</xsl:template> 

<xsl:template name="field">
     <xsl:for-each select="field"> 
       <a href="#field">Field</a>
     </xsl:for-each>
</xsl:template>


<xsl:template name="field1">
     <xsl:for-each select="field">      
     <a name="field"></a>
     <h2 align="left">8.3.1. Field</h2>
     <tr>
     <td colspan="8">
     <table border="1"  align="left" cellpadding="5">
     <tr bgcolor="#1569c7">
       <th align="left" colspan="8">Field </th>
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
     <tr><xsl:call-template name="field"/></tr>
     </table>
     <br></br>
     
     </td>
     </tr>
     <tr><xsl:call-template name="field1"/></tr>
     </xsl:for-each>
</xsl:template>

</xsl:stylesheet>