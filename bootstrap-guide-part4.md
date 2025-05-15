# Responsive Design

Our Bootstrap integration ensures that presentations adapt seamlessly to different screen sizes and devices. This is achieved through several techniques:

## Bootstrap Grid System

The XML markup supports Bootstrap's responsive grid system. Use `<row>` and `<col>` elements with appropriate size attributes:

```xml
<row>
  <col size="12 md-6 lg-4">
    <!-- Content for small: full width, medium: half width, large: third width -->
    <p>First column content</p>
  </col>
  <col size="12 md-6 lg-4">
    <p>Second column content</p>
  </col>
  <col size="12 md-12 lg-4">
    <p>Third column content</p>
  </col>
</row>
```

## Responsive Utilities

Use Bootstrap's responsive utility classes in the `class` attribute of any element:

```xml
<!-- Hide on small screens, show on medium and up -->
<p class="d-none d-md-block">This content is only visible on medium screens and larger</p>

<!-- Different font sizes based on screen size -->
<p class="fs-6 fs-md-5 fs-lg-4">Responsive text that scales up on larger screens</p>

<!-- Different alignment based on screen size -->
<p class="text-center text-md-start">Centered on mobile, left-aligned on larger screens</p>
```

## New in 2025: Container Queries

Our system now supports CSS Container Queries, allowing components to respond to their parent container's size rather than just the viewport size:

```css
/* CSS in presentation-custom.css */
.slide-content {
  container-type: inline-size;
}

/* Chart container that adapts based on its own width */
.chart-container {
  width: 100%;
}

/* Chart becomes more compact when its container is narrow */
@container (max-width: 500px) {
  .chart-container {
    padding: 0.5rem;
    margin: 0.5rem 0;
  }
  
  .chart-container .chart-title {
    font-size: 0.9rem;
  }
}

/* Chart has more padding and details when container is wider */
@container (min-width: 800px) {
  .chart-container {
    padding: 2rem;
    margin: 2rem 0;
  }
  
  .chart-container .chart-title {
    font-size: 1.25rem;
  }
}
```

## Mobile-Specific Adjustments

The presentation system includes mobile-specific optimizations for better touch interaction and readability:

- **Larger touch targets** for navigation controls on small screens
- **Simplified layouts** that stack elements vertically on narrow viewports
- **Adapted navigation gestures** with swipe support for touchscreens
- **Larger base font size** for better readability on mobile devices
- **Optimized charts** that simplify visualizations for small screens

# Chart.js Integration

The Bootstrap integration enhances Chart.js visualization by automatically using Bootstrap theme colors and CSS variables. This ensures visual consistency between your UI elements and data visualizations.

## Chart Types

All Chart.js chart types are supported with theme-aware styling:

- **Bar charts** - Categorical comparisons
- **Line charts** - Trends over time
- **Pie/Doughnut charts** - Part-to-whole relationships
- **Radar charts** - Multivariate data on axes
- **Polar area charts** - Similar to pie but with varying radius
- **Bubble charts** - Three-dimensional data (x, y, size)
- **Scatter plots** - Correlation between variables
- **Mixed charts** - Combinations of chart types

## Theme-Aware Charts

Charts automatically adapt to the current theme by using Bootstrap CSS variables:

```javascript
// From presentation.js - Getting Bootstrap theme colors for charts
const getCssVariable = (varName, fallback) => {
  return getComputedStyle(document.documentElement)
    .getPropertyValue(varName).trim() || fallback;
};

// Chart colors from Bootstrap variables
const primaryColor = getCssVariable('--bs-primary', '#0d6efd');
const secondaryColor = getCssVariable('--bs-secondary', '#6c757d');
const successColor = getCssVariable('--bs-success', '#198754');
const bodyColor = getCssVariable('--bs-body-color', '#212529');
const borderColor = getCssVariable('--bs-border-color', '#dee2e6');
```

## Chart Configuration

Configure charts directly in your XML using the `<chart>` element with `<data>` and `<options>` child elements:

```xml
<chart type="bar" height="400px">
  <data>
    [
      {"segment": "Enterprise", "value": 250},
      {"segment": "Mid-market", "value": 150},
      {"segment": "SMB", "value": 100}
    ]
  </data>
  <options>
    {
      "plugins": {
        "title": {
          "display": true,
          "text": "Market Segments ($B)"
        },
        "tooltip": {
          "mode": "index",
          "intersect": false
        }
      },
      "scales": {
        "y": {
          "beginAtZero": true,
          "ticks": {
            "callback": "function(value) { return '$' + value + 'B'; }"
          }
        }
      }
    }
  </options>
</chart>
```

## New in 2025: Advanced Chart Features

- **Interactive Legends** - Charts now include interactive legends that allow users to toggle data series visibility by clicking on legend items
- **Enhanced Animations** - More sophisticated animations with sequential reveal of data points that sync with slide transitions
- **Responsive Font Sizing** - Chart labels and ticks now use responsive font sizing that adjusts automatically based on container size
- **Data Annotations** - Support for adding annotations to highlight specific points or regions on charts, with tooltip explanations

**Performance Tip**: For presentations with many charts, use the `loading="lazy"` attribute on slides to defer chart initialization until the slide is visible. This improves initial load time.
