# Animations & Transitions

Bootstrap-enhanced presentations include smooth animations and transitions for a more engaging experience.

## Slide Transitions

Control slide transitions using the `transition` attribute on slide elements:

```xml
<slide id="intro" type="title" transition="fade">
  <title>Introduction</title>
  <content>...</content>
</slide>

<slide id="features" type="standard" transition="slide">
  <title>Key Features</title>
  <content>...</content>
</slide>

<slide id="demo" type="image" transition="zoom">
  <title>Product Demo</title>
  <content>...</content>
</slide>
```

## Available Transitions

| Name | Description | Best Used For |
|------|-------------|--------------|
| `fade` | Simple opacity transition | General purpose, subtle transitions |
| `slide` | Horizontal slide from right to left | Sequential content, progressing through topics |
| `zoom` | Scaling transition from small to full size | Emphasizing important slides, focal points |
| `flip` | 3D flip effect | Before/after comparisons, contrasting ideas |
| `push` | New slide pushes the previous one out | Showing progression or replacement |
| `none` | Instant change without animation | When quick transitions are needed |

## Content Animations

Elements within slides can be animated using the `data-animate` attribute:

```xml
<p data-animate="fadeIn" data-delay="0.5">This paragraph fades in after 0.5 seconds</p>

<list type="bullet" data-animate="slideIn" data-direction="left">
  <item data-delay="0.2">First item slides in from the left after 0.2 seconds</item>
  <item data-delay="0.4">Second item slides in from the left after 0.4 seconds</item>
  <item data-delay="0.6">Third item slides in from the left after 0.6 seconds</item>
</list>

<image src="product.jpg" alt="Product" data-animate="zoomIn" data-delay="1.0" />
```

## Animation Options

| Attribute | Values | Description |
|-----------|--------|-------------|
| `data-animate` | `fadeIn`, `slideIn`, `zoomIn`, `bounce`, `flip` | Type of animation to apply |
| `data-delay` | Time in seconds (e.g., `0.5`) | Delay before animation starts |
| `data-duration` | Time in seconds (e.g., `1.0`) | Duration of the animation |
| `data-direction` | `left`, `right`, `top`, `bottom` | Direction for slide animations |
| `data-easing` | `linear`, `ease`, `ease-in`, `ease-out`, `cubic-bezier(...)` | Timing function for the animation |

**Accessibility Consideration**: Users can disable animations by enabling the "prefers-reduced-motion" setting in their operating system. Our presentation system respects this setting and automatically disables animations for these users.

# Accessibility

Our Bootstrap-enhanced presentation system meets WCAG 2.2 Level AA compliance, making presentations accessible to users with disabilities.

## Proper Semantic Markup

The XSL transformation generates semantically correct HTML with proper heading levels, landmark regions, and meaningful structure:

```html
<!-- Generated from XML via XSL transformation -->
<div id="some-slide" class="slide" aria-hidden="false" role="region" aria-roledescription="slide">
  <header>
    <h2 id="slide-title-some-slide">Slide Title</h2>
  </header>
  
  <div class="slide-content">
    <p>Slide content with proper markup</p>
    
    <!-- Proper list semantics -->
    <ul>
      <li>List item one</li>
      <li>List item two</li>
    </ul>
    
    <!-- Images with alt text -->
    <figure>
      <img src="example.jpg" alt="Descriptive alt text" />
      <figcaption>Image caption</figcaption>
    </figure>
  </div>
</div>
```

## ARIA Attributes

The presentation includes appropriate ARIA attributes to enhance screen reader navigation:

- `aria-hidden` - Applied to inactive slides to prevent screen reader announcement
- `aria-current="slide"` - Indicates the currently active slide
- `aria-live="polite"` - Announces slide changes to screen reader users
- `aria-controls` - Links navigation controls to the elements they affect
- `aria-label` and `aria-labelledby` - Provides accessible names for UI elements
- `role` attributes - Defines the purpose of custom interactive elements

## Keyboard Navigation

Full keyboard support for navigating presentations:

| Key | Function |
|-----|----------|
| → or Space or Page Down | Next slide |
| ← or Page Up | Previous slide |
| Home | First slide |
| End | Last slide |
| F | Toggle fullscreen |
| N | Toggle speaker notes |
| Tab | Navigate interactive elements within slide |
| Esc | Exit fullscreen or close speaker notes |

## Focus Management

The presentation system manages focus appropriately when navigating between slides, ensuring that keyboard users can always determine where they are:

- Focus moves to the slide title when switching slides
- Focus is trapped within modal dialogs when active
- Focus returns to its previous position when dialogs are closed
- Focus indicators are clearly visible with high contrast

## Color Contrast

All text and interactive elements maintain a minimum contrast ratio of 4.5:1 for normal text and 3:1 for large text, as required by WCAG 2.2 Level AA. The Bootstrap themes have been verified for proper contrast in both light and dark modes.

## Accessible Charts

Charts include accessibility enhancements:

- **Alternative text descriptions** that summarize the chart's data
- **Keyboard-accessible data points** for exploring charts without a mouse
- **Data tables** that provide the raw data in an accessible format

```xml
<chart type="bar" height="400px" summary="Bar chart showing market segments: Enterprise at $250B, Mid-market at $150B, and SMB at $100B">
  <!-- Chart data and options -->
  <data>...</data>
  <options>...</options>
  
  <!-- Optional data table for screen readers -->
  <data-table>
    <header>
      <cell>Segment</cell>
      <cell>Value ($ Billions)</cell>
    </header>
    <row>
      <cell>Enterprise</cell>
      <cell>250</cell>
    </row>
    <row>
      <cell>Mid-market</cell>
      <cell>150</cell>
    </row>
    <row>
      <cell>SMB</cell>
      <cell>100</cell>
    </row>
  </data-table>
</chart>
```

**New in 2025**: The presentation system now includes an automated accessibility checker that validates your presentation against WCAG 2.2 Level AA guidelines and provides recommendations for improvement.
