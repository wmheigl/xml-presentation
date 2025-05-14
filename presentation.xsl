<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="yes" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
  
  <!-- Root template for the entire presentation -->
  <xsl:template match="/">
    <html lang="en">
      <xsl:if test="presentation/@theme">
        <xsl:attribute name="data-bs-theme">
          <xsl:value-of select="presentation/@theme"/>
        </xsl:attribute>
      </xsl:if>
      <head>
        <title><xsl:value-of select="presentation/metadata/title"/></title>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <!-- Custom presentation CSS -->
        <link rel="stylesheet" href="presentation-custom.css"/>
        <style>
          <xsl:call-template name="generate-dynamic-styles"/>
        </style>
      </head>
      <body>
        <div class="presentation-container">
          <!-- Slides container -->
          <div id="slides-container" class="position-relative h-100">
            <xsl:apply-templates select="presentation/slide"/>
          </div>
          
          <!-- Navigation controls -->
          <div class="controls position-absolute bottom-0 start-50 translate-middle-x d-flex align-items-center gap-2 mb-4 py-2 px-3 rounded-pill bg-body-tertiary shadow-sm">
            <button id="prev" class="btn btn-primary rounded-circle" aria-label="Previous slide">
              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-left" viewBox="0 0 16 16">
                <path fill-rule="evenodd" d="M11.354 1.646a.5.5 0 0 1 0 .708L5.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0z"/>
              </svg>
            </button>
            <span id="slide-counter" class="text-body fw-medium mx-2">1 / <xsl:value-of select="count(presentation/slide)"/></span>
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
          <div class="progress position-absolute bottom-0 start-0 w-100" style="height: 4px; z-index: 10;">
            <div class="progress-bar bg-primary" role="progressbar" style="width: 0%"></div>
          </div>
          
          <!-- Speaker notes panel (hidden by default) -->
          <div id="speaker-notes-panel" class="card position-fixed bottom-0 end-0 w-25 h-40 hidden" style="z-index: 20; display: none;">
            <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
              <h6 class="m-0">Speaker Notes</h6>
              <button id="close-notes" class="btn-close btn-close-white" aria-label="Close"></button>
            </div>
            <div id="current-notes" class="card-body overflow-auto"></div>
          </div>
        </div>
        
        <!-- Bootstrap Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="presentation.js"></script>
      </body>
    </html>
  </xsl:template>
  
  <!-- Template for dynamic CSS based on brand colors -->
  <xsl:template name="generate-dynamic-styles">
    <xsl:if test="presentation/metadata/brand">
      :root {
        <xsl:for-each select="presentation/metadata/brand/color">
          <xsl:choose>
            <xsl:when test="@name='primary'">--bs-primary: <xsl:value-of select="."/>;</xsl:when>
            <xsl:when test="@name='secondary'">--bs-secondary: <xsl:value-of select="."/>;</xsl:when>
            <xsl:when test="@name='accent'">--bs-info: <xsl:value-of select="."/>;</xsl:when>
            <xsl:when test="@name='text'">--bs-body-color: <xsl:value-of select="."/>;</xsl:when>
            <xsl:when test="@name='background'">--bs-body-bg: <xsl:value-of select="."/>;</xsl:when>
          </xsl:choose>
        </xsl:for-each>
      }
    </xsl:if>
  </xsl:template>
  
  <!-- Template for individual slides -->
  <xsl:template match="slide">
    <div class="slide position-absolute top-0 start-0 w-100 h-100 p-4 d-flex flex-column">
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:attribute name="data-slide-type">
        <xsl:value-of select="@type"/>
      </xsl:attribute>
      <xsl:if test="@transition">
        <xsl:attribute name="data-transition">
          <xsl:value-of select="@transition"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="notes">
        <xsl:attribute name="data-notes">
          <xsl:value-of select="notes"/>
        </xsl:attribute>
      </xsl:if>
      
      <!-- Apply specific Bootstrap classes based on slide type -->
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
      
      <xsl:attribute name="class">
        <xsl:text>slide position-absolute top-0 start-0 w-100 h-100 p-4 d-flex flex-column opacity-1 </xsl:text>
        <xsl:value-of select="$slideClasses"/>
      </xsl:attribute>
      
      <!-- Slide header -->
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
  
  <!-- Paragraphs -->
  <xsl:template match="p">
    <p class="mb-3 fs-5">
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  
  <!-- Lists -->
  <xsl:template match="list">
    <xsl:choose>
      <xsl:when test="@type='bullet'">
        <ul class="mb-4 fs-5">
          <xsl:apply-templates/>
        </ul>
      </xsl:when>
      <xsl:when test="@type='numbered'">
        <ol class="mb-4 fs-5">
          <xsl:apply-templates/>
        </ol>
      </xsl:when>
      <xsl:otherwise>
        <ul class="mb-4 fs-5">
          <xsl:apply-templates/>
        </ul>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="item">
    <li class="mb-2">
      <xsl:apply-templates/>
    </li>
  </xsl:template>
  
  <!-- Images -->
  <xsl:template match="image">
    <figure class="figure text-center my-4">
      <img>
        <xsl:attribute name="src">
          <xsl:value-of select="@src"/>
        </xsl:attribute>
        <xsl:attribute name="alt">
          <xsl:value-of select="@alt"/>
        </xsl:attribute>
        <xsl:attribute name="class">
          <xsl:text>figure-img img-fluid rounded shadow-sm</xsl:text>
        </xsl:attribute>
        <xsl:if test="@width">
          <xsl:attribute name="style">
            <xsl:text>max-width: </xsl:text><xsl:value-of select="@width"/><xsl:text>;</xsl:text>
          </xsl:attribute>
        </xsl:if>
      </img>
      <xsl:if test="text()">
        <figcaption class="figure-caption text-center mt-2">
          <xsl:value-of select="text()"/>
        </figcaption>
      </xsl:if>
    </figure>
  </xsl:template>
  
  <!-- Quotes -->
  <xsl:template match="quote">
    <blockquote class="blockquote text-center my-4 px-4">
      <p class="fs-4 fst-italic"><xsl:value-of select="."/></p>
      <xsl:if test="@author">
        <footer class="blockquote-footer mt-2">
          <xsl:value-of select="@author"/>
        </footer>
      </xsl:if>
    </blockquote>
  </xsl:template>
  
  <!-- Charts -->
  <xsl:template match="chart">
    <div class="chart-container my-4 p-3 bg-body-tertiary rounded shadow-sm">
      <xsl:attribute name="class">
        <xsl:text>chart-container my-4 p-3 bg-body-tertiary rounded shadow-sm</xsl:text>
        <xsl:if test="@type">
          <xsl:text> chart-</xsl:text><xsl:value-of select="@type"/>
        </xsl:if>
      </xsl:attribute>
      
      <div>
        <xsl:attribute name="class">
          <xsl:text>chart</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="data-chart-type">
          <xsl:value-of select="@type"/>
        </xsl:attribute>
        <xsl:attribute name="data-chart-data">
          <xsl:value-of select="data"/>
        </xsl:attribute>
        <xsl:if test="options">
          <xsl:attribute name="data-chart-options">
            <xsl:value-of select="options"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="@height">
          <xsl:attribute name="style">
            <xsl:text>height: </xsl:text><xsl:value-of select="@height"/><xsl:text>;</xsl:text>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="not(@height)">
          <xsl:attribute name="style">
            <xsl:text>height: 400px;</xsl:text>
          </xsl:attribute>
        </xsl:if>
        <!-- Canvas will be created by JavaScript -->
      </div>
    </div>
  </xsl:template>
  
  <!-- Code blocks -->
  <xsl:template match="code">
    <div class="code-block my-4">
      <pre class="bg-body-tertiary p-3 rounded shadow-sm">
        <code>
          <xsl:if test="@language">
            <xsl:attribute name="class">
              <xsl:text>language-</xsl:text><xsl:value-of select="@language"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:value-of select="."/>
        </code>
      </pre>
    </div>
  </xsl:template>
  
  <!-- Tables -->
  <xsl:template match="table">
    <div class="table-responsive my-4">
      <table class="table table-striped table-hover">
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
    <a class="link-primary">
      <xsl:attribute name="href">
        <xsl:value-of select="@href"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </a>
  </xsl:template>
  
</xsl:stylesheet>
