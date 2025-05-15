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

## Directory Structure

```
xml-presentation/
├── assets/                    # Static assets
│   ├── images/                # Image files
│   │   ├── favicon.svg
│   │   ├── favicon.png
│   │   └── apple-touch-icon.png
│   └── css/                   # CSS files
│       └── presentation-custom.css
├── docs/                      # Documentation
│   ├── bootstrap-guide/       # Bootstrap integration guide
│   │   ├── README.md          # Table of contents
│   │   ├── part1-overview.md
│   │   ├── part2-features.md
│   │   └── ... (other guide parts)
├── examples/                  # Example presentations
│   └── investor-pitch.xml
├── js/                        # JavaScript files
│   └── presentation.js
├── schema/                    # XML Schema files
│   └── presentation.xsd
├── templates/                 # XSL templates
│   └── presentation.xsl
│── index.html                 # Main entry point
│── README.md                  # This file
```

## Getting Started

### Running the Presentation

Due to browser security restrictions, you **must** serve the files using an HTTP server rather than opening them directly from the filesystem. This is because the system uses AJAX requests to load XML and XSL files, which are blocked by CORS policies when using the `file://` protocol.

There are several easy ways to start a local HTTP server:

#### Option 1: Using Python (pre-installed on most macOS and Linux systems)

```bash
# Python 3
python -m http.server 8000

# Python 2
python -m SimpleHTTPServer 8000
```

Then open your browser and navigate to: `http://localhost:8000`

#### Option 2: Using Node.js

First, install the http-server package:

```bash
npm install -g http-server
```

Then run the server:

```bash
http-server -p 8000
```

Then open your browser and navigate to: `http://localhost:8000`

#### Option 3: Using PHP (if installed)

```bash
php -S localhost:8000
```

Then open your browser and navigate to: `http://localhost:8000`

#### Option 4: Using VS Code's Live Server Extension

If you're using Visual Studio Code, you can install the "Live Server" extension and then click "Go Live" in the status bar to start a server.

### Creating Your Presentation

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

For detailed documentation, see the [Bootstrap Integration Guide](docs/bootstrap-guide/README.md).

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

## Documentation

For comprehensive documentation on how to use and customize the presentation system, see the [Bootstrap Integration Guide](docs/bootstrap-guide/README.md).

## License

MIT License

## Contributing

Contributions welcome! Please feel free to submit a Pull Request.
