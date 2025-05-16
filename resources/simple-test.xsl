<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="yes" />
  
  <!-- Main presentation template -->
  <xsl:template match="presentation">
    <div class="presentation" id="{@id}" data-bs-theme="{@theme}">
      <h1>Simple Test - No Imports</h1>
      
      <!-- Slides container -->
      <div class="slides-container">
        <xsl:for-each select="slide">
          <div class="slide">
            <h2><xsl:value-of select="title"/></h2>
            <div class="content">
              <xsl:copy-of select="content/*"/>
            </div>
          </div>
        </xsl:for-each>
      </div>
    </div>
  </xsl:template>
</xsl:stylesheet>
