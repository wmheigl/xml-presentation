<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- MEDIA COMPONENTS -->

  <!-- Video Template -->
  <xsl:template match="video">
    <xsl:variable name="aspectRatioClass">
      <xsl:choose>
        <xsl:when test="@aspect-ratio='16x9'">ratio-16x9</xsl:when>
        <xsl:when test="@aspect-ratio='4x3'">ratio-4x3</xsl:when>
        <xsl:when test="@aspect-ratio='21x9'">ratio-21x9</xsl:when>
        <xsl:when test="@aspect-ratio='1x1'">ratio-1x1</xsl:when>
        <xsl:otherwise>ratio-16x9</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <div class="ratio {$aspectRatioClass} mb-3">
      <xsl:choose>
        <xsl:when test="@type='youtube' and @id">
          <iframe src="https://www.youtube.com/embed/{@id}" 
                  title="{@title}" 
                  allowfullscreen="true" 
                  loading="lazy">
          </iframe>
        </xsl:when>
        <xsl:when test="@type='vimeo' and @id">
          <iframe src="https://player.vimeo.com/video/{@id}" 
                  title="{@title}" 
                  allowfullscreen="true" 
                  loading="lazy">
          </iframe>
        </xsl:when>
        <xsl:when test="@src">
          <video controls="true" class="embed-responsive-item">
            <xsl:if test="@poster">
              <xsl:attribute name="poster">
                <xsl:value-of select="@poster" />
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="@autoplay='true'">
              <xsl:attribute name="autoplay">autoplay</xsl:attribute>
              <xsl:attribute name="muted">muted</xsl:attribute>
            </xsl:if>
            <xsl:if test="@loop='true'">
              <xsl:attribute name="loop">loop</xsl:attribute>
            </xsl:if>
            <source src="{@src}" type="video/{@format}"></source>
            Your browser does not support the video tag.
          </video>
        </xsl:when>
      </xsl:choose>
    </div>
    
    <xsl:if test="caption">
      <figcaption class="figure-caption text-center">
        <xsl:value-of select="caption" />
      </figcaption>
    </xsl:if>
  </xsl:template>

  <!-- Audio Template -->
  <xsl:template match="audio">
    <div class="audio-player mb-3">
      <audio controls="true" class="w-100">
        <xsl:if test="@autoplay='true'">
          <xsl:attribute name="autoplay">autoplay</xsl:attribute>
        </xsl:if>
        <xsl:if test="@loop='true'">
          <xsl:attribute name="loop">loop</xsl:attribute>
        </xsl:if>
        <source src="{@src}" type="audio/{@format}"></source>
        Your browser does not support the audio element.
      </audio>
      
      <xsl:if test="caption">
        <figcaption class="figure-caption text-center mt-1">
          <xsl:value-of select="caption" />
        </figcaption>
      </xsl:if>
    </div>
  </xsl:template>

  <!-- IMAGE GALLERY COMPONENTS -->

  <!-- Image Gallery Template -->
  <xsl:template match="gallery">
    <xsl:variable name="galleryId">gallery-<xsl:value-of select="generate-id()" /></xsl:variable>
    
    <div class="gallery-container mb-4">
      <xsl:choose>
        <xsl:when test="@type='carousel'">
          <div id="{$galleryId}" class="carousel slide" data-bs-ride="carousel">
            <!-- Indicators -->
            <div class="carousel-indicators">
              <xsl:for-each select="image">
                <button type="button" 
                        data-bs-target="#{$galleryId}" 
                        data-bs-slide-to="{position() - 1}" 
                        class="{position() = 1 and 'active' or ''}">
                </button>
              </xsl:for-each>
            </div>
            
            <!-- Slides -->
            <div class="carousel-inner">
              <xsl:for-each select="image">
                <div class="carousel-item {position() = 1 and 'active' or ''}">
                  <img src="{@src}" class="d-block w-100" alt="{@alt}"/>
                  <xsl:if test="caption">
                    <div class="carousel-caption d-none d-md-block">
                      <p><xsl:value-of select="caption" /></p>
                    </div>
                  </xsl:if>
                </div>
              </xsl:for-each>
            </div>
            
            <!-- Controls -->
            <button class="carousel-control-prev" type="button" 
                    data-bs-target="#{$galleryId}" data-bs-slide="prev">
              <span class="carousel-control-prev-icon" aria-hidden="true"></span>
              <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" 
                    data-bs-target="#{$galleryId}" data-bs-slide="next">
              <span class="carousel-control-next-icon" aria-hidden="true"></span>
              <span class="visually-hidden">Next</span>
            </button>
          </div>
        </xsl:when>
        <xsl:otherwise>
          <!-- Grid gallery -->
          <div class="row g-2 gallery-grid">
            <xsl:for-each select="image">
              <div class="col-6 col-md-4 gallery-item">
                <a href="{@src}" class="gallery-link" data-gallery="{$galleryId}">
                  <img src="{@src}" alt="{@alt}" class="img-fluid rounded" />
                </a>
                <xsl:if test="caption">
                  <div class="caption small text-center mt-1">
                    <xsl:value-of select="caption" />
                  </div>
                </xsl:if>
              </div>
            </xsl:for-each>
          </div>
        </xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>

  <!-- INTERACTIVE COMPONENTS -->

  <!-- Accordion Template -->
  <xsl:template match="accordion">
    <xsl:variable name="accordionId">accordion-<xsl:value-of select="generate-id()" /></xsl:variable>
    
    <div class="accordion" id="{$accordionId}">
      <xsl:for-each select="item">
        <xsl:variable name="itemId"><xsl:value-of select="$accordionId" />-<xsl:value-of select="position()" /></xsl:variable>
        
        <div class="accordion-item">
          <h2 class="accordion-header" id="heading-{$itemId}">
            <button class="accordion-button{position() != 1 and ' collapsed' or ''}" 
                    type="button" 
                    data-bs-toggle="collapse" 
                    data-bs-target="#collapse-{$itemId}" 
                    aria-expanded="{position() = 1 and 'true' or 'false'}" 
                    aria-controls="collapse-{$itemId}">
              <xsl:value-of select="@title" />
            </button>
          </h2>
          <div id="collapse-{$itemId}" 
               class="accordion-collapse collapse{position() = 1 and ' show' or ''}" 
               aria-labelledby="heading-{$itemId}" 
               data-bs-parent="#{$accordionId}">
            <div class="accordion-body">
              <xsl:apply-templates />
            </div>
          </div>
        </div>
      </xsl:for-each>
    </div>
  </xsl:template>

  <!-- Modal Template -->
  <xsl:template match="modal">
    <xsl:variable name="modalId">modal-<xsl:value-of select="generate-id()" /></xsl:variable>
    
    <!-- Modal trigger button -->
    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#{$modalId}">
      <xsl:value-of select="@trigger-text" />
    </button>
    
    <!-- Modal dialog -->
    <div class="modal fade" id="{$modalId}" tabindex="-1" aria-labelledby="{$modalId}-label" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="{$modalId}-label"><xsl:value-of select="@title" /></h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <xsl:apply-templates select="content" />
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            <xsl:if test="@action-button='true'">
              <button type="button" class="btn btn-primary"><xsl:value-of select="@action-text" /></button>
            </xsl:if>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <!-- Tooltip Template -->
  <xsl:template match="tooltip">
    <span class="d-inline-block" data-bs-toggle="tooltip" data-bs-placement="{@position}" title="{@text}">
      <xsl:apply-templates />
    </span>
  </xsl:template>

  <!-- VISUALIZATION COMPONENTS -->

  <!-- Chart Container Template -->
  <xsl:template match="chart-container">
    <xsl:variable name="chartId">chart-<xsl:value-of select="generate-id()" /></xsl:variable>
    
    <div class="chart-container mb-4">
      <xsl:if test="@title">
        <h5 class="chart-title text-center mb-3"><xsl:value-of select="@title" /></h5>
      </xsl:if>
      
      <div class="chart-wrapper" style="height: {(@height) and @height or '300px'};">
        <canvas id="{$chartId}"></canvas>
      </div>
      
      <xsl:if test="caption">
        <figcaption class="figure-caption text-center mt-2">
          <xsl:value-of select="caption" />
        </figcaption>
      </xsl:if>
      
      <script>
        document.addEventListener('DOMContentLoaded', function() {
          const ctx = document.getElementById('<xsl:value-of select="$chartId" />').getContext('2d');
          
          const chartData = <xsl:value-of select="data" />;
          const chartOptions = <xsl:value-of select="options" />;
          
          new Chart(ctx, {
            type: '<xsl:value-of select="@type" />',
            data: chartData,
            options: chartOptions || {
              responsive: true,
              maintainAspectRatio: false
            }
          });
        });
      </script>
    </div>
  </xsl:template>

  <!-- Code Component -->
  <xsl:template match="code">
    <xsl:variable name="languageClass">
      <xsl:choose>
        <xsl:when test="@language">language-<xsl:value-of select="@language" /></xsl:when>
        <xsl:otherwise>language-plaintext</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <pre class="pre-code"><code class="{$languageClass}"><xsl:value-of select="." /></code></pre>
    
    <xsl:if test="@caption">
      <figcaption class="figure-caption text-center mt-1">
        <xsl:value-of select="@caption" />
      </figcaption>
    </xsl:if>
  </xsl:template>

  <!-- Math Formula Component -->
  <xsl:template match="math">
    <div class="math-container">
      <xsl:choose>
        <xsl:when test="@display='block'">
          <div class="math-block">
            \[<xsl:value-of select="." />\]
          </div>
        </xsl:when>
        <xsl:otherwise>
          <span class="math-inline">
            \(<xsl:value-of select="." />\)
          </span>
        </xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>

  <!-- FORM COMPONENTS -->

  <!-- Form Container -->
  <xsl:template match="form">
    <form>
      <xsl:apply-templates />
      
      <xsl:if test="@submit-text">
        <div class="mt-3">
          <button type="submit" class="btn btn-primary">
            <xsl:value-of select="@submit-text" />
          </button>
        </div>
      </xsl:if>
    </form>
  </xsl:template>

  <!-- Form Group (Label + Input) -->
  <xsl:template match="form-group">
    <div class="mb-3">
      <label for="{@id}" class="form-label">
        <xsl:value-of select="@label" />
        <xsl:if test="@required='true'">
          <span class="text-danger">*</span>
        </xsl:if>
      </label>
      
      <xsl:choose>
        <xsl:when test="@type='textarea'">
          <textarea class="form-control" id="{@id}" rows="{@rows}">
            <xsl:if test="@placeholder">
              <xsl:attribute name="placeholder">
                <xsl:value-of select="@placeholder" />
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="@required='true'">
              <xsl:attribute name="required">required</xsl:attribute>
            </xsl:if>
            <xsl:value-of select="." />
          </textarea>
        </xsl:when>
        <xsl:when test="@type='select'">
          <select class="form-select" id="{@id}">
            <xsl:if test="@required='true'">
              <xsl:attribute name="required">required</xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="option" />
          </select>
        </xsl:when>
        <xsl:otherwise>
          <input type="{@type}" class="form-control" id="{@id}">
            <xsl:if test="@placeholder">
              <xsl:attribute name="placeholder">
                <xsl:value-of select="@placeholder" />
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="@required='true'">
              <xsl:attribute name="required">required</xsl:attribute>
            </xsl:if>
            <xsl:if test="@value">
              <xsl:attribute name="value">
                <xsl:value-of select="@value" />
              </xsl:attribute>
            </xsl:if>
          </input>
        </xsl:otherwise>
      </xsl:choose>
      
      <xsl:if test="hint">
        <div class="form-text">
          <xsl:value-of select="hint" />
        </div>
      </xsl:if>
    </div>
  </xsl:template>

  <!-- Select Option -->
  <xsl:template match="option">
    <option value="{@value}">
      <xsl:if test="@selected='true'">
        <xsl:attribute name="selected">selected</xsl:attribute>
      </xsl:if>
      <xsl:value-of select="." />
    </option>
  </xsl:template>

  <!-- Checkbox/Radio Group -->
  <xsl:template match="check-group">
    <div class="mb-3">
      <label class="form-label">
        <xsl:value-of select="@label" />
        <xsl:if test="@required='true'">
          <span class="text-danger">*</span>
        </xsl:if>
      </label>
      
      <xsl:for-each select="item">
        <div class="{../@type}-group">
          <input class="form-check-input" 
                 type="{../@type}" 
                 name="{../@name}" 
                 id="{../@name}-{position()}" 
                 value="{@value}">
            <xsl:if test="@checked='true'">
              <xsl:attribute name="checked">checked</xsl:attribute>
            </xsl:if>
          </input>
          <label class="form-check-label" for="{../@name}-{position()}">
            <xsl:value-of select="." />
          </label>
        </div>
      </xsl:for-each>
    </div>
  </xsl:template>

  <!-- DATA DISPLAY COMPONENTS -->

  <!-- Data Table -->
  <xsl:template match="data-table">
    <div class="table-responsive">
      <table class="table">
        <xsl:if test="@striped='true'">
          <xsl:attribute name="class">table table-striped</xsl:attribute>
        </xsl:if>
        <xsl:if test="@bordered='true'">
          <xsl:attribute name="class">
            <xsl:value-of select="@striped='true' and 'table table-striped table-bordered' or 'table table-bordered'" />
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="@hoverable='true'">
          <xsl:attribute name="class">
            <xsl:value-of select="@class" /> table-hover
          </xsl:attribute>
        </xsl:if>
        
        <thead>
          <tr>
            <xsl:for-each select="header/column">
              <th scope="col">
                <xsl:if test="@width">
                  <xsl:attribute name="style">width: <xsl:value-of select="@width" />;</xsl:attribute>
                </xsl:if>
                <xsl:value-of select="." />
              </th>
            </xsl:for-each>
          </tr>
        </thead>
        <tbody>
          <xsl:for-each select="row">
            <tr>
              <xsl:for-each select="cell">
                <td>
                  <xsl:if test="@type">
                    <xsl:attribute name="class">
                      <xsl:choose>
                        <xsl:when test="@type='highlight'">table-primary</xsl:when>
                        <xsl:when test="@type='success'">table-success</xsl:when>
                        <xsl:when test="@type='danger'">table-danger</xsl:when>
                        <xsl:when test="@type='warning'">table-warning</xsl:when>
                        <xsl:when test="@type='info'">table-info</xsl:when>
                      </xsl:choose>
                    </xsl:attribute>
                  </xsl:if>
                  <xsl:apply-templates />
                </td>
              </xsl:for-each>
            </tr>
          </xsl:for-each>
        </tbody>
      </table>
    </div>
  </xsl:template>

  <!-- Stat Card -->
  <xsl:template match="stat">
    <div class="card text-center h-100">
      <div class="card-body">
        <xsl:if test="@icon">
          <div class="stat-icon mb-2">
            <i class="bi bi-{@icon} fs-1">
              <xsl:if test="@iconColor">
                <xsl:attribute name="class">
                  <xsl:text>bi bi-</xsl:text>
                  <xsl:value-of select="@icon" />
                  <xsl:text> fs-1 text-</xsl:text>
                  <xsl:value-of select="@iconColor" />
                </xsl:attribute>
              </xsl:if>
            </i>
          </div>
        </xsl:if>
        
        <h3 class="stat-value">
          <xsl:value-of select="@value" />
          <xsl:if test="@unit">
            <span class="stat-unit fs-6 text-muted ms-1"><xsl:value-of select="@unit" /></span>
          </xsl:if>
        </h3>
        
        <p class="stat-label text-muted mb-0">
          <xsl:value-of select="@label" />
        </p>
        
        <xsl:if test="@trend">
          <div class="stat-trend mt-2">
            <xsl:choose>
              <xsl:when test="starts-with(@trend, '+')">
                <span class="badge bg-success">
                  <i class="bi bi-arrow-up"></i>
                  <xsl:value-of select="@trend" />
                </span>
              </xsl:when>
              <xsl:when test="starts-with(@trend, '-')">
                <span class="badge bg-danger">
                  <i class="bi bi-arrow-down"></i>
                  <xsl:value-of select="@trend" />
                </span>
              </xsl:when>
              <xsl:otherwise>
                <span class="badge bg-secondary">
                  <i class="bi bi-dash"></i>
                  <xsl:value-of select="@trend" />
                </span>
              </xsl:otherwise>
            </xsl:choose>
          </div>
        </xsl:if>
      </div>
    </div>
  </xsl:template>

  <!-- Timeline Event -->
  <xsl:template match="timeline-event">
    <div class="timeline-item mb-4">
      <div class="timeline-marker"></div>
      <div class="timeline-content">
        <div class="timeline-date">
          <xsl:value-of select="@date" />
        </div>
        <h5 class="timeline-title">
          <xsl:value-of select="@title" />
        </h5>
        <div class="timeline-body">
          <xsl:apply-templates />
        </div>
      </div>
    </div>
  </xsl:template>

  <!-- SPECIALIZED COMPONENTS -->

  <!-- Quote Card -->
  <xsl:template match="quote-card">
    <div class="card">
      <div class="card-body">
        <blockquote class="blockquote mb-0">
          <p><xsl:value-of select="quote" /></p>
          <footer class="blockquote-footer">
            <xsl:value-of select="attribution" />
            <xsl:if test="role">
              <cite title="{role}"> - <xsl:value-of select="role" /></cite>
            </xsl:if>
          </footer>
        </blockquote>
      </div>
      
      <xsl:if test="image">
        <div class="card-img-bottom text-center p-3">
          <img src="{image/@src}" alt="{image/@alt}" class="rounded-circle" style="width: 80px; height: 80px; object-fit: cover;" />
        </div>
      </xsl:if>
    </div>
  </xsl:template>

  <!-- Product Feature -->
  <xsl:template match="product-feature">
    <div class="row align-items-center mb-4">
      <xsl:variable name="imagePosition">
        <xsl:choose>
          <xsl:when test="@image-position='right'">order-md-1</xsl:when>
          <xsl:otherwise></xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      
      <!-- Image column -->
      <div class="col-md-6 {$imagePosition}">
        <img src="{image/@src}" alt="{image/@alt}" class="img-fluid rounded" />
      </div>
      
      <!-- Content column -->
      <div class="col-md-6">
        <xsl:if test="@badge">
          <div class="mb-2">
            <span class="badge bg-primary"><xsl:value-of select="@badge" /></span>
          </div>
        </xsl:if>
        
        <h3><xsl:value-of select="@title" /></h3>
        
        <xsl:apply-templates select="*[not(self::image)]" />
        
        <xsl:if test="@action-text and @action-url">
          <a href="{@action-url}" class="btn btn-primary mt-3">
            <xsl:value-of select="@action-text" />
          </a>
        </xsl:if>
      </div>
    </div>
  </xsl:template>

  <!-- Pricing Plan -->
  <xsl:template match="pricing-plan">
    <div class="card h-100">
      <xsl:if test="@featured='true'">
        <div class="card-header bg-primary text-white text-center py-3">
          <span class="badge bg-white text-primary">Recommended</span>
        </div>
      </xsl:if>
      
      <div class="card-body text-center">
        <h5 class="card-title"><xsl:value-of select="@name" /></h5>
        
        <div class="pricing-value my-4">
          <span class="display-4">
            <xsl:value-of select="@currency" /><xsl:value-of select="@price" />
          </span>
          <span class="text-muted">/<xsl:value-of select="@period" /></span>
        </div>
        
        <ul class="list-unstyled mb-4">
          <xsl:for-each select="feature">
            <li class="mb-2">
              <xsl:choose>
                <xsl:when test="@included='false'">
                  <i class="bi bi-x text-danger me-2"></i>
                  <span class="text-muted"><xsl:value-of select="." /></span>
                </xsl:when>
                <xsl:otherwise>
                  <i class="bi bi-check text-success me-2"></i>
                  <xsl:value-of select="." />
                </xsl:otherwise>
              </xsl:choose>
            </li>
          </xsl:for-each>
        </ul>
        
        <a href="{@action-url}" class="btn btn-lg w-100 {(@featured='true' and 'btn-primary' or 'btn-outline-primary')}">
          <xsl:value-of select="@action-text" />
        </a>
      </div>
    </div>
  </xsl:template>

  <!-- Team Member -->
  <xsl:template match="team-member">
    <div class="card h-100 border-0 text-center">
      <img src="{image/@src}" class="card-img-top rounded-circle mx-auto mt-3" 
           alt="{@name}" style="width: 150px; height: 150px; object-fit: cover;" />
      
      <div class="card-body">
        <h5 class="card-title mb-1"><xsl:value-of select="@name" /></h5>
        <p class="text-muted mb-3"><xsl:value-of select="@role" /></p>
        
        <xsl:apply-templates select="*[not(self::image)]" />
        
        <xsl:if test="social">
          <div class="social-links mt-3">
            <xsl:for-each select="social/link">
              <a href="{@url}" class="btn btn-sm btn-outline-secondary mx-1" aria-label="{@platform}">
                <i class="bi bi-{@platform}"></i>
              </a>
            </xsl:for-each>
          </div>
        </xsl:if>
      </div>
    </div>
  </xsl:template>

  <!-- Contact Information -->
  <xsl:template match="contact-info">
    <div class="contact-card p-3">
      <xsl:if test="@title">
        <h5 class="mb-3"><xsl:value-of select="@title" /></h5>
      </xsl:if>
      
      <ul class="list-unstyled">
        <xsl:if test="address">
          <li class="mb-2">
            <i class="bi bi-geo-alt me-2"></i>
            <xsl:value-of select="address" />
          </li>
        </xsl:if>
        
        <xsl:if test="phone">
          <li class="mb-2">
            <i class="bi bi-telephone me-2"></i>
            <a href="tel:{phone}"><xsl:value-of select="phone" /></a>
          </li>
        </xsl:if>
        
        <xsl:if test="email">
          <li class="mb-2">
            <i class="bi bi-envelope me-2"></i>
            <a href="mailto:{email}"><xsl:value-of select="email" /></a>
          </li>
        </xsl:if>
        
        <xsl:if test="website">
          <li class="mb-2">
            <i class="bi bi-globe me-2"></i>
            <a href="{website/@url}" target="_blank"><xsl:value-of select="website" /></a>
          </li>
        </xsl:if>
      </ul>
      
      <xsl:if test="social">
        <div class="social-links mt-3">
          <xsl:for-each select="social/link">
            <a href="{@url}" class="btn btn-sm btn-outline-primary mx-1" aria-label="{@platform}">
              <i class="bi bi-{@platform}"></i>
            </a>
          </xsl:for-each>
        </div>
      </xsl:if>
    </div>
  </xsl:template>
</xsl:stylesheet>
