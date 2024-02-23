<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
   <html>
   <body> 
   <h1 align="center">Design contents</h1>
   <h2 align="center"><A href="enum.xml">1.Enum</A></h2>
   <h2 align="center"><A href="isa.xml">2.Isa </A></h2>
   <h2 align="center"><A href="isa.xml">2.1.Isa Field</A></h2>
   <h2 align="center"><A href="isa.xml">2.2.Isa Element</A></h2>
   <xsl:for-each select="design/fifo">
      <h2 align="center"><A href="{@name}.xml">3.Fifo <xsl:value-of select="@name"/> </A></h2>
   </xsl:for-each>
   <xsl:for-each select="design/register_file">
      <h2 align="center"><A href="{@name}.xml">4.Register File <xsl:value-of select="@name"/></A></h2>
   </xsl:for-each>
   <xsl:for-each select="design/register">
      <h2 align="center"><A href="{@name}.xml">5.Register <xsl:value-of select="@name"/></A></h2>
   </xsl:for-each>
   <xsl:for-each select="design/memory">
      <h2 align="center"><A href="{@name}.xml">6.Memory <xsl:value-of select="@name"/></A></h2>
   </xsl:for-each>
   <xsl:for-each select="design/testbench">
      <h2 align="center"><A href="{@name}.xml">7.Testbench <xsl:value-of select="@name"/></A></h2>
   </xsl:for-each>
   <xsl:for-each select="design/vector">
      <h2 align="center"><A href="{@name}.xml">7.1.Vector <xsl:value-of select="@name"/></A></h2>
   </xsl:for-each>
   <xsl:for-each select="design/unit">
      <h2 align="center"><A href="{@name}.xml">8.Unit <xsl:value-of select="@name"/></A></h2>
   </xsl:for-each>
  </body>
   </html>
</xsl:template>

</xsl:stylesheet>