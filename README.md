# XML/XSL Presentation System with Bootstrap

A modern, responsive presentation framework that uses XML for content, XSL for transformation, and Bootstrap for styling. This system allows you to create beautiful, responsive presentations while maintaining separation of content and presentation.

## Features

- **Content/Presentation Separation**: Content in XML, styling with Bootstrap CSS
- **Responsive Design**: Automatically adapts to different screen sizes and devices
- **Theme Support**: Light, dark, and custom themes via Bootstrap's theme system
- **Chart.js Integration**: Data visualization with charts that match your theme
- **Speaker Notes**: Built-in support for presenter notes
- **Keyboard Navigation**: Full keyboard shortcut support
- **Print-friendly**: Optimized for printing/PDF export

## File Structure

```
├── index.html                  # Entry point HTML
├── presentation-custom.css     # Custom CSS extending Bootstrap
├── presentation.js             # Presentation control script
├── presentation.xsl            # XSL transformation file
├── presentation.xsd            # XML Schema for validation
├── bootstrap-integration-guide.html # Documentation
└── your-presentation.xml       # Your presentation content
```

## Getting Started

1. Clone this repository:
   ```
   git clone https://github.com/yourusername/xml-bootstrap-presentation.git
   ```

2. Create your presentation by editing `your-presentation.xml` or creating a new XML file following the schema.

3. Open `index.html` in a modern browser to view your presentation.

## Creating Presentations

Create your presentation in XML format following this structure:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<presentation id="my-presentation" theme="light">
  <metadata>
    <title>My Presentation</title>
    <author>Your Name</author>
    <brand>
      <color name="primary">#0d6efd</color>
      <!-- Additional brand colors -->
    </brand>
  </metadata>
  
  <slide id="title-slide" type="title">
    <title>Presentation Title</title>
    <content>
      <p>Subtitle or additional information</p>
    </content>
    <notes>Speaker notes for this slide</notes>
  </slide>
  
  <!-- Additional slides -->
</presentation>
```

For detailed documentation, see the [Bootstrap Integration Guide](bootstrap-integration-guide.html).

## Slide Types

- **title**: Title slides
- **standard**: Regular content slides
- **section**: Section divider slides
- **image**: Image-focused slides
- **quote**: Quote/testimonial slides
- **chart**: Data visualization slides
- **comparison**: Comparison slides
- **timeline**: Timeline/roadmap slides

## Chart Support

Create data visualizations using Chart.js:

```xml
<chart type="bar" height="400px">
  <data>
    [
      {"segment": "Category A", "value": 250},
      {"segment": "Category B", "value": 150},
      {"segment": "Category C", "value": 100}
    ]
  </data>
  <options>
    {
      "plugins": {
        "title": {
          "display": true,
          "text": "Chart Title"
        }
      }
    }
  </options>
</chart>
```

## Keyboard Shortcuts

- **Right Arrow/Space/Page Down**: Next slide
- **Left Arrow/Page Up**: Previous slide
- **Home**: First slide
- **End**: Last slide
- **F**: Toggle fullscreen
- **N**: Toggle speaker notes

## Browser Support

This presentation system works in all modern browsers that support:
- XML/XSL Transformations
- ES6+ JavaScript
- Bootstrap 5.3+
- CSS Variables

## License

MIT License

## Contributing

Contributions welcome! Please feel free to submit a Pull Request.
