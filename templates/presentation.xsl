<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="yes" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
  
  <!-- Parameters for customization -->
  <xsl:param name="enable-animations" select="'true'"/>
  <xsl:param name="enable-transitions" select="'true'"/>

  <!-- Root template for the presentation content only -->
  <xsl:template match="/">
    <div class="presentation-container">
      <!-- Slides container -->
      <div id="slides-container" class="position-relative h-100">
        <xsl:apply-templates select="presentation/slide"/>
      </div>
      
      <!-- Navigation controls with improved accessibility -->
      <div class="controls position-absolute bottom-0 start-50 translate-middle-x d-flex align-items-center gap-2 mb-4 py-2 px-3 rounded-pill bg-body-tertiary shadow-sm">
        <button id="prev" class="btn btn-primary rounded-circle" aria-label="Previous slide">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-left" viewBox="0 0 16 16">
            <path fill-rule="evenodd" d="M11.354 1.646a.5.5 0 0 1 0 .708L5.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0z"/>
          </svg>
        </button>
        <span id="slide-counter" class="text-body fw-medium mx-2" aria-live="polite">1 / <xsl:value-of select="count(presentation/slide)"/></span>
        <button id="next" class="btn btn-primary rounded-circle" aria-label="Next slide">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-right" viewBox="0 0 16 16">
            <path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
          </svg>
        </button>
        <button id="fullscreen" class="btn btn-outline-secondary rounded-circle ms-2" aria-label="Toggle fullscreen">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-fullscreen" viewBox="0 0 16 16">
            <path d="M1.5 1a.5.5 0 0 0-.5.5v4a.5.5 0 0 1-1 0v-4A1.5 1.5 0 0 1 1.5 0h4a.5.5 0 0 1 0 1h-4zM10 .5a.5.5 0 0 1 .5-.5h4A1.5 1.5 0 0 1 16 1.5v4a.5.5 0 0 1-1 0v-4a.5.5 0 0 0-.5-.5h-4a.5.5 0 0 1-.5-.5zM.5 10a.5.5 0 0 1 .5.5v4a.5.5 0 0 0 .5.5h4a.5.5 0 0 1 0 1h-4A1.5 1.5 0 0 1 0 14.5v-4a.5.5 0 0 1 .5-.5zm15 0a.5.5 0 0 1 .5.5v4a1.5 1.5 0 0 1-1.5 1.5h-4a.5.5 0 0 1 0-1h4a.5.5 0 0 0 .5-.5v-4a.5.5 0 0 1 .5-.5z"/>
          </svg>
        </button>
        <button id="speaker-notes" class="btn btn-outline-secondary rounded-circle" aria-label="Toggle speaker notes">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-sticky" viewBox="0 0 16 16">
            <path d="M2.5 1A1.5 1.5 0 0 0 1 2.5v11A1.5 1.5 0 0 0 2.5 15h6.086a1.5 1.5 0 0 0 1.06-.44l4.915-4.914A1.5 1.5 0 0 0 15 8.586V2.5A1.5 1.5 0 0 0 13.5 1h-11zM2 2.5a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 .5.5V8H9.5A1.5 1.5 0 0 0 8 9.5V14H2.5a.5.5 0 0 1-.5-.5v-11zm7 11.293V9.5a.5.5 0 0 1 .5-.5h4.293L9 13.793z"/>
          </svg>
        </button>
      </div>
      
      <!-- Progress bar -->
      <div class="progress position-absolute bottom-0 start-0 w-100" style="height: 5px;" role="progressbar" aria-label="Presentation progress">
        <div class="progress-bar bg-primary" style="width: 0%"></div>
      </div>
      
      <!-- Speaker notes panel (hidden by default) -->
      <div id="speaker-notes-panel" class="card position-fixed bottom-0 end-0 w-25 h-40 hidden" style="z-index: var(--z-speaker-notes); display: none;">
        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
          <h6 class="m-0">Speaker Notes</h6>
          <button id="close-notes" class="btn-close btn-close-white" aria-label="Close speaker notes"></button>
        </div>
        <div id="current-notes" class="card-body overflow-auto"></div>
      </div>
    </div>
  </xsl:template>
  
  <!-- Template for individual slides with improved attributes -->
  <xsl:template match="slide">
    <!-- Calculate slide classes based on type -->
    <xsl:variable name="slideClasses">
      <xsl:choose>
        <xsl:when test="@type='title'">bg-primary text-white text-center justify-content-center</xsl:when>
        <xsl:when test="@type='section'">bg-secondary text-white text-center justify-content-center</xsl:when>
        <xsl:when test="@type='image'">bg-white</xsl:when>
        <xsl:when test="@type='quote'">bg-light justify-content-center</xsl:when>
        <xsl:when test="@type='chart'">bg-white</xsl:when>
        <xsl:when test="@type='comparison'">bg-white</xsl:when>
        <xsl:when test="@type='timeline'">bg-white</xsl:when>
        <xsl:otherwise>bg-white</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <div>
      <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
      <xsl:attribute name="data-slide-type"><xsl:value-of select="@type"/></xsl:attribute>
      <xsl:attribute name="class">slide position-absolute top-0 start-0 w-100 h-100 p-4 d-flex flex-column opacity-1 <xsl:value-of select="$slideClasses"/></xsl:attribute>
      <xsl:if test="@transition">
        <xsl:attribute name="data-transition"><xsl:value-of select="@transition"/></xsl:attribute>
      </xsl:if>
      <xsl:if test="notes">
        <xsl:attribute name="data-notes"><xsl:value-of select="notes"/></xsl:attribute>
      </xsl:if>
      <xsl:if test="@class">
        <xsl:attribute name="class">slide position-absolute top-0 start-0 w-100 h-100 p-4 d-flex flex-column opacity-1 <xsl:value-of select="$slideClasses"/> <xsl:value-of select="@class"/></xsl:attribute>
      </xsl:if>
      
      <!-- Slide header with appropriate heading level -->
      <header class="mb-4">
        <xsl:choose>
          <xsl:when test="@type='title'">
            <h1 class="display-3 fw-bold mb-3"><xsl:value-of select="title"/></h1>
          </xsl:when>
          <xsl:when test="@type='section'">
            <h1 class="display-4 fw-bold mb-3"><xsl:value-of select="title"/></h1>
          </xsl:when>
          <xsl:otherwise>
            <h2 class="display-6 fw-bold border-bottom border-primary pb-2 mb-3"><xsl:value-of select="title"/></h2>
          </xsl:otherwise>
        </xsl:choose>
      </header>
      
      <!-- Slide content -->
      <div class="slide-content flex-grow-1 overflow-auto">
        <div class="container-fluid px-0">
          <xsl:apply-templates select="content/*"/>
        </div>
      </div>
    </div>
  </xsl:template>
  
  <!-- Content element templates -->
  
  <!-- Paragraphs with class support -->
  <xsl:template match="p">
    <p>
      <xsl:attribute name="class">
        <xsl:text>mb-3 fs-5</xsl:text>
        <xsl:if test="@class"> <xsl:value-of select="@class"/></xsl:if>
      </xsl:attribute>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  
  <!-- Lists with improved class handling -->
  <xsl:template match="list">
    <xsl:choose>
      <xsl:when test="@type='bullet'">
        <ul>
          <xsl:attribute name="class">
            <xsl:text>mb-4 fs-5</xsl:text>
            <xsl:if test="@class"> <xsl:value-of select="@class"/></xsl:if>
          </xsl:attribute>
          <xsl:apply-templates/>
        </ul>
      </xsl:when>
      <xsl:when test="@type='numbered'">
        <ol>
          <xsl:attribute name="class">
            <xsl:text>mb-4 fs-5</xsl:text>
            <xsl:if test="@class"> <xsl:value-of select="@class"/></xsl:if>
          </xsl:attribute>
          <xsl:apply-templates/>
        </ol>
      </xsl:when>
      <xsl:otherwise>
        <ul>
          <xsl:attribute name="class">
            <xsl:text>mb-4 fs-5</xsl:text>
            <xsl:if test="@class"> <xsl:value-of select="@class"/></xsl:if>
          </xsl:attribute>
          <xsl:apply-templates/>
        </ul>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- List items with class support -->
  <xsl:template match="item">
    <li>
      <xsl:attribute name="class">
        <xsl:text>mb-2</xsl:text>
        <xsl:if test="@class"> <xsl:value-of select="@class"/></xsl:if>
      </xsl:attribute>
      <xsl:apply-templates/>
    </li>
  </xsl:template>
  
  <!-- Images with better attribute handling -->
  <xsl:template match="image">
    <figure class="figure text-center my-4">
      <img>
        <xsl:attribute name="src"><xsl:value-of select="@src"/></xsl:attribute>
        <xsl:attribute name="alt"><xsl:value-of select="@alt"/></xsl:attribute>
        <xsl:attribute name="class">
          <xsl:text>figure-img img-fluid rounded shadow-sm</xsl:text>
          <xsl:if test="@class"> <xsl:value-of select="@class"/></xsl:if>
        </xsl:attribute>
        <xsl:if test="@width">
          <xsl:attribute name="style">max-width: <xsl:value-of select="@width"/>;</xsl:attribute>
        </xsl:if>
        <xsl:if test="@height">
          <xsl:attribute name="height"><xsl:value-of select="@height"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="@loading">
          <xsl:attribute name="loading"><xsl:value-of select="@loading"/></xsl:attribute>
        </xsl:if>
      </img>
      <xsl:if test="text()">
        <figcaption class="figure-caption text-center mt-2">
          <xsl:value-of select="text()"/>
        </figcaption>
      </xsl:if>
    </figure>
  </xsl:template>
  
  <!-- Quotes with improved styling -->
  <xsl:template match="quote">
    <blockquote>
      <xsl:attribute name="class">
        <xsl:text>blockquote text-center my-4 px-4</xsl:text>
        <xsl:if test="@class"> <xsl:value-of select="@class"/></xsl:if>
      </xsl:attribute>
      <p class="fs-4 fst-italic"><xsl:value-of select="."/></p>
      <xsl:if test="@author">
        <footer class="blockquote-footer mt-2">
          <xsl:value-of select="@author"/>
        </footer>
      </xsl:if>
    </blockquote>
  </xsl:template>
  
  <!-- Charts with improved data handling -->
  <xsl:template match="chart">
    <div>
      <xsl:attribute name="class">
        <xsl:text>chart-container my-4 p-3 bg-body-tertiary rounded shadow-sm</xsl:text>
        <xsl:if test="@type"> chart-<xsl:value-of select="@type"/></xsl:if>
        <xsl:if test="@class"> <xsl:value-of select="@class"/></xsl:if>
      </xsl:attribute>
      
      <div>
        <xsl:attribute name="class">chart</xsl:attribute>
        <xsl:attribute name="data-chart-type"><xsl:value-of select="@type"/></xsl:attribute>
        <xsl:attribute name="data-chart-data"><xsl:value-of select="data"/></xsl:attribute>
        <xsl:if test="options">
          <xsl:attribute name="data-chart-options"><xsl:value-of select="options"/></xsl:attribute>
        </xsl:if>
        <xsl:attribute name="style">
          <xsl:text>height: </xsl:text>
          <xsl:choose>
            <xsl:when test="@height"><xsl:value-of select="@height"/></xsl:when>
            <xsl:otherwise>400px</xsl:otherwise>
          </xsl:choose>
          <xsl:text>;</xsl:text>
        </xsl:attribute>
        <!-- Canvas will be created by JavaScript -->
      </div>
    </div>
  </xsl:template>
  
  <!-- Code blocks with improved syntax highlighting support -->
  <xsl:template match="code">
    <div class="code-block my-4">
      <pre class="bg-body-tertiary p-3 rounded shadow-sm">
        <code>
          <xsl:if test="@language">
            <xsl:attribute name="class">language-<xsl:value-of select="@language"/></xsl:attribute>
          </xsl:if>
          <xsl:value-of select="."/>
        </code>
      </pre>
    </div>
  </xsl:template>
  
  <!-- Tables with improved accessibility -->
  <xsl:template match="table">
    <div class="table-responsive my-4">
      <table>
        <xsl:attribute name="class">
          <xsl:text>table table-striped table-hover</xsl:text>
          <xsl:if test="@class"> <xsl:value-of select="@class"/></xsl:if>
        </xsl:attribute>
        <xsl:if test="@summary">
          <xsl:attribute name="summary"><xsl:value-of select="@summary"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="header">
          <thead class="table-primary">
            <tr>
              <xsl:for-each select="header/cell">
                <th scope="col"><xsl:apply-templates/></th>
              </xsl:for-each>
            </tr>
          </thead>
        </xsl:if>
        <tbody>
          <xsl:for-each select="row">
            <tr>
              <xsl:for-each select="cell">
                <td><xsl:apply-templates/></td>
              </xsl:for-each>
            </tr>
          </xsl:for-each>
        </tbody>
      </table>
    </div>
  </xsl:template>
  
  <!-- Text formatting elements -->
  <xsl:template match="em">
    <em><xsl:apply-templates/></em>
  </xsl:template>
  
  <xsl:template match="strong">
    <strong><xsl:apply-templates/></strong>
  </xsl:template>
  
  <xsl:template match="a">
    <a>
      <xsl:attribute name="class">
        <xsl:text>link-primary</xsl:text>
        <xsl:if test="@class"> <xsl:value-of select="@class"/></xsl:if>
      </xsl:attribute>
      <xsl:attribute name="href"><xsl:value-of select="@href"/></xsl:attribute>
      <xsl:if test="@target">
        <xsl:attribute name="target"><xsl:value-of select="@target"/></xsl:attribute>
      </xsl:if>
      <xsl:if test="@rel">
        <xsl:attribute name="rel"><xsl:value-of select="@rel"/></xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </a>
  </xsl:template>
  
  <!-- Bootstrap components -->
  
  <!-- Row for grid system -->
  <xsl:template match="row">
    <div>
      <xsl:attribute name="class">
        <xsl:text>row</xsl:text>
        <xsl:if test="@class"> <xsl:value-of select="@class"/></xsl:if>
      </xsl:attribute>
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <!-- Column for grid system -->
  <xsl:template match="col">
    <div>
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when test="@size">col-<xsl:value-of select="@size"/></xsl:when>
          <xsl:otherwise>col</xsl:otherwise>
        </xsl:choose>
        <xsl:if test="@class"> <xsl:value-of select="@class"/></xsl:if>
      </xsl:attribute>
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <!-- Alert component -->
  <xsl:template match="alert">
    <div>
      <xsl:attribute name="class">
        <xsl:text>alert </xsl:text>
        <xsl:choose>
          <xsl:when test="@type">alert-<xsl:value-of select="@type"/></xsl:when>
          <xsl:otherwise>alert-primary</xsl:otherwise>
        </xsl:choose>
        <xsl:if test="@class"> <xsl:value-of select="@class"/></xsl:if>
      </xsl:attribute>
      <xsl:attribute name="role">alert</xsl:attribute>
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <!-- Card component -->
  <xsl:template match="card">
    <div>
      <xsl:attribute name="class">
        <xsl:text>card my-4</xsl:text>
        <xsl:if test="@class"> <xsl:value-of select="@class"/></xsl:if>
      </xsl:attribute>
      <xsl:if test="header">
        <div class="card-header">
          <xsl:apply-templates select="header"/>
        </div>
      </xsl:if>
      <div class="card-body">
        <xsl:apply-templates select="body"/>
      </div>
      <xsl:if test="footer">
        <div class="card-footer">
          <xsl:apply-templates select="footer"/>
        </div>
      </xsl:if>
    </div>
  </xsl:template>
  
  <!-- Badge component -->
  <xsl:template match="badge">
    <span>
      <xsl:attribute name="class">
        <xsl:text>badge </xsl:text>
        <xsl:choose>
          <xsl:when test="@type">bg-<xsl:value-of select="@type"/></xsl:when>
          <xsl:otherwise>bg-primary</xsl:otherwise>
        </xsl:choose>
        <xsl:if test="@class"> <xsl:value-of select="@class"/></xsl:if>
      </xsl:attribute>
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
</xsl:stylesheet>
