<xsl:stylesheet version="1.0" 
  xmlns:fo="http://www.w3.org/1999/XSL/Format" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:h="http://www.w3.org/1999/xhtml">
  
  <xsl:output method="xml" indent="yes" />

  <xsl:template match="XML">
    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
       <!-- general page layout -->
       <fo:layout-master-set>
          <!-- main page (A4) -->
          <fo:simple-page-master page-height="297mm" page-width="210mm"
             margin="10mm 15mm 10mm 15mm" master-name="main_page">
             <!-- defining page contents  -->
             <fo:region-body margin="10mm 0mm 10mm 0mm" />
          </fo:simple-page-master>
       </fo:layout-master-set>   
       
       <!-- setting pages for main page -->
       <fo:page-sequence master-reference="main_page">
          <!-- creating objects that will appear -->
          <fo:flow flow-name="xsl-region-body">
                <fo:block font-size="10pt" linefeed-treatment="preserve" white-space-collapse="false">
                        <fo:inline font-weight="bold">Table 1.1 </fo:inline>
                        <fo:inline>Categories&#x0A; </fo:inline>
                </fo:block>
                <xsl:apply-templates select="category_list" />
                <fo:block font-size="10pt" linefeed-treatment="preserve" white-space-collapse="false">
                        <fo:inline font-weight="bold">&#x0A; &#x0A; Table 1.2 </fo:inline>
                        <fo:inline>Phases&#x0A; </fo:inline>
                </fo:block>
                <xsl:apply-templates select="phase_list" />
                <fo:block font-size="10pt" linefeed-treatment="preserve" white-space-collapse="false">
                        <fo:inline font-weight="bold">&#x0A; &#x0A; Table 1.3 </fo:inline>
                        <fo:inline>Error/warning type&#x0A; </fo:inline>
                </fo:block>
                <xsl:apply-templates select="type_list" />
                <fo:block font-size="10pt" linefeed-treatment="preserve" white-space-collapse="false">
                        <fo:inline font-weight="bold">&#x0A; &#x0A; Table 1.4 </fo:inline>
                        <fo:inline>List of warning and error messages&#x0A; </fo:inline>
                </fo:block>
                <xsl:apply-templates select="ROWS" />
          </fo:flow>
       </fo:page-sequence>           
         
    </fo:root>
  </xsl:template>

  <!-- template for errors_warnings -->

  <xsl:template match="ROWS">
        <fo:table width="6.13in" text-align="center" table-layout="fixed">
        <fo:table-column column-width="0.26in"/>
        <fo:table-column column-width="0.36in"/>
        <fo:table-column column-width="0.31in"/>
        <fo:table-column column-width="2.4in"/>
        <fo:table-column column-width="0.26in"/>
        <fo:table-column column-width="0.36in"/>
        <fo:table-column column-width="0.36in"/>
        <fo:table-column column-width="0.46in"/>
        <fo:table-column column-width="0.26in"/>
        <fo:table-column column-width="1.1in"/>
        <fo:table-header>
        <fo:table-row>
          <fo:table-cell border="inset 0.1pt black">
            <fo:block font-weight="bold" font-size="7pt">Cat</fo:block>
          </fo:table-cell>
          <fo:table-cell border="inset 0.1pt black">
            <fo:block font-weight="bold" font-size="7pt">Phase</fo:block>
          </fo:table-cell>
          <fo:table-cell border="inset 0.1pt black">
            <fo:block font-weight="bold" font-size="7pt">Type</fo:block>
          </fo:table-cell>
          <fo:table-cell border="inset 0.1pt black">
            <fo:block font-weight="bold" font-size="7pt">Name</fo:block>
          </fo:table-cell>
          <fo:table-cell border="inset 0.1pt black">
            <fo:block font-weight="bold" font-size="7pt">W/E</fo:block>
          </fo:table-cell>
          <fo:table-cell border="inset 0.1pt black">
            <fo:block font-weight="bold" font-size="7pt">V1995</fo:block>
          </fo:table-cell>
          <fo:table-cell border="inset 0.1pt black">
            <fo:block font-weight="bold" font-size="7pt">V2001</fo:block>
          </fo:table-cell>
          <fo:table-cell border="inset 0.1pt black">
            <fo:block font-weight="bold" font-size="7pt">Sys_ver</fo:block>
          </fo:table-cell>
          <fo:table-cell border="inset 0.1pt black">
            <fo:block font-weight="bold" font-size="7pt">Csl</fo:block>
          </fo:table-cell>
          <fo:table-cell border="inset 0.1pt black">
            <fo:block font-weight="bold" font-size="7pt">Desc</fo:block>
          </fo:table-cell>
        </fo:table-row>
     </fo:table-header>
     <fo:table-body>
        <xsl:for-each select="ROW">
        <xsl:sort select="@cat" />
        <xsl:sort select="@phase" />
        <xsl:sort select="@type" />
                <fo:table-row>
        <fo:table-cell border="inset 0.1pt black">
          <fo:block font-size="7pt" >
            <xsl:value-of select="@cat" />
          </fo:block>
        </fo:table-cell>
        <fo:table-cell border="inset 0.1pt black">
          <fo:block font-size="7pt" >
             <xsl:value-of select="@phase" />
          </fo:block>
        </fo:table-cell>
        <fo:table-cell border="inset 0.1pt black">
          <fo:block font-size="7pt" >
             <xsl:value-of select="@type" />
          </fo:block>
        </fo:table-cell>
        <fo:table-cell border="inset 0.1pt black">
          <fo:block font-size="7pt" >
             <xsl:value-of select="@name" />
          </fo:block>
        </fo:table-cell>
        <fo:table-cell border="inset 0.1pt black">
          <fo:block font-size="7pt" >
             <xsl:value-of select="@we" />
          </fo:block>
        </fo:table-cell>
        <fo:table-cell border="inset 0.1pt black">
          <fo:block font-size="7pt" >
             <xsl:value-of select="@v1995" />
          </fo:block>
        </fo:table-cell>
        <fo:table-cell border="inset 0.1pt black">
          <fo:block font-size="7pt" >
             <xsl:value-of select="@v2001" />
          </fo:block>
        </fo:table-cell>
        <fo:table-cell border="inset 0.1pt black">
          <fo:block font-size="7pt" >
             <xsl:value-of select="@sys_ver" />
          </fo:block>
        </fo:table-cell>
        <fo:table-cell border="inset 0.1pt black">
          <fo:block font-size="7pt" >
             <xsl:value-of select="@csl" />
          </fo:block>
        </fo:table-cell>
        <fo:table-cell border="inset 0.1pt black">
          <fo:block font-size="7pt" >
             <xsl:value-of select="@desc" />
          </fo:block>
        </fo:table-cell>
       </fo:table-row>
           
        </xsl:for-each>
     </fo:table-body>
     </fo:table>
  </xsl:template>


  <!-- template for phase_list -->

  <xsl:template match="phase_list">
        <fo:table width="3in" text-align="center" table-layout="fixed">
        <fo:table-column column-width="0.25in"/>
        <fo:table-column column-width="0.32in"/>
        <fo:table-column column-width="0.7in"/>
        <fo:table-header>
        <fo:table-row>
          <fo:table-cell border="inset 0.1pt black">
            <fo:block font-weight="bold" font-size="7pt">number</fo:block>
          </fo:table-cell>
          <fo:table-cell border="inset 0.1pt black">
            <fo:block font-weight="bold" font-size="7pt">mnemonic</fo:block>
          </fo:table-cell>
          <fo:table-cell border="inset 0.1pt black">
            <fo:block font-weight="bold" font-size="7pt">Csl compiler category</fo:block>
          </fo:table-cell>
        </fo:table-row>
     </fo:table-header>
     <fo:table-body>
        <xsl:for-each select="phases">
        <xsl:sort select="@ph"/>
                  <fo:table-row>
        <fo:table-cell border="inset 0.1pt black">
          <fo:block font-size="7pt"  font-weight="normal">
             <xsl:value-of select="position()" />
          </fo:block>
        </fo:table-cell>
        <fo:table-cell border="inset 0.1pt black">
          <fo:block font-size="7pt" >
             <xsl:value-of select="@ph" />
          </fo:block>
        </fo:table-cell>
        <fo:table-cell border="inset 0.1pt black">
          <fo:block font-size="7pt" >
             <xsl:value-of select="@desc" />
          </fo:block>
        </fo:table-cell>
       </fo:table-row>
        </xsl:for-each>
     </fo:table-body>
     </fo:table>
  </xsl:template>

  <!-- template for type_list -->

  <xsl:template match="type_list">
        <fo:table width="3in" text-align="center" table-layout="fixed">
        <fo:table-column column-width="0.25in"/>
        <fo:table-column column-width="0.32in"/>
        <fo:table-column column-width="0.7in"/>
        <fo:table-header>
        <fo:table-row>
          <fo:table-cell border="inset 0.1pt black">
            <fo:block font-weight="bold" font-size="7pt">number</fo:block>
          </fo:table-cell>
          <fo:table-cell border="inset 0.1pt black">
            <fo:block font-weight="bold" font-size="7pt">mnemonic</fo:block>
          </fo:table-cell>
          <fo:table-cell border="inset 0.1pt black">
            <fo:block font-weight="bold" font-size="7pt">error/warning type</fo:block>
          </fo:table-cell>
        </fo:table-row>
     </fo:table-header>
     <fo:table-body>
        <xsl:for-each select="types">
        <xsl:sort select="@type"/>
          <fo:table-row>
        <fo:table-cell border="inset 0.1pt black">
          <fo:block font-size="7pt"  font-weight="normal">
             <xsl:value-of select="position()" />
          </fo:block>
        </fo:table-cell>
        <fo:table-cell border="inset 0.1pt black">
          <fo:block font-size="7pt" >
             <xsl:value-of select="@type" />
          </fo:block>
        </fo:table-cell>
        <fo:table-cell border="inset 0.1pt black">
          <fo:block font-size="7pt" >
             <xsl:value-of select="@desc" />
          </fo:block>
        </fo:table-cell>
       </fo:table-row>        
        </xsl:for-each>
     </fo:table-body>
     </fo:table>
  </xsl:template>
  
  <!-- template for category_list -->

  <xsl:template match="category_list">
        <fo:table width="3in" text-align="center" table-layout="fixed">
        <fo:table-column column-width="0.25in"/>
        <fo:table-column column-width="0.32in"/>
        <fo:table-column column-width="0.7in"/>
        <fo:table-header>
        <fo:table-row>
          <fo:table-cell border="inset 0.1pt black">
            <fo:block font-weight="bold" font-size="7pt">number</fo:block>
          </fo:table-cell>
          <fo:table-cell border="inset 0.1pt black">
            <fo:block font-weight="bold" font-size="7pt">mnemonic</fo:block>
          </fo:table-cell>
          <fo:table-cell border="inset 0.1pt black">
            <fo:block font-weight="bold" font-size="7pt">Phase description</fo:block>
          </fo:table-cell>
        </fo:table-row>
     </fo:table-header>
     <fo:table-body>
        <xsl:for-each select="categories">
        <xsl:sort select="@cat"/>
            <fo:table-row>
        <fo:table-cell border="inset 0.1pt black">
          <fo:block font-size="7pt"  font-weight="normal">
             <xsl:value-of select="position()" />
          </fo:block>
        </fo:table-cell>
        <fo:table-cell border="inset 0.1pt black">
          <fo:block font-size="7pt" >
             <xsl:value-of select="@cat" />
          </fo:block>
        </fo:table-cell>
        <fo:table-cell border="inset 0.1pt black">
          <fo:block font-size="7pt" >
             <xsl:value-of select="@desc" />
          </fo:block>
        </fo:table-cell>
       </fo:table-row> 
        </xsl:for-each>
     </fo:table-body>
     </fo:table>
  </xsl:template>
 
</xsl:stylesheet>
