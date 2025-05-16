<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="yes" />
  
  <!-- Import component templates -->
  <xsl:import href="components/slides.xsl" />
  <xsl:import href="components/layout-components.xsl" />
  <xsl:import href="components/content-components.xsl" />
  <xsl:import href="components/helpers.xsl" />
  
  <!-- Main presentation template -->
  <xsl:template match="presentation">
    <div class="presentation" id="{@id}" data-bs-theme="{@theme}">
      <!-- Navigation controls -->
      <div class="presentation-controls">
        <button class="btn btn-sm btn-primary prev-slide" aria-label="Previous slide">
          <i class="bi bi-chevron-left"></i>
        </button>
        <span class="slide-counter">
          <span class="current-slide">1</span>/<span class="total-slides"><xsl:value-of select="count(slide)" /></span>
        </span>
        <button class="btn btn-sm btn-primary next-slide" aria-label="Next slide">
          <i class="bi bi-chevron-right"></i>
        </button>
      </div>
      
      <!-- Slides container -->
      <div class="slides-container">
        <xsl:apply-templates select="slide" />
      </div>
      
      <!-- Slide navigation dots -->
      <div class="slide-dots">
        <xsl:for-each select="slide">
          <button class="slide-dot" data-slide-index="{position() - 1}" aria-label="Go to slide {position()}">
            <span class="visually-hidden">Slide <xsl:value-of select="position()" /></span>
          </button>
        </xsl:for-each>
      </div>
      
      <!-- Speaker notes panel (hidden by default) -->
      <div class="speaker-notes-panel collapse">
        <div class="card">
          <div class="card-header d-flex justify-content-between align-items-center">
            <h5 class="mb-0">Speaker Notes</h5>
            <button type="button" class="btn-close" aria-label="Close speaker notes"></button>
          </div>
          <div class="card-body speaker-notes-content">
            <!-- Notes will be dynamically inserted here -->
          </div>
        </div>
      </div>
    </div>
    
    <!-- Progress bar -->
    <div class="presentation-progress">
      <div class="progress-bar bg-primary" role="progressbar" style="width: 0%"></div>
    </div>
  </xsl:template>
  
  <!-- Default template for unmatched elements -->
  <xsl:template match="*">
    <xsl:element name="{local-name()}">
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  
  <!-- Default template for text -->
  <xsl:template match="text()">
    <xsl:value-of select="." />
  </xsl:template>
</xsl:stylesheet>
