# Getting Started

Follow these steps to upgrade your existing XML/XSL presentation system to use Bootstrap:

## Step 1: Replace XSL Template

Replace your existing XSL transformation file with the Bootstrap-enhanced version `presentation.xsl`.

This new XSL file outputs HTML with Bootstrap classes and components, with improved accessibility and responsive design.

```bash
# Copy the new XSL file to your project
cp /path/to/bootstrap-presentation/presentation.xsl /path/to/your-project/
```

## Step 2: Update CSS

Replace your custom CSS with the minimal `presentation-custom.css` file, which only contains styles that extend Bootstrap.

Most of your previous styling will now be handled by Bootstrap's utility classes.

```bash
# Copy the new CSS file to your project
cp /path/to/bootstrap-presentation/presentation-custom.css /path/to/your-project/
```

## Step 3: Update JavaScript

Replace your presentation JavaScript with the updated `presentation.js` file that works with Bootstrap and Chart.js.

This script handles slide navigation, chart rendering, theme integration, and accessibility features.

```bash
# Copy the new JavaScript file to your project
cp /path/to/bootstrap-presentation/presentation.js /path/to/your-project/
```

## Step 4: Update HTML Entry Point

Update your `index.html` to include Bootstrap CSS and JavaScript:

```html
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom presentation styles -->
<link rel="stylesheet" href="presentation-custom.css">
<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.3.0/dist/chart.umd.min.js"></script>
<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
```

## Step 5: Update XML Schema

Update your XML Schema file to include new elements and attributes:

```bash
# Copy the new XSD file to your project
cp /path/to/bootstrap-presentation/presentation.xsd /path/to/your-project/
```

## Step 6: Update Your XML Content

You can continue using your existing XML content with minimal changes. Just add the theme attribute to the presentation element and update your brand colors if desired.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<presentation id="my-presentation" theme="light" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
            xsi:noNamespaceSchemaLocation="presentation.xsd" lang="en">
  <metadata>
    <!-- Add or update brand colors -->
    <brand>
      <color name="primary">#0d6efd</color>
      <color name="secondary">#6610f2</color>
      <!-- Other colors -->
    </brand>
  </metadata>
  <!-- Your existing slides -->
</presentation>
```

## Step 7: Optimize Existing Content

Update your slides to leverage Bootstrap's utility classes and components:

1. Replace custom CSS classes with Bootstrap utility classes
2. Update layouts to use Bootstrap grid system (`<row>` and `<col>`)
3. Replace custom components with Bootstrap components (`<card>`, `<alert>`, etc.)
4. Add `transition` attributes to slides
5. Add accessibility attributes like `summary` for tables and charts

That's it! Your XML/XSL presentation system is now powered by Bootstrap, giving you a more robust, responsive, and themeable presentation framework while maintaining the separation of content and presentation.
