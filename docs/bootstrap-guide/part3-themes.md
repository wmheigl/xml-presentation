# Bootstrap Themes

Bootstrap 5.3+ includes a robust theme system via the `data-bs-theme` attribute and CSS variables. Our implementation fully leverages this by mapping the `theme` attribute in your XML to the appropriate Bootstrap theme:

```xml
<presentation id="investor-pitch" theme="dark">
  <metadata>
    <title>Investor Pitch Deck</title>
    ...
  </metadata>
  ...
</presentation>
```

## Available Themes

- **Light Theme (Default)**: Clean, bright appearance with high contrast
- **Dark Theme**: Reduced eye strain in low-light environments
- **Custom Theme**: Branded experience with custom colors

## Dynamic Theme Switching

New in 2025: Users can now toggle between themes with a simple JavaScript call, without reloading the presentation:

```javascript
// Switch to dark theme
PresentationApp.setColorMode('dark');

// Switch to light theme
PresentationApp.setColorMode('light');

// Switch to auto (system preference)
PresentationApp.setColorMode('auto');

// Switch to custom theme
PresentationApp.setColorMode('custom');
```

## Custom Brand Colors

Define custom colors in your XML metadata using the `<brand>` element. These colors are mapped to Bootstrap's CSS variables:

```xml
<brand>
  <color name="primary">#0d6efd</color>
  <color name="secondary">#6610f2</color>
  <color name="accent">#fd7e14</color>
  <color name="text">#212529</color>
  <color name="background">#f8f9fa</color>
</brand>
```

| XML Color Name | Bootstrap CSS Variable | Usage |
|----------------|------------------------|-------|
| primary | `--bs-primary` | Main brand color, used for buttons, links, and accents |
| secondary | `--bs-secondary` | Secondary color for less prominent elements |
| accent | `--bs-info` | Accent color for highlights and callouts |
| text | `--bs-body-color` | Main text color |
| background | `--bs-body-bg` | Background color |

**New in 2025**: When using custom colors, the system now automatically generates appropriate dark mode variants, saving you from having to define separate color schemes.

# CSS Variables

Bootstrap 5.3+ uses CSS variables extensively for theming. Our presentation system leverages these variables for consistent styling and easy customization.

## Core Bootstrap Variables

These are the key variables that control the overall appearance of your presentations:

| Variable | Default Value (Light) | Default Value (Dark) | Controls |
|----------|---------------------|---------------------|----------|
| `--bs-body-bg` | `#fff` | `#212529` | Background color of slides |
| `--bs-body-color` | `#212529` | `#dee2e6` | Text color |
| `--bs-primary` | `#0d6efd` | `#0d6efd` | Primary accent color |
| `--bs-border-color` | `#dee2e6` | `#495057` | Border colors |
| `--bs-border-radius` | `0.375rem` | `0.375rem` | Corner roundness |

## Presentation-Specific Variables

These custom variables are defined in `presentation-custom.css` and control presentation-specific elements:

| Variable | Default Value | Controls |
|----------|---------------|----------|
| `--z-slide` | `10` | Z-index for slides |
| `--z-controls` | `100` | Z-index for navigation controls |
| `--z-progress` | `90` | Z-index for progress bar |
| `--z-speaker-notes` | `200` | Z-index for speaker notes panel |
| `--slide-transition-duration` | `0.5s` | Duration of slide transitions |
| `--slide-transition-timing` | `ease` | Timing function for slide transitions |

## Customizing Variables

You can override these variables in your own CSS to customize the presentation without modifying the core files:

```css
/* my-presentation-override.css */
:root {
  /* Customize Bootstrap variables */
  --bs-primary: #8a2be2;  /* Blueviolet */
  --bs-border-radius: 0.5rem;
  
  /* Customize presentation variables */
  --slide-transition-duration: 0.8s;
  --slide-transition-timing: cubic-bezier(0.16, 1, 0.3, 1);
}
```

**Pro Tip**: Use your browser's developer tools to inspect and modify CSS variables in real-time to preview changes before implementing them permanently.
