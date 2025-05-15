# Best Practices

Follow these best practices when creating Bootstrap-enhanced presentations:

## Content Structure
- Use proper slide types (`title`, `section`, `standard`, etc.) for semantic structure
- Limit content per slide (3-5 key points maximum)
- Use section slides to divide presentation into logical segments
- Include descriptive `<notes>` for presenters
- Keep XML structure clean and well-indented

## Visual Design
- Maintain consistent branding with custom `<brand>` colors
- Test both light and dark themes for readability
- Use Bootstrap spacing utilities (`p-4`, `mt-3`, etc.) for consistent spacing
- Leverage Bootstrap's `text-*` utilities for text alignment
- Use high-quality images with proper `alt` text and `loading="lazy"`

## Performance
- Optimize images before including them in presentations
- Use SVG where possible for crisp, scalable graphics
- Limit animations to avoid performance issues on low-end devices
- Use `loading="lazy"` for non-critical images and content
- Consider complexity when creating charts (limit data points)

## Accessibility
- Provide descriptive `alt` attributes for all images
- Include `summary` attributes for charts
- Ensure sufficient color contrast for text and UI elements
- Use `<data-table>` elements for complex charts
- Run the built-in accessibility checker before publishing

## Common Anti-Patterns to Avoid

| Anti-Pattern | Why It's Bad | Better Alternative |
|--------------|--------------|-------------------|
| Using inline styles in XML | Breaks separation of concerns, harder to maintain | Use Bootstrap classes or add custom classes to `presentation-custom.css` |
| Excessive animations | Can be distracting and hurt performance | Use animations sparingly and with purpose |
| Text in images | Not accessible to screen readers, doesn't scale well | Use actual text with proper markup |
| Overcrowded slides | Difficult to read, overwhelming for audience | Split content across multiple slides, focus on key points |
| Inconsistent branding | Looks unprofessional, weakens brand recognition | Define brand colors in `<metadata>` and use them consistently |
| Complex charts with tiny text | Difficult to read, especially on smaller screens | Simplify charts, use responsive sizing, focus on key insights |
