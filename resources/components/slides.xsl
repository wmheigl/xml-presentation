<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- Common slide template base -->
  <xsl:template match="slide">
    <div id="{@id}" class="slide slide-{@type}" data-slide-index="{position() - 1}">
      <div class="slide-content">
        <!-- Apply specific slide type template -->
        <xsl:apply-templates select="." mode="slide-specific" />
      </div>
      
      <!-- Speaker notes (hidden in presentation) -->
      <xsl:if test="notes">
        <div class="notes d-none">
          <xsl:apply-templates select="notes" />
        </div>
      </xsl:if>
    </div>
  </xsl:template>
  
  <!-- Title slide -->
  <xsl:template match="slide[@type='title']" mode="slide-specific">
    <div class="container h-100 d-flex flex-column justify-content-center">
      <h1 class="display-3 text-center mb-4"><xsl:value-of select="title" /></h1>
      <div class="subtitle text-center mb-5">
        <xsl:apply-templates select="content" />
      </div>
    </div>
  </xsl:template>
  
  <!-- Section slide (introduces a new section) -->
  <xsl:template match="slide[@type='section']" mode="slide-specific">
    <div class="container h-100 d-flex flex-column justify-content-center">
      <h2 class="display-4 text-center mb-3"><xsl:value-of select="title" /></h2>
      <div class="section-content text-center">
        <xsl:apply-templates select="content" />
      </div>
    </div>
  </xsl:template>
  
  <!-- Standard slide -->
  <xsl:template match="slide[@type='standard']" mode="slide-specific">
    <div class="container">
      <h2 class="slide-title mb-4"><xsl:value-of select="title" /></h2>
      <div class="slide-body">
        <xsl:apply-templates select="content" />
      </div>
    </div>
  </xsl:template>
  
  <!-- Image slide -->
  <xsl:template match="slide[@type='image']" mode="slide-specific">
    <xsl:choose>
      <xsl:when test="background-image">
        <!-- Full background image slide -->
        <div class="slide-background" style="background-image: url('{background-image/@src}');">
          <div class="container">
            <h2 class="slide-title mb-4"><xsl:value-of select="title" /></h2>
            <div class="slide-body">
              <xsl:apply-templates select="content" />
            </div>
          </div>
        </div>
      </xsl:when>
      <xsl:otherwise>
        <!-- Regular image slide -->
        <div class="container">
          <h2 class="slide-title mb-4"><xsl:value-of select="title" /></h2>
          <div class="slide-body">
            <div class="row">
              <div class="col-md-6">
                <xsl:apply-templates select="content" />
              </div>
              <div class="col-md-6">
                <xsl:apply-templates select="image" />
              </div>
            </div>
          </div>
        </div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Chart slide -->
  <xsl:template match="slide[@type='chart']" mode="slide-specific">
    <div class="container">
      <h2 class="slide-title mb-4"><xsl:value-of select="title" /></h2>
      <div class="slide-body">
        <div class="row">
          <div class="col-md-5">
            <xsl:apply-templates select="content" />
          </div>
          <div class="col-md-7">
            <div class="chart-container">
              <canvas id="chart-{@id}" width="400" height="300"></canvas>
            </div>
            <xsl:apply-templates select="chart" />
          </div>
        </div>
      </div>
    </div>
  </xsl:template>
  
  <!-- Quote slide -->
  <xsl:template match="slide[@type='quote']" mode="slide-specific">
    <div class="container h-100 d-flex flex-column justify-content-center">
      <div class="quote-content text-center">
        <blockquote class="blockquote">
          <p class="display-4 mb-3"><xsl:value-of select="quote" /></p>
          <footer class="blockquote-footer">
            <xsl:value-of select="attribution" />
            <xsl:if test="source">
              <cite title="{source}"> - <xsl:value-of select="source" /></cite>
            </xsl:if>
          </footer>
        </blockquote>
      </div>
      <div class="additional-content">
        <xsl:apply-templates select="content" />
      </div>
    </div>
  </xsl:template>
  
  <!-- Slide content default template -->
  <xsl:template match="content">
    <div class="content">
      <xsl:apply-templates />
    </div>
  </xsl:template>
  
  <!-- Image template -->
  <xsl:template match="image">
    <img src="{@src}" alt="{@alt}" class="img-fluid">
      <xsl:if test="@width">
        <xsl:attribute name="width"><xsl:value-of select="@width" /></xsl:attribute>
      </xsl:if>
      <xsl:if test="@height">
        <xsl:attribute name="height"><xsl:value-of select="@height" /></xsl:attribute>
      </xsl:if>
    </img>
    <xsl:if test="caption">
      <figcaption class="figure-caption text-center mt-2">
        <xsl:value-of select="caption" />
      </figcaption>
    </xsl:if>
  </xsl:template>
  
  <!-- Chart template with JavaScript initialization -->
  <xsl:template match="chart">
    <xsl:variable name="chartId">chart-<xsl:value-of select="../@id" /></xsl:variable>
    <xsl:variable name="chartType"><xsl:value-of select="@type" /></xsl:variable>
    
    <script>
      document.addEventListener('DOMContentLoaded', function() {
        // Chart initialization code
        const ctx = document.getElementById('<xsl:value-of select="$chartId" />').getContext('2d');
        const chartData = <xsl:value-of select="data" />;
        
        new Chart(ctx, {
          type: '<xsl:value-of select="$chartType" />',
          data: chartData,
          options: {
            responsive: true,
            maintainAspectRatio: false
          }
        });
      });
    </script>
  </xsl:template>
  
  <!-- Speaker notes template -->
  <xsl:template match="notes">
    <div class="speaker-notes">
      <xsl:apply-templates />
    </div>
  </xsl:template>

</xsl:stylesheet>
