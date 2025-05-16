<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- Common attribute helper templates -->
  
  <!-- Generate responsive visibility classes -->
  <xsl:template name="visibility-classes">
    <xsl:param name="visibility" />
    <xsl:choose>
      <xsl:when test="$visibility='hidden'">d-none</xsl:when>
      <xsl:when test="$visibility='visible-desktop'">d-none d-md-block</xsl:when>
      <xsl:when test="$visibility='visible-tablet'">d-none d-sm-block d-lg-none</xsl:when>
      <xsl:when test="$visibility='visible-mobile'">d-block d-md-none</xsl:when>
      <xsl:when test="$visibility='hidden-desktop'">d-md-none</xsl:when>
      <xsl:when test="$visibility='hidden-mobile'">d-none d-md-block</xsl:when>
      <xsl:when test="$visibility='print-only'">d-none d-print-block</xsl:when>
      <xsl:when test="$visibility='no-print'">d-print-none</xsl:when>
      <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Generate spacing classes -->
  <xsl:template name="spacing-classes">
    <xsl:param name="type" /> <!-- m or p -->
    <xsl:param name="size" />
    <xsl:param name="direction" /> <!-- optional: t, b, s, e, x, y -->
    
    <xsl:variable name="directionPart">
      <xsl:if test="$direction != ''">-<xsl:value-of select="$direction" /></xsl:if>
    </xsl:variable>
    
    <xsl:variable name="sizePart">
      <xsl:choose>
        <xsl:when test="$size='none'">-0</xsl:when>
        <xsl:when test="$size='small'">-2</xsl:when>
        <xsl:when test="$size='medium'">-3</xsl:when>
        <xsl:when test="$size='large'">-4</xsl:when>
        <xsl:when test="$size='extra-large'">-5</xsl:when>
        <xsl:when test="$size='auto'">-auto</xsl:when>
        <xsl:otherwise>-3</xsl:otherwise> <!-- Default to medium -->
      </xsl:choose>
    </xsl:variable>
    
    <xsl:value-of select="concat($type, $directionPart, $sizePart)" />
  </xsl:template>
  
  <!-- Generate text color classes -->
  <xsl:template name="text-color-classes">
    <xsl:param name="color" />
    <xsl:choose>
      <xsl:when test="$color='primary'">text-primary</xsl:when>
      <xsl:when test="$color='secondary'">text-secondary</xsl:when>
      <xsl:when test="$color='success'">text-success</xsl:when>
      <xsl:when test="$color='danger'">text-danger</xsl:when>
      <xsl:when test="$color='warning'">text-warning</xsl:when>
      <xsl:when test="$color='info'">text-info</xsl:when>
      <xsl:when test="$color='light'">text-light</xsl:when>
      <xsl:when test="$color='dark'">text-dark</xsl:when>
      <xsl:when test="$color='muted'">text-muted</xsl:when>
      <xsl:when test="$color='white'">text-white</xsl:when>
      <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Generate background color classes -->
  <xsl:template name="bg-color-classes">
    <xsl:param name="color" />
    <xsl:choose>
      <xsl:when test="$color='primary'">bg-primary</xsl:when>
      <xsl:when test="$color='secondary'">bg-secondary</xsl:when>
      <xsl:when test="$color='success'">bg-success</xsl:when>
      <xsl:when test="$color='danger'">bg-danger</xsl:when>
      <xsl:when test="$color='warning'">bg-warning</xsl:when>
      <xsl:when test="$color='info'">bg-info</xsl:when>
      <xsl:when test="$color='light'">bg-light</xsl:when>
      <xsl:when test="$color='dark'">bg-dark</xsl:when>
      <xsl:when test="$color='transparent'">bg-transparent</xsl:when>
      <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
<!-- Generate border classes -->
  <xsl:template name="border-classes">
    <xsl:param name="border" /> <!-- true/false -->
    <xsl:param name="color" /> <!-- optional -->
    <xsl:param name="direction" /> <!-- optional: top, bottom, start, end -->
    
    <xsl:if test="$border='true'">
      <xsl:choose>
        <xsl:when test="$direction != ''">
          <xsl:value-of select="concat('border-', $direction)" />
        </xsl:when>
        <xsl:otherwise>border</xsl:otherwise>
      </xsl:choose>
      
      <xsl:if test="$color != ''">
        <xsl:value-of select="concat(' border-', $color)" />
      </xsl:if>
    </xsl:if>
    
    <xsl:if test="$border='false'">
      <xsl:choose>
        <xsl:when test="$direction != ''">
          <xsl:value-of select="concat('border-', $direction, '-0')" />
        </xsl:when>
        <xsl:otherwise>border-0</xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>
  
  <!-- Generate text alignment classes -->
  <xsl:template name="text-alignment-classes">
    <xsl:param name="alignment" />
    <xsl:choose>
      <xsl:when test="$alignment='left'">text-start</xsl:when>
      <xsl:when test="$alignment='center'">text-center</xsl:when>
      <xsl:when test="$alignment='right'">text-end</xsl:when>
      <xsl:when test="$alignment='justify'">text-justify</xsl:when>
      <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Generate font size classes -->
  <xsl:template name="font-size-classes">
    <xsl:param name="size" />
    <xsl:choose>
      <xsl:when test="$size='1'">fs-1</xsl:when>
      <xsl:when test="$size='2'">fs-2</xsl:when>
      <xsl:when test="$size='3'">fs-3</xsl:when>
      <xsl:when test="$size='4'">fs-4</xsl:when>
      <xsl:when test="$size='5'">fs-5</xsl:when>
      <xsl:when test="$size='6'">fs-6</xsl:when>
      <xsl:when test="$size='small'">small</xsl:when>
      <xsl:when test="$size='large'">lead</xsl:when>
      <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Generate font weight classes -->
  <xsl:template name="font-weight-classes">
    <xsl:param name="weight" />
    <xsl:choose>
      <xsl:when test="$weight='bold'">fw-bold</xsl:when>
      <xsl:when test="$weight='bolder'">fw-bolder</xsl:when>
      <xsl:when test="$weight='semibold'">fw-semibold</xsl:when>
      <xsl:when test="$weight='medium'">fw-medium</xsl:when>
      <xsl:when test="$weight='normal'">fw-normal</xsl:when>
      <xsl:when test="$weight='light'">fw-light</xsl:when>
      <xsl:when test="$weight='lighter'">fw-lighter</xsl:when>
      <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Generate rounded corner classes -->
  <xsl:template name="rounded-classes">
    <xsl:param name="rounded" />
    <xsl:choose>
      <xsl:when test="$rounded='true' or $rounded='rounded'">rounded</xsl:when>
      <xsl:when test="$rounded='pill'">rounded-pill</xsl:when>
      <xsl:when test="$rounded='circle'">rounded-circle</xsl:when>
      <xsl:when test="$rounded='0'">rounded-0</xsl:when>
      <xsl:when test="$rounded='1'">rounded-1</xsl:when>
      <xsl:when test="$rounded='2'">rounded-2</xsl:when>
      <xsl:when test="$rounded='3'">rounded-3</xsl:when>
      <xsl:when test="$rounded='4'">rounded-4</xsl:when>
      <xsl:when test="$rounded='5'">rounded-5</xsl:when>
      <xsl:when test="$rounded='top'">rounded-top</xsl:when>
      <xsl:when test="$rounded='end'">rounded-end</xsl:when>
      <xsl:when test="$rounded='bottom'">rounded-bottom</xsl:when>
      <xsl:when test="$rounded='start'">rounded-start</xsl:when>
      <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Generate shadow classes -->
  <xsl:template name="shadow-classes">
    <xsl:param name="shadow" />
    <xsl:choose>
      <xsl:when test="$shadow='true' or $shadow='default'">shadow</xsl:when>
      <xsl:when test="$shadow='small'">shadow-sm</xsl:when>
      <xsl:when test="$shadow='large'">shadow-lg</xsl:when>
      <xsl:when test="$shadow='none'">shadow-none</xsl:when>
      <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Utility helpers for component properties -->
  
  <!-- Format a URL with proper path handling -->
  <xsl:template name="format-url">
    <xsl:param name="url" />
    <xsl:choose>
      <xsl:when test="starts-with($url, 'http://') or starts-with($url, 'https://') or starts-with($url, '/')">
        <xsl:value-of select="$url" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>./</xsl:text><xsl:value-of select="$url" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Generate ID attribute if needed -->
  <xsl:template name="generate-id">
    <xsl:param name="prefix" />
    <xsl:param name="id" />
    
    <xsl:choose>
      <xsl:when test="$id != ''">
        <xsl:value-of select="$id" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat($prefix, '-', generate-id())" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Format date for display -->
  <xsl:template name="format-date">
    <xsl:param name="date" />
    <xsl:param name="format" select="'long'" /> <!-- long, short, iso -->
    
    <!-- Note: This is a simplified implementation. XSLT 1.0 has limited date formatting capabilities.
         For more sophisticated date formatting, consider using JavaScript in the final HTML or XSLT 2.0+ -->
    <xsl:value-of select="$date" />
  </xsl:template>
  
  <!-- Check if string contains a substring -->
  <xsl:template name="contains">
    <xsl:param name="string" />
    <xsl:param name="substring" />
    
    <xsl:choose>
      <xsl:when test="contains($string, $substring)">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Safe string concatenation with spaces -->
  <xsl:template name="string-join">
    <xsl:param name="strings" />
    <xsl:param name="separator" select="' '" />
    
    <xsl:for-each select="$strings">
      <xsl:value-of select="." />
      <xsl:if test="position() != last()">
        <xsl:value-of select="$separator" />
      </xsl:if>
    </xsl:for-each>
  </xsl:template>
  
  <!-- Convert boolean to string -->
  <xsl:template name="boolean-to-string">
    <xsl:param name="boolean" />
    <xsl:choose>
      <xsl:when test="$boolean = 'true' or $boolean = '1' or $boolean = 'yes'">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Strip whitespace from a string -->
  <xsl:template name="strip-whitespace">
    <xsl:param name="string" />
    <xsl:value-of select="normalize-space($string)" />
  </xsl:template>
  
  <!-- Get the nth item from a delimited list -->
  <xsl:template name="get-list-item">
    <xsl:param name="list" />
    <xsl:param name="delimiter" select="','" />
    <xsl:param name="position" select="1" />
    
    <xsl:choose>
      <xsl:when test="contains($list, $delimiter)">
        <xsl:variable name="first" select="substring-before($list, $delimiter)" />
        <xsl:variable name="rest" select="substring-after($list, $delimiter)" />
        
        <xsl:choose>
          <xsl:when test="$position = 1">
            <xsl:value-of select="$first" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="get-list-item">
              <xsl:with-param name="list" select="$rest" />
              <xsl:with-param name="delimiter" select="$delimiter" />
              <xsl:with-param name="position" select="$position - 1" />
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$position = 1">
          <xsl:value-of select="$list" />
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Count items in a delimited list -->
  <xsl:template name="count-list-items">
    <xsl:param name="list" />
    <xsl:param name="delimiter" select="','" />
    
    <xsl:choose>
      <xsl:when test="contains($list, $delimiter)">
        <xsl:variable name="rest" select="substring-after($list, $delimiter)" />
        <xsl:variable name="count">
          <xsl:call-template name="count-list-items">
            <xsl:with-param name="list" select="$rest" />
            <xsl:with-param name="delimiter" select="$delimiter" />
          </xsl:call-template>
        </xsl:variable>
        <xsl:value-of select="$count + 1" />
      </xsl:when>
      <xsl:when test="string-length($list) > 0">
        <xsl:value-of select="1" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="0" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>
