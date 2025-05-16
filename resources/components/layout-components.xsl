<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- Container Template -->
  <xsl:template match="container">
    <xsl:variable name="containerType">
      <xsl:choose>
        <xsl:when test="@type='fluid'">container-fluid</xsl:when>
        <xsl:when test="@type='fixed'">container</xsl:when>
        <xsl:when test="@type='center'">container mx-auto</xsl:when>
        <xsl:otherwise>container</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="paddingClass">
      <xsl:choose>
        <xsl:when test="@padding='none'"></xsl:when>
        <xsl:when test="@padding='small'">p-2</xsl:when>
        <xsl:when test="@padding='medium'">p-3</xsl:when>
        <xsl:when test="@padding='large'">p-5</xsl:when>
        <xsl:otherwise>p-3</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="marginClass">
      <xsl:choose>
        <xsl:when test="@margin='none'"></xsl:when>
        <xsl:when test="@margin='small'">m-2</xsl:when>
        <xsl:when test="@margin='medium'">m-3</xsl:when>
        <xsl:when test="@margin='large'">m-5</xsl:when>
        <xsl:otherwise>m-3</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="backgroundClass">
      <xsl:choose>
        <xsl:when test="@background='none'"></xsl:when>
        <xsl:when test="@background='light'">bg-light</xsl:when>
        <xsl:when test="@background='dark'">bg-dark text-light</xsl:when>
        <xsl:when test="@background='primary'">bg-primary text-white</xsl:when>
        <xsl:when test="@background='secondary'">bg-secondary text-white</xsl:when>
        <xsl:when test="@background='accent'">bg-info text-dark</xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <div class="{$containerType} {$paddingClass} {$marginClass} {$backgroundClass}">
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <!-- Section Template -->
  <xsl:template match="section">
    <xsl:variable name="visibilityClass">
      <xsl:choose>
        <xsl:when test="@visibility='hidden'">d-none</xsl:when>
        <xsl:when test="@visibility='print-only'">d-none d-print-block</xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="importanceClass">
      <xsl:choose>
        <xsl:when test="@importance='primary'">border-primary</xsl:when>
        <xsl:when test="@importance='secondary'">border-secondary opacity-75</xsl:when>
        <xsl:when test="@importance='tertiary'">border-light opacity-50</xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <section id="{@id}" class="{$visibilityClass} {$importanceClass} my-3">
      <xsl:if test="@title">
        <h2 class="section-title"><xsl:value-of select="@title" /></h2>
      </xsl:if>
      <xsl:apply-templates />
    </section>
  </xsl:template>

  <!-- Layout Template -->
  <xsl:template match="layout">
    <xsl:variable name="typeClass">
      <xsl:choose>
        <xsl:when test="@type='vertical'">d-flex flex-column</xsl:when>
        <xsl:when test="@type='horizontal'">d-flex flex-row</xsl:when>
        <xsl:when test="@type='centered'">d-flex justify-content-center align-items-center</xsl:when>
        <xsl:when test="@type='asymmetric'">d-flex</xsl:when>
        <xsl:otherwise>d-block</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="balanceClass">
      <xsl:choose>
        <xsl:when test="@balance='even'">justify-content-between</xsl:when>
        <xsl:when test="@balance='left-heavy'">justify-content-start</xsl:when>
        <xsl:when test="@balance='right-heavy'">justify-content-end</xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="spacingClass">
      <xsl:choose>
        <xsl:when test="@spacing='compact'">g-1</xsl:when>
        <xsl:when test="@spacing='comfortable'">g-3</xsl:when>
        <xsl:when test="@spacing='spacious'">g-5</xsl:when>
        <xsl:otherwise>g-3</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <div class="{$typeClass} {$balanceClass} {$spacingClass}">
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <!-- Grid Template -->
  <xsl:template match="grid">
    <xsl:variable name="gapClass">
      <xsl:choose>
        <xsl:when test="@gap='none'">g-0</xsl:when>
        <xsl:when test="@gap='small'">g-2</xsl:when>
        <xsl:when test="@gap='medium'">g-3</xsl:when>
        <xsl:when test="@gap='large'">g-5</xsl:when>
        <xsl:otherwise>g-3</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="alignmentClass">
      <xsl:choose>
        <xsl:when test="@alignment='start'">justify-content-start</xsl:when>
        <xsl:when test="@alignment='center'">justify-content-center</xsl:when>
        <xsl:when test="@alignment='end'">justify-content-end</xsl:when>
        <xsl:when test="@alignment='between'">justify-content-between</xsl:when>
        <xsl:when test="@alignment='around'">justify-content-around</xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="responsivenessClass">
      <xsl:choose>
        <xsl:when test="@responsiveness='desktop-only'">d-none d-md-flex</xsl:when>
        <xsl:when test="@responsiveness='mobile-only'">d-flex d-md-none</xsl:when>
        <xsl:otherwise>d-flex</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <div class="row {$gapClass} {$alignmentClass} {$responsivenessClass}">
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <!-- Column Template -->
  <xsl:template match="column">
    <xsl:variable name="spanClass">
      <xsl:choose>
        <xsl:when test="@span">col-md-<xsl:value-of select="@span" /></xsl:when>
        <xsl:otherwise>col</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="offsetClass">
      <xsl:if test="@offset">
        <xsl:text>offset-md-</xsl:text><xsl:value-of select="@offset" />
      </xsl:if>
    </xsl:variable>
    
    <xsl:variable name="alignmentClass">
      <xsl:choose>
        <xsl:when test="@alignment='start'">align-self-start</xsl:when>
        <xsl:when test="@alignment='center'">align-self-center</xsl:when>
        <xsl:when test="@alignment='end'">align-self-end</xsl:when>
        <xsl:when test="@alignment='stretch'">align-self-stretch</xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="visibilityClass">
      <xsl:choose>
        <xsl:when test="@visibility='desktop-only'">d-none d-md-block</xsl:when>
        <xsl:when test="@visibility='tablet-only'">d-none d-sm-block d-lg-none</xsl:when>
        <xsl:when test="@visibility='mobile-only'">d-block d-md-none</xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <div class="{$spanClass} {$offsetClass} {$alignmentClass} {$visibilityClass}">
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <!-- Flex Container Template -->
  <xsl:template match="flex-container">
    <xsl:variable name="directionClass">
      <xsl:choose>
        <xsl:when test="@direction='row'">flex-row</xsl:when>
        <xsl:when test="@direction='column'">flex-column</xsl:when>
        <xsl:when test="@direction='row-reverse'">flex-row-reverse</xsl:when>
        <xsl:when test="@direction='column-reverse'">flex-column-reverse</xsl:when>
        <xsl:otherwise>flex-row</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="wrapClass">
      <xsl:choose>
        <xsl:when test="@wrap='nowrap'">flex-nowrap</xsl:when>
        <xsl:when test="@wrap='wrap'">flex-wrap</xsl:when>
        <xsl:when test="@wrap='wrap-reverse'">flex-wrap-reverse</xsl:when>
        <xsl:otherwise>flex-wrap</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="justifyClass">
      <xsl:choose>
        <xsl:when test="@justify='start'">justify-content-start</xsl:when>
        <xsl:when test="@justify='center'">justify-content-center</xsl:when>
        <xsl:when test="@justify='end'">justify-content-end</xsl:when>
        <xsl:when test="@justify='between'">justify-content-between</xsl:when>
        <xsl:when test="@justify='around'">justify-content-around</xsl:when>
        <xsl:otherwise>justify-content-start</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="alignClass">
      <xsl:choose>
        <xsl:when test="@align='start'">align-items-start</xsl:when>
        <xsl:when test="@align='center'">align-items-center</xsl:when>
        <xsl:when test="@align='end'">align-items-end</xsl:when>
        <xsl:when test="@align='stretch'">align-items-stretch</xsl:when>
        <xsl:when test="@align='baseline'">align-items-baseline</xsl:when>
        <xsl:otherwise>align-items-start</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <div class="d-flex {$directionClass} {$wrapClass} {$justifyClass} {$alignClass}">
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <!-- Alignment Template -->
  <xsl:template match="alignment">
    <xsl:variable name="horizontalClass">
      <xsl:choose>
        <xsl:when test="@horizontal='left'">text-start</xsl:when>
        <xsl:when test="@horizontal='center'">text-center</xsl:when>
        <xsl:when test="@horizontal='right'">text-end</xsl:when>
        <xsl:otherwise>text-start</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="verticalClass">
      <xsl:choose>
        <xsl:when test="@vertical='top'">align-top</xsl:when>
        <xsl:when test="@vertical='middle'">align-middle</xsl:when>
        <xsl:when test="@vertical='bottom'">align-bottom</xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="textClass">
      <xsl:choose>
        <xsl:when test="@text='left'">text-start</xsl:when>
        <xsl:when test="@text='center'">text-center</xsl:when>
        <xsl:when test="@text='right'">text-end</xsl:when>
        <xsl:when test="@text='justify'">text-justify</xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <div class="{$horizontalClass} {$verticalClass} {$textClass}">
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <!-- Spacer Template -->
  <xsl:template match="spacer">
    <xsl:variable name="sizeClass">
      <xsl:choose>
        <xsl:when test="@size='small'">2</xsl:when>
        <xsl:when test="@size='medium'">3</xsl:when>
        <xsl:when test="@size='large'">5</xsl:when>
        <xsl:when test="@size='custom'">4</xsl:when>
        <xsl:otherwise>3</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="visibilityClass">
      <xsl:choose>
        <xsl:when test="@visibility='desktop-only'">d-none d-md-block</xsl:when>
        <xsl:when test="@visibility='mobile-only'">d-block d-md-none</xsl:when>
        <xsl:otherwise>d-block</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:choose>
      <xsl:when test="@orientation='horizontal'">
        <div class="{$visibilityClass} px-{$sizeClass}"></div>
      </xsl:when>
      <xsl:otherwise>
        <div class="{$visibilityClass} py-{$sizeClass}"></div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Overlay Template -->
  <xsl:template match="overlay">
    <xsl:variable name="positionClass">
      <xsl:choose>
        <xsl:when test="@position='top'">top-0 start-0 end-0</xsl:when>
        <xsl:when test="@position='right'">top-0 end-0 bottom-0</xsl:when>
        <xsl:when test="@position='bottom'">bottom-0 start-0 end-0</xsl:when>
        <xsl:when test="@position='left'">top-0 start-0 bottom-0</xsl:when>
        <xsl:when test="@position='center'">top-50 start-50 translate-middle</xsl:when>
        <xsl:otherwise>top-50 start-50 translate-middle</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="opacityClass">
      <xsl:choose>
        <xsl:when test="@opacity='light'">bg-dark bg-opacity-25</xsl:when>
        <xsl:when test="@opacity='medium'">bg-dark bg-opacity-50</xsl:when>
        <xsl:when test="@opacity='dark'">bg-dark bg-opacity-75</xsl:when>
        <xsl:otherwise>bg-dark bg-opacity-50</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="paddingClass">
      <xsl:choose>
        <xsl:when test="@padding='none'">p-0</xsl:when>
        <xsl:when test="@padding='small'">p-2</xsl:when>
        <xsl:when test="@padding='medium'">p-3</xsl:when>
        <xsl:when test="@padding='large'">p-5</xsl:when>
        <xsl:otherwise>p-3</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <div class="position-absolute {$positionClass} {$opacityClass} {$paddingClass} text-white">
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <!-- Split Template -->
  <xsl:template match="split">
    <xsl:variable name="ratioClasses">
      <xsl:choose>
        <xsl:when test="@ratio='50-50'">col-md-6 col-md-6</xsl:when>
        <xsl:when test="@ratio='60-40'">col-md-7 col-md-5</xsl:when>
        <xsl:when test="@ratio='70-30'">col-md-8 col-md-4</xsl:when>
        <xsl:when test="@ratio='80-20'">col-md-9 col-md-3</xsl:when>
        <xsl:when test="@ratio='auto'">col-auto col-auto</xsl:when>
        <xsl:otherwise>col-md-6 col-md-6</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="divisionClass">
      <xsl:choose>
        <xsl:when test="@division='line'">border-end</xsl:when>
        <xsl:when test="@division='space'">px-2</xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="directionClass">
      <xsl:choose>
        <xsl:when test="@direction='vertical'">flex-column</xsl:when>
        <xsl:otherwise>flex-row</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
<div class="row d-flex {$directionClass}">
      <div class="{substring-before($ratioClasses, ' ')} {$divisionClass}">
        <xsl:apply-templates select="left" />
      </div>
      <div class="{substring-after($ratioClasses, ' ')}">
        <xsl:apply-templates select="right" />
      </div>
    </div>
  </xsl:template>

  <!-- Split Left/Right Content -->
  <xsl:template match="left|right">
    <div class="h-100 p-3">
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <!-- Comparison Template -->
  <xsl:template match="comparison">
    <xsl:variable name="typeClass">
      <xsl:choose>
        <xsl:when test="@type='before-after'">compare-before-after</xsl:when>
        <xsl:when test="@type='product'">compare-product</xsl:when>
        <xsl:when test="@type='pros-cons'">compare-pros-cons</xsl:when>
        <xsl:when test="@type='timeline'">compare-timeline</xsl:when>
        <xsl:otherwise>compare-before-after</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="labelsClass">
      <xsl:choose>
        <xsl:when test="@labels='visible'">labels-visible</xsl:when>
        <xsl:when test="@labels='hidden'">labels-hidden</xsl:when>
        <xsl:otherwise>labels-visible</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="dividerClass">
      <xsl:choose>
        <xsl:when test="@divider='line'">divider-line</xsl:when>
        <xsl:when test="@divider='arrow'">divider-arrow</xsl:when>
        <xsl:when test="@divider='none'">divider-none</xsl:when>
        <xsl:otherwise>divider-line</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <div class="comparison-container row {$typeClass} {$labelsClass} {$dividerClass}">
      <div class="col-md-6 p-2">
        <xsl:if test="@labels='visible' and @type='before-after'">
          <div class="badge bg-secondary mb-2">Before</div>
        </xsl:if>
        <xsl:apply-templates select="before" />
      </div>
      
      <div class="col-md-6 p-2">
        <xsl:if test="@labels='visible' and @type='before-after'">
          <div class="badge bg-primary mb-2">After</div>
        </xsl:if>
        <xsl:apply-templates select="after" />
      </div>
    </div>
  </xsl:template>

  <!-- Comparison Before/After Content -->
  <xsl:template match="before|after">
    <div class="comparison-content">
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <!-- Timeline Template -->
  <xsl:template match="timeline">
    <xsl:variable name="orientationClass">
      <xsl:choose>
        <xsl:when test="@orientation='vertical'">timeline-vertical</xsl:when>
        <xsl:otherwise>timeline-horizontal</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="alignmentClass">
      <xsl:choose>
        <xsl:when test="@alignment='center'">timeline-center</xsl:when>
        <xsl:when test="@alignment='alternate'">timeline-alternate</xsl:when>
        <xsl:when test="@alignment='left'">timeline-left</xsl:when>
        <xsl:when test="@alignment='right'">timeline-right</xsl:when>
        <xsl:otherwise>timeline-center</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="markersClass">
      <xsl:choose>
        <xsl:when test="@markers='dots'">timeline-dots</xsl:when>
        <xsl:when test="@markers='numbers'">timeline-numbers</xsl:when>
        <xsl:when test="@markers='icons'">timeline-icons</xsl:when>
        <xsl:when test="@markers='none'">timeline-no-markers</xsl:when>
        <xsl:otherwise>timeline-dots</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <div class="timeline {$orientationClass} {$alignmentClass} {$markersClass}">
      <div class="timeline-track position-relative">
        <xsl:choose>
          <xsl:when test="@orientation='horizontal'">
            <div class="d-flex overflow-auto py-4">
              <xsl:for-each select="event">
                <div class="timeline-item mx-3 text-center">
                  <div class="timeline-marker rounded-circle bg-primary mx-auto mb-2"></div>
                  <div class="timeline-date mb-1 fw-bold"><xsl:value-of select="@date" /></div>
                  <div class="timeline-content p-2 border rounded">
                    <h5><xsl:value-of select="title" /></h5>
                    <p class="mb-0"><xsl:value-of select="description" /></p>
                  </div>
                </div>
              </xsl:for-each>
            </div>
          </xsl:when>
          <xsl:otherwise>
            <div class="position-relative">
              <div class="timeline-line position-absolute start-50 translate-middle-x"></div>
              <xsl:for-each select="event">
                <div class="timeline-item row mb-4 position-relative">
                  <div class="col-5 text-end pe-4">
                    <xsl:if test="position() mod 2 = 1 or ../@alignment != 'alternate'">
                      <div class="timeline-date fw-bold"><xsl:value-of select="@date" /></div>
                      <div class="timeline-content p-2 border rounded">
                        <h5><xsl:value-of select="title" /></h5>
                        <p class="mb-0"><xsl:value-of select="description" /></p>
                      </div>
                    </xsl:if>
                  </div>
                  <div class="col-2 position-relative">
                    <div class="timeline-marker rounded-circle bg-primary position-absolute top-0 start-50 translate-middle-x"></div>
                  </div>
                  <div class="col-5 text-start ps-4">
                    <xsl:if test="position() mod 2 = 0 and ../@alignment = 'alternate'">
                      <div class="timeline-date fw-bold"><xsl:value-of select="@date" /></div>
                      <div class="timeline-content p-2 border rounded">
                        <h5><xsl:value-of select="title" /></h5>
                        <p class="mb-0"><xsl:value-of select="description" /></p>
                      </div>
                    </xsl:if>
                  </div>
                </div>
              </xsl:for-each>
            </div>
          </xsl:otherwise>
        </xsl:choose>
      </div>
    </div>
  </xsl:template>

  <!-- Masonry Template -->
  <xsl:template match="masonry">
    <xsl:variable name="columnClass">
      <xsl:choose>
        <xsl:when test="@columns='1'">12</xsl:when>
        <xsl:when test="@columns='2'">6</xsl:when>
        <xsl:when test="@columns='3'">4</xsl:when>
        <xsl:when test="@columns='4'">3</xsl:when>
        <xsl:when test="@columns='5'">2.4</xsl:when>
        <xsl:when test="@columns='6'">2</xsl:when>
        <xsl:otherwise>4</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="gapClass">
      <xsl:choose>
        <xsl:when test="@gap='none'">g-0</xsl:when>
        <xsl:when test="@gap='small'">g-2</xsl:when>
        <xsl:when test="@gap='medium'">g-3</xsl:when>
        <xsl:when test="@gap='large'">g-5</xsl:when>
        <xsl:otherwise>g-3</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <div class="row {$gapClass} masonry-grid" data-masonry='{"percentPosition": true}'>
      <xsl:for-each select="item">
        <div class="col-6 col-md-{$columnClass} mb-4 masonry-item">
          <div class="card h-100">
            <xsl:apply-templates />
          </div>
        </div>
      </xsl:for-each>
    </div>
    
    <!-- Add Masonry initialization class for JavaScript to identify -->
    <div class="masonry-init" data-columns="{@columns}"></div>
  </xsl:template>

</xsl:stylesheet>
