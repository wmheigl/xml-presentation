# XML/XSL Presentation System with Bootstrap

## Table of Contents
1. [Introduction](#introduction)
2. [Getting Started](#getting-started)
3. [Presentation Structure](#presentation-structure)
4. [Slide Types](#slide-types)
5. [Layout Components](#layout-components)
   - [Container Components](#container-components)
   - [Grid Components](#grid-components)
   - [Positioning Components](#positioning-components)
   - [Special Layout Components](#special-layout-components)
6. [Content Components](#content-components)
   - [Text and Typography Components](#text-and-typography-components)
   - [Media Components](#media-components)
   - [Interactive Components](#interactive-components)
   - [Data Display Components](#data-display-components)
   - [Form Components](#form-components)
   - [Visualization Components](#visualization-components)
   - [Specialized Components](#specialized-components)
7. [Styling and Themes](#styling-and-themes)
8. [Helper Functions](#helper-functions)
9. [Best Practices](#best-practices)
10. [Examples](#examples)
   - [Feature Comparison Slide](#feature-comparison-slide)
   - [Interactive FAQ Slide](#interactive-faq-slide)
   - [Data Visualization Slide](#data-visualization-slide)
   - [Company Overview Presentation](#company-overview)
11. [Conclusion](#conclusion)

## Introduction

The XML/XSL Presentation System is a modern framework that allows you to create beautiful, responsive presentations while maintaining separation of content and presentation. It uses XML for content, XSL for transformation, and Bootstrap for styling.

### Key Features

- **Content/Presentation Separation**: Content in XML, styling with Bootstrap CSS
- **Responsive Design**: Automatically adapts to different screen sizes and devices
- **Theme Support**: Light, dark, and custom themes via Bootstrap's theme system
- **Chart.js Integration**: Data visualization with charts that match your theme
- **Speaker Notes**: Built-in support for presenter notes
- **Keyboard Navigation**: Full keyboard shortcut support
- **Print-friendly**: Optimized for printing/PDF export

### Semantic Component Approach

This system uses a semantic component approach where you define the purpose and structure of your content using semantic XML elements and attributes. The XSL transformation then converts these semantic descriptions into appropriate Bootstrap classes and HTML elements.

For example, instead of writing:
```html
<div class="col-md-6 border-end">
  <div class="h-100 p-3">Content</div>
</div>
```

You would write:
```xml
<split ratio="50-50" division="line">
  <left>Content</left>
  <right>More content</right>
</split>
```

This separation allows you to focus on the content and its logical structure rather than worrying about specific CSS classes and styling details.

## Getting Started

### Running the Presentation

Due to browser security restrictions, you **must** serve the files using an HTTP server rather than opening them directly from the filesystem. This is because the system uses AJAX requests to load XML and XSL files, which are blocked by CORS policies when using the `file://` protocol.

There are several easy ways to start a local HTTP server:

```bash
# Python 3
python -m http.server 8000

# Node.js http-server
npx http-server -p 8000

# PHP
php -S localhost:8000
```

Then open your browser and navigate to: `http://localhost:8000`

### Creating Your First Presentation

Create a new XML file in the `examples` directory with the following structure:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<presentation id="my-first-presentation" theme="light">
  <metadata>
    <title>My First Presentation</title>
    <author>Your Name</author>
    <brand>
      <color name="primary">#0d6efd</color>
      <color name="secondary">#6c757d</color>
    </brand>
  </metadata>
  
  <slide id="title-slide" type="title">
    <title>My First Presentation</title>
    <content>
      <p>Created with XML/XSL Presentation System</p>
    </content>
    <notes>Welcome to my first presentation.</notes>
  </slide>
  
  <slide id="overview" type="standard">
    <title>Overview</title>
    <content>
      <list type="unordered">
        <item>Introduction</item>
        <item>Main Points</item>
        <item>Conclusion</item>
      </list>
    </content>
  </slide>

  <!-- Add more slides as needed -->
</presentation>
```

Update the `config.xmlFilename` value in the `index.html` file to point to your new XML file.

## Presentation Structure

The root structure of a presentation XML file:

```xml
<presentation id="my-presentation" theme="light">
  <metadata>
    <!-- Presentation metadata here -->
  </metadata>
  
  <!-- Slides go here -->
  <slide>...</slide>
  <slide>...</slide>
</presentation>
```

### Presentation Attributes

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `id` | Unique identifier for the presentation | Any valid HTML ID | Required |
| `theme` | The color theme for the presentation | "light", "dark", or custom | "light" |

### Metadata

The metadata section contains information about the presentation:

```xml
<metadata>
  <title>Presentation Title</title>
  <author>Author Name</author>
  <date>May 15, 2025</date>
  <description>A brief description of the presentation</description>
  <brand>
    <color name="primary">#0d6efd</color>
    <color name="secondary">#6c757d</color>
    <color name="accent">#20c997</color>
    <color name="text">#212529</color>
    <color name="background">#ffffff</color>
  </brand>
</metadata>
```

## Slide Types

The presentation system supports several slide types for different content purposes.

### Common Slide Structure

All slides share this common structure:

```xml
<slide id="slide-id" type="slide-type">
  <title>Slide Title</title>
  <content>
    <!-- Slide content goes here -->
  </content>
  <notes>Speaker notes for this slide</notes>
</slide>
```

### Title Slide

Title slides are used for the main title of the presentation.

```xml
<slide id="title-slide" type="title">
  <title>Presentation Title</title>
  <content>
    <p>Subtitle or additional information</p>
  </content>
</slide>
```

### Section Slide

Section slides mark the beginning of a new section in the presentation.

```xml
<slide id="section-introduction" type="section">
  <title>Introduction</title>
  <content>
    <p>Brief introduction to this section</p>
  </content>
</slide>
```

### Standard Slide

Standard slides are the most common slide type for regular content.

```xml
<slide id="main-points" type="standard">
  <title>Main Points</title>
  <content>
    <list type="unordered">
      <item>Point 1</item>
      <item>Point 2</item>
      <item>Point 3</item>
    </list>
  </content>
</slide>
```

### Image Slide

Image slides showcase an image with supporting text.

```xml
<slide id="product-image" type="image">
  <title>Our Product</title>
  <image src="images/product.jpg" alt="Product image" />
  <content>
    <p>This is our flagship product with innovative features.</p>
  </content>
</slide>
```

Alternatively, you can use a full-screen background image:

```xml
<slide id="hero-image" type="image">
  <background-image src="images/background.jpg" alt="Background image" />
  <title>Our Vision</title>
  <content>
    <overlay position="center" opacity="medium" padding="large">
      <h2>Transforming the Industry</h2>
      <p>Our innovative approach is changing how people work.</p>
    </overlay>
  </content>
</slide>
```

### Chart Slide

Chart slides display data visualizations.

```xml
<slide id="sales-chart" type="chart">
  <title>Quarterly Sales</title>
  <content>
    <p>Our sales have increased by 25% year-over-year.</p>
  </content>
  <chart type="bar">
    <data>
      {
        labels: ['Q1', 'Q2', 'Q3', 'Q4'],
        datasets: [{
          label: 'Sales',
          data: [12, 19, 15, 25],
          backgroundColor: 'rgba(13, 110, 253, 0.6)'
        }]
      }
    </data>
  </chart>
</slide>
```

### Quote Slide

Quote slides feature a prominent quotation.

```xml
<slide id="inspirational-quote" type="quote">
  <quote>Innovation distinguishes between a leader and a follower.</quote>
  <attribution>Steve Jobs</attribution>
  <source>Apple Keynote, 2007</source>
  <content>
    <p>This philosophy guides our product development process.</p>
  </content>
</slide>
```

## Layout Components

Layout components control the arrangement and structure of content within slides.

### Container Components

#### `<container>`

Provides a wrapper for content with control over width, padding, and background.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `type` | Container width behavior | "fluid" (full-width), "fixed" (fixed-width), "center" (centered) | "fixed" |
| `padding` | Amount of internal padding | "none", "small", "medium", "large" | "medium" |
| `margin` | Amount of external margin | "none", "small", "medium", "large" | "medium" |
| `background` | Background color | "none", "light", "dark", "primary", "secondary", "accent" | "none" |

**Example:**

```xml
<container type="fixed" padding="medium" background="light">
  <h2>Section Title</h2>
  <p>Container content goes here.</p>
</container>
```

#### `<section>`

Represents a logical section within a slide.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `id` | Unique identifier | Any valid HTML ID | Required |
| `title` | Section title (optional) | Text | None |
| `visibility` | Visibility control | "visible", "hidden", "print-only" | "visible" |
| `importance` | Visual importance level | "primary", "secondary", "tertiary" | None |

**Example:**

```xml
<section id="key-features" importance="primary">
  <h3>Key Features</h3>
  <p>Our product offers several innovative features.</p>
</section>
```

#### `<layout>`

General layout container that controls arrangement direction. It serves as a flexible layout wrapper that provides semantic control over:

- Arrangement direction (vertical, horizontal, centered, or asymmetric)
- Content balance (even distribution, left-heavy, right-heavy)
- Spacing between items (compact, comfortable, spacious)

It acts as a more customizable alternative to basic containers, allowing presenters to semantically describe how content should be arranged without directly using CSS flexbox properties.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `type` | Layout arrangement | "default", "vertical", "horizontal", "centered", "asymmetric" | "default" |
| `balance` | Content weight distribution | "even", "left-heavy", "right-heavy" | "even" |
| `spacing` | Space between items | "compact", "comfortable", "spacious" | "comfortable" |

**Use Cases and Examples:**

1. Vertical Content Arrangement

```xml
<layout type="vertical" spacing="comfortable">
  <h2>Key Features</h2>
  <p>Our product offers several benefits:</p>
  <list type="unordered">
    <item>Feature 1</item>
    <item>Feature 2</item>
    <item>Feature 3</item>
  </list>
</layout>
```

This stacks the heading, paragraph, and list vertically with comfortable spacing.

2. Horizontal Feature Display

```xml
<layout type="horizontal" balance="even" spacing="spacious">
  <feature icon="rocket" title="Fast">
    <p>Lightning quick performance</p>
  </feature>
  <feature icon="lock" title="Secure">
    <p>Enterprise-grade security</p>
  </feature>
  <feature icon="brush" title="Beautiful">
    <p>Sleek modern design</p>
  </feature>
</layout>
```

This arranges the feature boxes horizontally with even spacing between them.

3. Centered Content

```xml
<layout type="centered">
  <blockquote>
    <text>Innovation distinguishes between a leader and a follower.</text>
    <attribution>Steve Jobs</attribution>
  </blockquote>
</layout>
```

This centers the quote both horizontally and vertically within its container.

4. Asymmetric Content with Weight

```xml
<layout type="asymmetric" balance="left-heavy">
  <div class="main-point">
    <h3>Primary Benefit</h3>
    <p>Detailed explanation of our main value proposition...</p>
  </div>
  <div class="supporting-image">
    <img src="benefit.jpg" alt="Product benefit demonstration" />
  </div>
</layout>
```

This creates an asymmetric layout with more emphasis on the left side content.

**Difference Between `<layout>` and Other Components**

- vs. `<container>`: While <container> focuses on wrapping content with specific width, padding, and background, `<layout>` focuses on how items are arranged relative to each other.
- vs. `<grid>`/`<column>`: The grid system is specifically for creating column-based layouts with precise width control. <layout> is more for general-purpose arrangement when you don't need the complexity of a full grid.
- vs. `<flex-container>`: `<layout>` is a higher-level abstraction that uses simple semantic attributes, while `<flex-container>` gives more direct control over flexbox properties.

The `<layout>` component serves as a middle ground between simple containers and more complex grid/flexbox layouts, making it useful for quickly applying common layout patterns using semantic attributes rather than Bootstrap-specific classes.

### Grid Components

#### `<grid>`

Row-based grid system using Bootstrap's grid.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `columns` | Number of columns | 1-12 | 12 |
| `gap` | Space between columns | "none", "small", "medium", "large" | "medium" |
| `alignment` | Horizontal alignment | "start", "center", "end", "between", "around" | None |
| `responsiveness` | Responsive behavior | "all", "desktop-only", "mobile-only" | "all" |

**Example:**

```xml
<grid columns="3" gap="medium" alignment="center">
  <!-- Columns go here -->
</grid>
```

#### `<column>`

Individual column within a grid.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `span` | Column width | 1-12 | Equal width |
| `offset` | Column offset | 0-11 | 0 |
| `alignment` | Vertical alignment | "start", "center", "end", "stretch" | None |
| `visibility` | Responsive visibility | "always", "desktop-only", "tablet-only", "mobile-only" | "always" |

**Example:**

```xml
<grid columns="12" gap="medium">
  <column span="4">
    <p>First column (4/12 width)</p>
  </column>
  <column span="8">
    <p>Second column (8/12 width)</p>
  </column>
</grid>
```

#### `<flex-container>`

Flexible container using CSS flexbox.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `direction` | Flow direction | "row", "column", "row-reverse", "column-reverse" | "row" |
| `wrap` | Wrapping behavior | "nowrap", "wrap", "wrap-reverse" | "wrap" |
| `justify` | Main axis alignment | "start", "center", "end", "between", "around" | "start" |
| `align` | Cross axis alignment | "start", "center", "end", "stretch", "baseline" | "start" |

**Example:**

```xml
<flex-container direction="row" wrap="wrap" justify="between" align="center">
  <div>First flex item</div>
  <div>Second flex item</div>
  <div>Third flex item</div>
</flex-container>
```

### Positioning Components

#### `<alignment>`

Controls the alignment of content.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `horizontal` | Horizontal alignment | "left", "center", "right" | "left" |
| `vertical` | Vertical alignment | "top", "middle", "bottom" | None |
| `text` | Text alignment | "left", "center", "right", "justify" | None |

**Example:**

```xml
<alignment horizontal="center" text="center">
  <h2>Centered Heading</h2>
  <p>This text will be centered.</p>
</alignment>
```

#### `<spacer>`

Creates empty space for controlling whitespace.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `size` | Amount of space | "small", "medium", "large", "custom" | "medium" |
| `orientation` | Direction of space | "horizontal", "vertical" | "vertical" |
| `visibility` | Responsive visibility | "always", "desktop-only", "mobile-only" | "always" |

**Example:**

```xml
<p>First paragraph</p>
<spacer size="medium" orientation="vertical" />
<p>Second paragraph with space above</p>
```

#### `<overlay>`

Content positioned over another element.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `position` | Position on parent | "top", "right", "bottom", "left", "center" | "center" |
| `opacity` | Background opacity | "light", "medium", "dark" | "medium" |
| `padding` | Internal padding | "none", "small", "medium", "large" | "medium" |

**Example:**

```xml
<div style="position: relative;">
  <img src="background.jpg" alt="Background" />
  <overlay position="center" opacity="medium" padding="large">
    <h2>Overlay Title</h2>
    <p>Content displayed over the background image.</p>
  </overlay>
</div>
```

### Special Layout Components

#### `<split>`

Two-column layout with customizable ratio.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `ratio` | Column width ratio | "50-50", "60-40", "70-30", "80-20", "auto" | "50-50" |
| `direction` | Split direction | "horizontal", "vertical" | "horizontal" |
| `division` | Visual divider | "line", "space", "none" | "none" |

**Example:**

```xml
<split ratio="60-40" division="line">
  <left>
    <h3>Left Column (60%)</h3>
    <p>Content in the left column.</p>
  </left>
  <right>
    <h3>Right Column (40%)</h3>
    <p>Content in the right column.</p>
  </right>
</split>
```

#### `<comparison>`

Side-by-side comparison layout.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `type` | Comparison type | "before-after", "product", "pros-cons", "timeline" | "before-after" |
| `labels` | Show labels | "visible", "hidden" | "visible" |
| `divider` | Division style | "line", "arrow", "none" | "line" |

**Example:**

```xml
<comparison type="before-after" labels="visible">
  <before>
    <image src="before.jpg" alt="Before implementation" />
    <caption>Previous System</caption>
  </before>
  <after>
    <image src="after.jpg" alt="After implementation" />
    <caption>New System</caption>
  </after>
</comparison>
```

#### `<timeline>`

Chronological timeline layout.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `orientation` | Display direction | "horizontal", "vertical" | "vertical" |
| `alignment` | Content alignment | "center", "alternate", "left", "right" | "center" |
| `markers` | Time point markers | "dots", "numbers", "icons", "none" | "dots" |

**Example:**

```xml
<timeline orientation="horizontal" markers="dots">
  <event date="Q1 2025">
    <title>Alpha Release</title>
    <description>Initial feature set</description>
  </event>
  <event date="Q2 2025">
    <title>Beta Testing</title>
    <description>User feedback phase</description>
  </event>
  <event date="Q3 2025">
    <title>Public Launch</title>
    <description>Full market release</description>
  </event>
</timeline>
```

#### `<masonry>`

Pinterest-style grid with variable height items.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `columns` | Number of columns | 1-6 | 3 |
| `gap` | Space between items | "none", "small", "medium", "large" | "small" |

**Example:**

```xml
<masonry columns="3" gap="small">
  <item>
    <image src="project1.jpg" alt="Project 1" />
    <h4>Project Alpha</h4>
  </item>
  <item>
    <image src="project2.jpg" alt="Project 2" />
    <h4>Project Beta</h4>
    <p>Award-winning design</p>
  </item>
  <item>
    <image src="project3.jpg" alt="Project 3" />
    <h4>Project Gamma</h4>
  </item>
</masonry>
```

## Content Components

Content components represent the actual content elements that appear within your presentation.

### Text and Typography Components

#### `<alert>`

Attention-grabbing message box.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `type` | Alert style | "primary", "secondary", "success", "danger", "warning", "info", "light", "dark" | "primary" |
| `dismissible` | Can be closed | "true", "false" | "false" |
| `icon` | Show icon | "true", "false" | "false" |

**Example:**

```xml
<alert type="warning" icon="true">
  <title>Attention Required</title>
  <p>This is an important notice about your account.</p>
</alert>
```

#### `<badge>`

Small label for highlighting information.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `type` | Badge color | "primary", "secondary", "success", "danger", "warning", "info", "light", "dark" | "primary" |
| `size` | Badge size | "small", "normal", "large" | "normal" |
| `pill` | Rounded shape | "true", "false" | "false" |

**Example:**

```xml
<h2>Product Features <badge type="primary" pill="true">New</badge></h2>
```

#### `<blockquote>`

Quoted content with attribution.

**Content Elements:**

- `<text>`: The quotation text
- `<attribution>`: Who said the quote
- `<source>`: Where the quote is from (optional)

**Example:**

```xml
<blockquote>
  <text>The best way to predict the future is to invent it.</text>
  <attribution>Alan Kay</attribution>
  <source>1971 Xerox PARC meeting</source>
</blockquote>
```

#### `<callout>`

Highlighted content block with border.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `type` | Callout style | "primary", "secondary", "success", "danger", "warning", "info" | "primary" |
| `title` | Callout title | Text | None |
| `icon` | Icon name | Bootstrap icon name | None |

**Example:**

```xml
<callout type="info" title="Did You Know?" icon="info-circle">
  <p>The average person spends 90,000 hours at work over their lifetime.</p>
</callout>
```

### Media Components

#### `<image>`

Image with optional caption.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `src` | Image source URL | URL | Required |
| `alt` | Alt text | Text | Required |
| `width` | Image width | CSS width value | Auto |
| `height` | Image height | CSS height value | Auto |

**Content Elements:**

- `<caption>`: Image caption (optional)

**Example:**

```xml
<image src="product.jpg" alt="Our product">
  <caption>Figure 1: Our flagship product</caption>
</image>
```

#### `<video>`

Video player with multiple source options.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `type` | Video source type | "youtube", "vimeo", or source file | Source file |
| `id` | Video ID (for YouTube/Vimeo) | Platform-specific ID | None |
| `src` | Video source URL (for direct files) | URL | None |
| `format` | Video format (for direct files) | "mp4", "webm", etc. | "mp4" |
| `aspect-ratio` | Player aspect ratio | "16x9", "4x3", "21x9", "1x1" | "16x9" |
| `poster` | Poster image URL | URL | None |
| `autoplay` | Autoplay video | "true", "false" | "false" |
| `loop` | Loop video | "true", "false" | "false" |

**Content Elements:**

- `<caption>`: Video caption (optional)

**Example:**

```xml
<!-- YouTube video -->
<video type="youtube" id="dQw4w9WgXcQ" aspect-ratio="16x9">
  <caption>Product demonstration video</caption>
</video>

<!-- Direct video file -->
<video src="videos/product-demo.mp4" format="mp4" poster="images/poster.jpg">
  <caption>Product demonstration video</caption>
</video>
```

#### `<audio>`

Audio player for sound files.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `src` | Audio source URL | URL | Required |
| `format` | Audio format | "mp3", "wav", "ogg", etc. | "mp3" |
| `autoplay` | Autoplay audio | "true", "false" | "false" |
| `loop` | Loop audio | "true", "false" | "false" |

**Content Elements:**

- `<caption>`: Audio caption (optional)

**Example:**

```xml
<audio src="sounds/notification.mp3" format="mp3">
  <caption>Our new notification sound</caption>
</audio>
```

#### `<gallery>`

Collection of images as grid or carousel.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `type` | Gallery display type | "grid", "carousel" | "grid" |

**Child Elements:**

- `<image>`: Images to display in the gallery

**Example:**

```xml
<gallery type="carousel">
  <image src="product1.jpg" alt="Product 1">
    <caption>Front view</caption>
  </image>
  <image src="product2.jpg" alt="Product 2">
    <caption>Side view</caption>
  </image>
  <image src="product3.jpg" alt="Product 3">
    <caption>Top view</caption>
  </image>
</gallery>
```

### Interactive Components

#### `<button>`

Clickable button element.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `type` | Button style | "primary", "secondary", "success", "danger", "warning", "info", "light", "dark", "link" | "primary" |
| `size` | Button size | "small", "normal", "large" | "normal" |
| `outline` | Outlined style | "true", "false" | "false" |
| `action` | JavaScript action | Function name or code | None |
| `disabled` | Disabled state | "true", "false" | "false" |

**Example:**

```xml
<button type="primary" size="large" action="showDetails">
  Learn More
</button>
```

#### `<tabs>`

Tabbed content display.

**Child Elements:**

- `<tab>`: Individual tab panel

**Tab Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `title` | Tab label | Text | Required |

**Example:**

```xml
<tabs>
  <tab title="Overview">
    <p>General product overview content...</p>
  </tab>
  <tab title="Features">
    <list type="unordered">
      <item>Feature 1</item>
      <item>Feature 2</item>
      <item>Feature 3</item>
    </list>
  </tab>
  <tab title="Specifications">
    <p>Technical specifications content...</p>
  </tab>
</tabs>
```

#### `<accordion>`

Collapsible content sections.

**Child Elements:**

- `<item>`: Individual accordion item

**Item Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `title` | Item header | Text | Required |

**Example:**

```xml
<accordion>
  <item title="What features are included?">
    <p>Our product includes the following features...</p>
  </item>
  <item title="How much does it cost?">
    <p>Our pricing starts at $19/month...</p>
  </item>
  <item title="Is there a free trial?">
    <p>Yes, we offer a 14-day free trial...</p>
  </item>
</accordion>
```

#### `<modal>`

Popup dialog box.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `trigger-text` | Button text | Text | "Open" |
| `title` | Modal title | Text | Required |
| `action-button` | Show action button | "true", "false" | "false" |
| `action-text` | Action button text | Text | "Save" |

**Child Elements:**

- `<content>`: Modal body content

**Example:**

```xml
<modal trigger-text="Show Details" title="Product Details" action-button="true" action-text="Purchase">
  <content>
    <p>Detailed information about our product...</p>
  </content>
</modal>
```

#### `<tooltip>`

Small popup hint on hover.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `text` | Tooltip content | Text | Required |
| `position` | Display position | "top", "right", "bottom", "left" | "top" |

**Example:**

```xml
<tooltip text="Click to learn more" position="top">
  <button type="primary">More Info</button>
</tooltip>
```

### Data Display Components

#### `<list>`

Ordered or unordered list of items.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `type` | List type | "ordered", "unordered", "description" | "unordered" |
| `style` | List styling | "default", "unstyled", "inline", "group" | "default" |

**Child Elements:**

- `<item>`: List item
- For description lists: `<term>` and `<definition>` within each item

**Example:**

```xml
<!-- Unordered list -->
<list type="unordered">
  <item>First item</item>
  <item>Second item</item>
  <item>Third item</item>
</list>

<!-- Description list -->
<list type="description">
  <item>
    <term>Term 1</term>
    <definition>Definition of term 1</definition>
  </item>
  <item>
    <term>Term 2</term>
    <definition>Definition of term 2</definition>
  </item>
</list>
```

#### `<card>`

Content container with multiple sections.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `style` | Card appearance | "outline", "subtle", "raised", "flat" | "outline" |
| `background` | Card background | "primary", "secondary", "light", "dark" | None |

**Child Elements:**

- `<image>`: Card image (with position="top", "bottom", or "overlay")
- `<header>`: Card header content
- `<title>`: Card title
- `<subtitle>`: Card subtitle
- `<content>`: Card body content
- `<footer>`: Card footer content

**Example:**

```xml
<card style="raised">
  <image src="product.jpg" alt="Product image" position="top" />
  <title>Product Name</title>
  <subtitle>Premium Edition</subtitle>
  <content>
    <p>This is our premium product with advanced features.</p>
    <button type="primary">Buy Now</button>
  </content>
  <footer>
    <p>Free shipping on orders over $50</p>
  </footer>
</card>
```

#### `<table>`

Tabular data display.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `striped` | Alternating row colors | "true", "false" | "false" |
| `bordered` | Table borders | "true", "false" | "false" |
| `hoverable` | Highlight on hover | "true", "false" | "false" |
| `small` | Compact table | "true", "false" | "false" |
| `responsive` | Horizontal scrolling | "true", "false" | "false" |

**Child Elements:**

- `<caption>`: Table caption
- `<thead>`: Table header
- `<tbody>`: Table body
- `<tfoot>`: Table footer (optional)

**Example:**

```xml
<table striped="true" bordered="true" hoverable="true">
  <caption>Quarterly Sales Data</caption>
  <thead>
    <tr>
      <th>Quarter</th>
      <th>Revenue</th>
      <th>Growth</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Q1 2025</td>
      <td>$1.2M</td>
      <td>5.2%</td>
    </tr>
    <tr>
      <td>Q2 2025</td>
      <td>$1.8M</td>
      <td>12.4%</td>
    </tr>
  </tbody>
  <tfoot>
    <tr>
      <td>Total</td>
      <td>$3.0M</td>
      <td>8.8%</td>
    </tr>
  </tfoot>
</table>
```

#### `<data-table>`

Enhanced table for data presentation.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `striped` | Alternating row colors | "true", "false" | "false" |
| `bordered` | Table borders | "true", "false" | "false" |
| `hoverable` | Highlight on hover | "true", "false" | "false" |

**Child Elements:**

- `<header>`: Contains `<column>` elements for the header
- `<row>`: Table rows containing `<cell>` elements

**Cell Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `type` | Cell styling | "highlight", "success", "danger", "warning", "info" | None |
| `width` | Column width | CSS width value | Auto |

**Example:**

```xml
<data-table striped="true" bordered="true">
  <header>
    <column width="20%">Product</column>
    <column>Description</column>
    <column width="15%">Price</column>
    <column width="15%">Status</column>
  </header>
  <row>
    <cell>Product A</cell>
    <cell>Our flagship product with premium features</cell>
    <cell>$199</cell>
    <cell type="success">In Stock</cell>
  </row>
  <row>
    <cell>Product B</cell>
    <cell>Entry-level solution for small businesses</cell>
    <cell>$99</cell>
    <cell type="danger">Out of Stock</cell>
  </row>
</data-table>
```

#### `<progress-bar>`

Visual indicator of completion or process.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `value` | Completion percentage | 0-100 | Required |
| `type` | Bar color | "primary", "secondary", "success", "danger", "warning", "info" | "primary" |
| `striped` | Striped pattern | "true", "false" | "false" |
| `animated` | Animated stripes | "true", "false" | "false" |
| `show-label` | Show percentage | "true", "false" | "false" |

**Example:**

```xml
<progress-bar value="75" type="success" striped="true" show-label="true" />
```

#### `<stat>`

Highlight a key metric or statistic.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `value` | The statistic value | Text/Number | Required |
| `unit` | Unit of measurement | Text | None |
| `label` | Description label | Text | Required |
| `icon` | Bootstrap icon name | Icon name | None |
| `iconColor` | Icon color | "primary", "success", etc. | None |
| `trend` | Change indicator | "+10%", "-5%", etc. | None |

**Example:**

```xml
<stat value="85" unit="%" label="Customer Satisfaction" icon="star" iconColor="warning" trend="+12%" />
```

### Form Components

#### `<form>`

Container for form elements.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `submit-text` | Submit button text | Text | "Submit" |

**Example:**

```xml
<form submit-text="Send Message">
  <!-- Form fields go here -->
</form>
```

#### `<form-group>`

Label and input field combination.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `id` | Field identifier | Any valid HTML ID | Required |
| `label` | Field label | Text | Required |
| `type` | Input type | "text", "email", "number", "password", "textarea", "select" | "text" |
| `placeholder` | Placeholder text | Text | None |
| `required` | Required field | "true", "false" | "false" |
| `rows` | Textarea rows | Number | 3 |
| `value` | Default value | Text | None |

**Child Elements:**

- `<hint>`: Help text below the field
- `<option>`: Options for select type

**Example:**

```xml
<form-group id="name" type="text" label="Your Name" required="true" placeholder="John Doe">
  <hint>Enter your full name as it appears on your ID.</hint>
</form-group>

<form-group id="message" type="textarea" label="Your Message" rows="5" required="true">
  <hint>Please be as specific as possible.</hint>
</form-group>

<form-group id="department" type="select" label="Department">
  <option value="sales">Sales</option>
  <option value="support" selected="true">Support</option>
  <option value="other">Other</option>
</form-group>
```

#### `<check-group>`

Group of checkboxes or radio buttons.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `label` | Group label | Text | Required |
| `type` | Input type | "checkbox", "radio" | "checkbox" |
| `name` | Input name | Text | Required |
| `required` | Required selection | "true", "false" | "false" |

**Child Elements:**

- `<item>`: Individual checkbox/radio item

**Item Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `value` | Option value | Text | Required |
| `checked` | Default state | "true", "false" | "false" |

**Example:**

```xml
<check-group label="Interests" type="checkbox" name="interests">
  <item value="technology" checked="true">Technology</item>
  <item value="business">Business</item>
  <item value="design">Design</item>
</check-group>

<check-group label="Preferred Contact" type="radio" name="contact" required="true">
  <item value="email" checked="true">Email</item>
  <item value="phone">Phone</item>
  <item value="mail">Mail</item>
</check-group>
```

### Visualization Components

#### `<chart-container>`

Wrapper for Chart.js visualizations.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `type` | Chart type | "bar", "line", "pie", "doughnut", "radar", "polarArea", "bubble", "scatter" | Required |
| `title` | Chart title | Text | None |
| `height` | Chart height | CSS height value | "300px" |

**Child Elements:**

- `<data>`: JSON data for the chart
- `<options>`: JSON options for the chart (optional)
- `<caption>`: Chart caption (optional)

**Example:**

```xml
<chart-container type="bar" title="Monthly Revenue" height="400px">
  <data>
    {
      labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
      datasets: [{
        label: 'Revenue',
        data: [12, 19, 3, 5, 2, 3],
        backgroundColor: 'rgba(13, 110, 253, 0.6)'
      }]
    }
  </data>
  <options>
    {
      scales: {
        y: {
          beginAtZero: true
        }
      }
    }
  </options>
  <caption>Monthly revenue for first half of 2025.</caption>
</chart-container>
```

#### `<code>`

Code display with syntax highlighting.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `language` | Programming language | "javascript", "python", "xml", "css", "html", etc. | "plaintext" |
| `caption` | Code caption | Text | None |

**Example:**

```xml
<code language="javascript" caption="Example JavaScript function">
function calculateTotal(items) {
  return items.reduce((total, item) => total + item.price, 0);
}
</code>
```

#### `<math>`

Mathematical formula using LaTeX syntax.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `display` | Display mode | "inline", "block" | "inline" |

**Example:**

```xml
<p>The quadratic formula is <math>x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}</math> where a, b, and c are coefficients.</p>

<math display="block">
\int_{a}^{b} f(x) \, dx = F(b) - F(a)
</math>
```

#### `<icon>`

Bootstrap icon display.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `name` | Bootstrap icon name | Icon name | Required |
| `size` | Icon size | CSS size value | None |
| `color` | Icon color | "primary", "secondary", "success", etc. | None |

**Example:**

```xml
<icon name="check-circle" size="2em" color="success" />
```

### Specialized Components

#### `<feature>`

Feature box with icon and title.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `icon` | Bootstrap icon name | Icon name | None |
| `title` | Feature title | Text | Required |
| `iconColor` | Icon color | "primary", "secondary", "success", etc. | None |

**Example:**

```xml
<feature icon="shield-lock" title="Enterprise Security" iconColor="primary">
  <p>Bank-grade encryption and advanced security protocols protect your data.</p>
</feature>
```

#### `<quote-card>`

Styled quotation card.

**Child Elements:**

- `<quote>`: The quotation text
- `<attribution>`: Who said the quote
- `<role>`: Person's role or title (optional)
- `<image>`: Person's image (optional)

**Example:**

```xml
<quote-card>
  <quote>This product has completely transformed how our team works.</quote>
  <attribution>Jane Smith</attribution>
  <role>CEO, Acme Corp</role>
  <image src="jane-smith.jpg" alt="Jane Smith" />
</quote-card>
```

#### `<product-feature>`

Showcase a product feature with image and text.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `title` | Feature title | Text | Required |
| `image-position` | Image placement | "left", "right" | "left" |
| `badge` | Badge text | Text | None |
| `action-text` | Button text | Text | None |
| `action-url` | Button URL | URL | None |

**Child Elements:**

- `<image>`: Product image
- Other content elements

**Example:**

```xml
<product-feature title="AI-Powered Insights" image-position="right" 
                badge="New" action-text="Learn More" action-url="#ai">
  <image src="ai-insights.jpg" alt="AI dashboard" />
  <p>Our AI-powered analytics provide real-time insights to help you make better decisions.</p>
  <list type="unordered">
    <item>Predictive forecasting</item>
    <item>Anomaly detection</item>
    <item>Automated reporting</item>
  </list>
</product-feature>
```

#### `<pricing-plan>`

Pricing option display.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `name` | Plan name | Text | Required |
| `price` | Plan price | Number | Required |
| `currency` | Currency symbol | "$", "€", "£", etc. | "$" |
| `period` | Billing period | "month", "year", etc. | "month" |
| `featured` | Highlight plan | "true", "false" | "false" |
| `action-text` | Button text | Text | "Select Plan" |
| `action-url` | Button URL | URL | "#" |

**Child Elements:**

- `<feature>`: Plan feature with included attribute ("true" or "false")

**Example:**

```xml
<pricing-plan name="Professional" price="49" currency="$" period="month" 
              featured="true" action-text="Start Free Trial" action-url="#pro">
  <feature>Unlimited users</feature>
  <feature>25GB storage</feature>
  <feature>Priority support</feature>
  <feature included="false">Custom domain</feature>
  <feature included="false">Advanced security</feature>
</pricing-plan>
```

#### `<team-member>`

Team member profile card.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `name` | Person's name | Text | Required |
| `role` | Job title/role | Text | Required |

**Child Elements:**

- `<image>`: Profile photo
- Content elements (bio paragraph, etc.)
- `<social>`: Social media links (contains `<link>` elements)

**Link Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `platform` | Social platform | "linkedin", "twitter", "github", etc. | Required |
| `url` | Profile URL | URL | Required |

**Example:**

```xml
<team-member name="Sarah Johnson" role="Lead Designer">
  <image src="team/sarah.jpg" alt="Sarah Johnson" />
  <p>Sarah has over 10 years of experience in UX/UI design.</p>
  <social>
    <link platform="linkedin" url="https://linkedin.com/in/sarahjohnson" />
    <link platform="twitter" url="https://twitter.com/sarahjohnson" />
    <link platform="dribbble" url="https://dribbble.com/sarahjohnson" />
  </social>
</team-member>
```

#### `<contact-info>`

Structured contact information display.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `title` | Section title | Text | None |

**Child Elements:**

- `<address>`: Physical address
- `<phone>`: Phone number
- `<email>`: Email address
- `<website>`: Website URL and display text
- `<social>`: Social media links (contains `<link>` elements)

**Example:**

```xml
<contact-info title="Get in Touch">
  <address>123 Business Ave, Suite 100, San Francisco, CA 94107</address>
  <phone>+1 (555) 123-4567</phone>
  <email>info@company.com</email>
  <website url="https://www.company.com">www.company.com</website>
  <social>
    <link platform="facebook" url="https://facebook.com/company" />
    <link platform="twitter" url="https://twitter.com/company" />
    <link platform="linkedin" url="https://linkedin.com/company" />
  </social>
</contact-info>
```

#### `<timeline-event>`

Individual timeline entry.

**Attributes:**

| Attribute | Description | Values | Default |
|-----------|-------------|--------|---------|
| `date` | Event date/time | Text | Required |
| `title` | Event title | Text | Required |

**Example:**

```xml
<timeline-event date="January 2025" title="Product Launch">
  <p>Successfully launched our flagship product to market.</p>
  <image src="launch-event.jpg" alt="Launch event" />
</timeline-event>
```

## Styling and Themes

### Presentation Themes

The presentation system supports light and dark themes, as well as custom themes.

```xml
<!-- Light theme (default) -->
<presentation id="my-presentation" theme="light">
  <!-- Slides -->
</presentation>

<!-- Dark theme -->
<presentation id="dark-presentation" theme="dark">
  <!-- Slides -->
</presentation>
```

### Custom Brand Colors

You can define custom brand colors in the metadata section:

```xml
<metadata>
  <title>Branded Presentation</title>
  <brand>
    <color name="primary">#3b82f6</color>
    <color name="secondary">#8b5cf6</color>
    <color name="accent">#10b981</color>
    <color name="text">#1f2937</color>
    <color name="background">#f3f4f6</color>
  </brand>
</metadata>
```

These colors will be applied throughout the presentation for consistent branding.

### Custom CSS

You can add custom CSS to the `assets/css/presentation-custom.css` file to override or extend the default styling.

```css
/* Example custom styling */
.slide-title {
  font-family: 'Playfair Display', serif;
  border-bottom: 2px solid var(--bs-primary);
  padding-bottom: 0.5rem;
}

.timeline-marker {
  background-color: var(--bs-accent, var(--bs-info));
  width: 16px;
  height: 16px;
}
```

## Helper Functions

The system includes several helper functions in `helpers.xsl` that generate appropriate Bootstrap classes.

### Text Helpers

- **visibility-classes**: Generates responsive visibility classes
- **text-color-classes**: Generates text color classes
- **text-alignment-classes**: Generates text alignment classes
- **font-size-classes**: Generates font size classes
- **font-weight-classes**: Generates font weight classes

### Layout Helpers

- **spacing-classes**: Generates margin and padding classes
- **bg-color-classes**: Generates background color classes
- **border-classes**: Generates border classes
- **rounded-classes**: Generates rounded corner classes
- **shadow-classes**: Generates shadow classes

### Utility Helpers

- **format-url**: Formats URLs with proper path handling
- **generate-id**: Generates unique IDs for elements
- **format-date**: Formats dates for display
- **string-join**: Safely concatenates strings with separators
- **strip-whitespace**: Removes excess whitespace from strings
- **boolean-to-string**: Converts boolean values to strings
- **contains**: Checks if a string contains a substring
- **get-list-item**: Gets the nth item from a delimited list
- **count-list-items**: Counts items in a delimited list

## Best Practices

### Content Organization

1. **Use semantic structure**: Organize content according to its meaning and purpose, not its appearance
2. **Group related content**: Use container and section components to group related content
3. **Be consistent**: Use the same component types for similar content throughout the presentation

### Responsive Design

1. **Test on multiple devices**: Preview your presentation on different screen sizes
2. **Use responsive components**: Grid, column, and flex-container components automatically adapt to screen size
3. **Consider mobile users**: Set appropriate visibility attributes for components that should behave differently on mobile

### Performance

1. **Optimize images**: Compress images before adding them to your presentation
2. **Limit animations**: Use animations judiciously to avoid performance issues
3. **Use lazy loading**: For slides with videos or complex charts, use the "loading" attribute where applicable

### Accessibility

1. **Provide alt text**: Always include descriptive alt text for images
2. **Use semantic headings**: Maintain proper heading hierarchy (h1, h2, h3, etc.)
3. **Ensure color contrast**: Choose colors with sufficient contrast for readability
4. **Include captions**: Add captions for videos and complex visualizations

## Examples

### Complete Presentation Example

```xml
<?xml version="1.0" encoding="UTF-8"?>
<presentation id="company-overview" theme="light">
  <metadata>
    <title>Company Overview</title>
    <author>John Smith</author>
    <brand>
      <color name="primary">#4f46e5</color>
      <color name="secondary">#7c3aed</color>
    </brand>
  </metadata>
  
  <!-- Title Slide -->
  <slide id="title" type="title">
    <title>Acme Corporation</title>
    <content>
      <p>Company Overview - Q2 2025</p>
    </content>
    <notes>
      Welcome everyone to our quarterly company overview.
      This presentation will cover our achievements, challenges, and future plans.
    </notes>
  </slide>
  
  <!-- Section Slide -->
  <slide id="about-section" type="section">
    <title>About Us</title>
    <content>
      <p>Learn about our mission, values, and history</p>
    </content>
  </slide>
  
  <!-- Standard Slide -->
  <slide id="mission" type="standard">
    <title>Our Mission</title>
    <content>
      <container type="fixed" padding="medium">
        <blockquote>
          <text>To create innovative solutions that help businesses grow and succeed in the digital age.</text>
          <attribution>Acme Corporation</attribution>
          <source>Company Mission Statement</source>
        </blockquote>
        
        <spacer size="medium" orientation="vertical" />
        
        <p>Since our founding in 2010, we've been dedicated to this mission through:</p>
        
        <grid columns="3" gap="medium">
          <column span="1">
            <feature icon="lightbulb" title="Innovation" iconColor="warning">
              <p>Constantly exploring new ideas and technologies</p>
            </feature>
          </column>
          <column span="1">
            <feature icon="people" title="Collaboration" iconColor="primary">
              <p>Working closely with clients to understand their needs</p>
            </feature>
          </column>
          <column span="1">
            <feature icon="arrow-up-right" title="Excellence" iconColor="success">
              <p>Committing to the highest quality in everything we do</p>
            </feature>
          </column>
        </grid>
      </container>
    </content>
  </slide>
  
  <!-- Chart Slide -->
  <slide id="growth" type="chart">
    <title>Company Growth</title>
    <content>
      <p>We've experienced consistent growth over the past five years, with revenue increasing by an average of 23% annually.</p>
      
      <stat value="27" unit="%" label="Revenue Growth" icon="graph-up" iconColor="success" trend="+4%" />
    </content>
    <chart type="line">
      <data>
        {
          labels: ['2021', '2022', '2023', '2024', '2025'],
          datasets: [{
            label: 'Revenue (Millions)',
            data: [3.2, 4.1, 5.3, 6.8, 8.6],
            borderColor: '#4f46e5',
            tension: 0.2
          }]
        }
      </data>
    </chart>
  </slide>
  
  <!-- Product Feature Slide -->
  <slide id="product" type="standard">
    <title>Our Flagship Product</title>
    <content>
      <product-feature title="AcmeAnalytics™ Platform" image-position="right" 
                      badge="New" action-text="Learn More" action-url="#demo">
        <image src="product-dashboard.jpg" alt="Analytics Dashboard" />
        <p>Our AI-powered analytics platform helps businesses make data-driven decisions.</p>
        <list type="unordered">
          <item>Real-time data processing</item>
          <item>Customizable dashboards</item>
          <item>Predictive analytics</item>
          <item>Seamless integration with existing systems</item>
        </list>
      </product-feature>
      
      <spacer size="medium" orientation="vertical" />
      
      <tabs>
        <tab title="Features">
          <grid columns="2" gap="medium">
            <column span="1">
              <card>
                <title>Advanced Reporting</title>
                <content>
                  <p>Generate customizable reports with just a few clicks.</p>
                </content>
              </card>
            </column>
            <column span="1">
              <card>
                <title>Data Visualization</title>
                <content>
                  <p>Transform complex data into clear, actionable insights.</p>
                </content>
              </card>
            </column>
          </grid>
        </tab>
        <tab title="Testimonials">
          <quote-card>
            <quote>AcmeAnalytics has transformed how we understand our customer data.</quote>
            <attribution>Sarah Johnson</attribution>
            <role>CTO, XYZ Corp</role>
            <image src="testimonials/sarah.jpg" alt="Sarah Johnson" />
          </quote-card>
        </tab>
        <tab title="Pricing">
          <grid columns="3" gap="small">
            <column span="1">
              <pricing-plan name="Starter" price="99" currency="$" period="month"
                          action-text="Get Started" action-url="#starter">
                <feature>5 users</feature>
                <feature>Basic analytics</feature>
                <feature>Email support</feature>
                <feature included="false">Custom reports</feature>
              </pricing-plan>
            </column>
            <column span="1">
              <pricing-plan name="Professional" price="299" currency="$" period="month" featured="true"
                          action-text="Free Trial" action-url="#pro">
                <feature>Unlimited users</feature>
                <feature>Advanced analytics</feature>
                <feature>Priority support</feature>
                <feature>Custom reports</feature>
              </pricing-plan>
            </column>
            <column span="1">
              <pricing-plan name="Enterprise" price="999" currency="$" period="month"
                          action-text="Contact Sales" action-url="#enterprise">
                <feature>Unlimited users</feature>
                <feature>Advanced analytics</feature>
                <feature>24/7 support</feature>
                <feature>Custom reports</feature>
              </pricing-plan>
            </column>
          </grid>
        </tab>
      </tabs>
    </content>
  </slide>
  
  <!-- Team Slide -->
  <slide id="team" type="standard">
    <title>Our Leadership Team</title>
    <content>
      <grid columns="4" gap="medium">
        <column span="1">
          <team-member name="John Smith" role="CEO & Founder">
            <image src="team/john.jpg" alt="John Smith" />
            <p>Founded Acme in 2010 with a vision to transform business analytics.</p>
            <social>
              <link platform="linkedin" url="https://linkedin.com/in/johnsmith" />
              <link platform="twitter" url="https://twitter.com/johnsmith" />
            </social>
          </team-member>
        </column>
        <column span="1">
          <team-member name="Emily Chen" role="CTO">
            <image src="team/emily.jpg" alt="Emily Chen" />
            <p>Leads our engineering team and technical strategy.</p>
            <social>
              <link platform="linkedin" url="https://linkedin.com/in/emilychen" />
              <link platform="github" url="https://github.com/emilychen" />
            </social>
          </team-member>
        </column>
        <column span="1">
          <team-member name="Michael Johnson" role="CMO">
            <image src="team/michael.jpg" alt="Michael Johnson" />
            <p>Oversees our marketing initiatives and brand strategy.</p>
            <social>
              <link platform="linkedin" url="https://linkedin.com/in/michaeljohnson" />
              <link platform="twitter" url="https://twitter.com/michaeljohnson" />
            </social>
          </team-member>
        </column>
        <column span="1">
          <team-member name="Jessica Lee" role="COO">
            <image src="team/jessica.jpg" alt="Jessica Lee" />
            <p>Manages our day-to-day operations and growth strategy.</p>
            <social>
              <link platform="linkedin" url="https://linkedin.com/in/jessicalee" />
            </social>
          </team-member>
        </column>
      </grid>
    </content>
  </slide>
  
  <!-- Roadmap Slide -->
  <slide id="roadmap" type="standard">
    <title>Product Roadmap</title>
    <content>
      <timeline orientation="horizontal" markers="dots">
        <event date="Q3 2025">
          <title>Mobile App</title>
          <description>Native mobile applications for iOS and Android</description>
        </event>
        <event date="Q4 2025">
          <title>Advanced AI Features</title>
          <description>Predictive analytics and anomaly detection</description>
        </event>
        <event date="Q1 2026">
          <title>Global Expansion</title>
          <description>New data centers in Europe and Asia</description>
        </event>
        <event date="Q2 2026">
          <title>Enterprise API</title>
          <description>Comprehensive API for enterprise integrations</description>
        </event>
      </timeline>
      
      <spacer size="large" orientation="vertical" />
      
      <callout type="info" title="Get Early Access" icon="bell">
        <p>Join our beta program to get early access to upcoming features. <button type="primary" size="small">Sign Up</button></p>
      </callout>
    </content>
  </slide>
  
  <!-- Contact Slide -->
  <slide id="contact" type="standard">
    <title>Contact Us</title>
    <content>
      <split ratio="60-40">
        <left>
          <h3>Get in Touch</h3>
          <p>We'd love to hear from you. Fill out the form below and we'll get back to you as soon as possible.</p>
          
          <form-group id="name" type="text" label="Name" required="true" />
          <form-group id="email" type="email" label="Email" required="true" />
          <form-group id="company" type="text" label="Company" />
          <form-group id="message" type="textarea" label="Message" rows="5" required="true" />
          <button type="primary" size="large">Send Message</button>
        </left>
        <right>
          <contact-info title="Company Headquarters">
            <address>123 Tech Boulevard, Suite 100, San Francisco, CA 94107</address>
            <phone>+1 (555) 123-4567</phone>
            <email>info@acmecorp.com</email>
            <website url="https://www.acmecorp.com">www.acmecorp.com</website>
            <social>
              <link platform="facebook" url="https://facebook.com/acmecorp" />
              <link platform="twitter" url="https://twitter.com/acmecorp" />
              <link platform="linkedin" url="https://linkedin.com/company/acmecorp" />
              <link platform="instagram" url="https://instagram.com/acmecorp" />
            </social>
          </contact-info>
        </right>
      </split>
    </content>
  </slide>
  
  <!-- Thank You Slide -->
  <slide id="thank-you" type="section">
    <title>Thank You</title>
    <content>
      <alignment horizontal="center" text="center">
        <h2>Questions?</h2>
        <p class="lead">We're here to help.</p>
        <button type="primary" size="large">Schedule a Demo</button>
      </alignment>
    </content>
  </slide>
</presentation>
```

### Example: Feature Comparison Slide

```xml
<slide id="feature-comparison" type="standard">
  <title>Feature Comparison</title>
  <content>
    <container type="fixed" padding="medium">
      <data-table striped="true" bordered="true">
        <header>
          <column>Feature</column>
          <column>Acme Basic</column>
          <column>Acme Pro</column>
          <column>Competitor</column>
        </header>
        <row>
          <cell>Users</cell>
          <cell>Up to 5</cell>
          <cell>Unlimited</cell>
          <cell>Up to 10</cell>
        </row>
        <row>
          <cell>Storage</cell>
          <cell>10GB</cell>
          <cell>100GB</cell>
          <cell>25GB</cell>
        </row>
        <row>
          <cell>API Access</cell>
          <cell type="danger">No</cell>
          <cell type="success">Yes</cell>
          <cell type="warning">Limited</cell>
        </row>
        <row>
          <cell>24/7 Support</cell>
          <cell type="danger">No</cell>
          <cell type="success">Yes</cell>
          <cell type="danger">No</cell>
        </row>
        <row>
          <cell>Custom Reports</cell>
          <cell type="danger">No</cell>
          <cell type="success">Yes</cell>
          <cell type="warning">Add-on</cell>
        </row>
      </data-table>
      
      <spacer size="medium" orientation="vertical" />
      
      <callout type="primary" title="Why Choose Acme Pro?">
        <p>Acme Pro offers more features at a competitive price, with unlimited users and superior support options.</p>
      </callout>
    </container>
  </content>
</slide>
```

### Example: Interactive FAQ Slide

```xml
<slide id="faq" type="standard">
  <title>Frequently Asked Questions</title>
  <content>
    <container type="fixed" padding="medium">
      <accordion>
        <item title="How do I get started with Acme Analytics?">
          <p>Getting started is easy! Simply sign up for a free trial on our website, and you'll receive access to our platform within minutes. Our onboarding guide will walk you through the setup process.</p>
        </item>
        <item title="Can I import data from other platforms?">
          <p>Yes, Acme Analytics supports imports from most major analytics platforms and data formats, including:</p>
          <list type="unordered">
            <item>CSV files</item>
            <item>Excel spreadsheets</item>
            <item>Google Analytics</item>
            <item>SQL databases</item>
            <item>API connections</item>
          </list>
        </item>
        <item title="What kind of support do you offer?">
          <p>We offer multiple support tiers:</p>
          <data-table>
            <header>
              <column>Plan</column>
              <column>Support Type</column>
              <column>Response Time</column>
            </header>
            <row>
              <cell>Basic</cell>
              <cell>Email only</cell>
              <cell>Within 48 hours</cell>
            </row>
            <row>
              <cell>Professional</cell>
              <cell>Email and chat</cell>
              <cell>Within 24 hours</cell>
            </row>
            <row>
              <cell>Enterprise</cell>
              <cell>Email, chat, phone</cell>
              <cell>Within 4 hours</cell>
            </row>
          </data-table>
        </item>
        <item title="Is my data secure?">
          <p>We take security seriously. All data is encrypted in transit and at rest, and we maintain SOC 2 and ISO 27001 certifications. Our security measures include:</p>
          <list type="unordered">
            <item>AES-256 encryption</item>
            <item>Regular security audits</item>
            <item>Multi-factor authentication</item>
            <item>GDPR and CCPA compliance</item>
          </list>
        </item>
      </accordion>
      
      <spacer size="medium" orientation="vertical" />
      
      <alignment horizontal="center">
        <p>Have more questions? We're here to help.</p>
        <button type="primary">Contact Support</button>
      </alignment>
    </container>
  </content>
</slide>
```

### Example: Data Visualization Slide

```xml
<slide id="data-visualization" type="standard">
  <title>Sales Performance by Region</title>
  <content>
    <container type="fixed" padding="medium">
      <grid columns="12" gap="medium">
        <!-- Metrics overview -->
        <column span="12">
          <grid columns="3" gap="small">
            <column span="1">
              <stat value="2.7" unit="M" label="Total Sales" icon="cash" iconColor="success" trend="+18%" />
            </column>
            <column span="1">
              <stat value="843" label="New Customers" icon="people" iconColor="primary" trend="+12%" />
            </column>
            <column span="1">
              <stat value="96" unit="%" label="Satisfaction" icon="star" iconColor="warning" trend="+3%" />
            </column>
          </grid>
        </column>
        
        <!-- Charts -->
        <column span="6">
          <chart-container type="bar" title="Sales by Region">
            <data>
              {
                labels: ['North America', 'Europe', 'Asia', 'Australia', 'South America'],
                datasets: [{
                  label: 'Q1 2025',
                  data: [800, 650, 450, 320, 280],
                  backgroundColor: 'rgba(79, 70, 229, 0.7)'
                }]
              }
            </data>
            <options>
              {
                indexAxis: 'y',
                plugins: {
                  legend: {
                    display: false
                  }
                }
              }
            </options>
          </chart-container>
        </column>
        <column span="6">
          <chart-container type="pie" title="Revenue Breakdown">
            <data>
              {
                labels: ['Product A', 'Product B', 'Product C', 'Services', 'Support'],
                datasets: [{
                  data: [35, 25, 20, 15, 5],
                  backgroundColor: [
                    'rgba(79, 70, 229, 0.7)',
                    'rgba(124, 58, 237, 0.7)',
                    'rgba(59, 130, 246, 0.7)',
                    'rgba(16, 185, 129, 0.7)',
                    'rgba(239, 68, 68, 0.7)'
                  ]
                }]
              }
            </data>
          </chart-container>
        </column>
        
        <!-- Data table -->
        <column span="12">
          <data-table striped="true" bordered="true">
            <header>
              <column>Region</column>
              <column>Q1 2024</column>
              <column>Q1 2025</column>
              <column>Change</column>
              <column>Status</column>
            </header>
            <row>
              <cell>North America</cell>
              <cell>$680K</cell>
              <cell>$800K</cell>
              <cell>+17.6%</cell>
              <cell type="success">Above Target</cell>
            </row>
            <row>
              <cell>Europe</cell>
              <cell>$520K</cell>
              <cell>$650K</cell>
              <cell>+25.0%</cell>
              <cell type="success">Above Target</cell>
            </row>
            <row>
              <cell>Asia</cell>
              <cell>$420K</cell>
              <cell>$450K</cell>
              <cell>+7.1%</cell>
              <cell type="warning">Near Target</cell>
            </row>
            <row>
              <cell>Australia</cell>
              <cell>$310K</cell>
              <cell>$320K</cell>
              <cell>+3.2%</cell>
              <cell type="danger">Below Target</cell>
            </row>
            <row>
              <cell>South America</cell>
              <cell>$230K</cell>
              <cell>$280K</cell>
              <cell>+21.7%</cell>
              <cell type="success">Above Target</cell>
            </row>
          </data-table>
        </column>
      </grid>
    </container>
  </content>
</slide>
```

## Conclusion

This XML/XSL Presentation System provides a powerful, flexible framework for creating semantically structured, visually appealing presentations with a clean separation of content and presentation. By focusing on the semantic meaning of content rather than its visual appearance, you can create presentations that are easier to maintain, more consistent, and automatically responsive across different screen sizes.

The system's modular architecture and extensive component library allow you to create virtually any type of presentation, from simple slide decks to complex interactive product showcases. The Bootstrap integration ensures that your presentations look professional and polished without requiring deep CSS knowledge.

For additional examples, technical details, or customization options, refer to the other documentation sections or explore the example presentations included with the system.

