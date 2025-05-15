# Troubleshooting

Here are solutions to common issues you might encounter:

## Slides Not Displaying Correctly

If slides aren't appearing or styling is missing:

1. Check browser console for JavaScript errors
2. Verify that Bootstrap CSS is loaded correctly
3. Ensure your XML is valid against the schema (`presentation.xsd`)
4. Inspect the generated HTML to see if the transformation is working
5. Try clearing browser cache and reloading

## Charts Not Rendering

If charts are not appearing or displaying incorrectly:

1. Verify Chart.js is loaded correctly
2. Check that your chart data is valid JSON
3. Ensure your chart options are properly formatted
4. Check for JavaScript errors in the console
5. Try a simpler chart configuration to isolate the issue

Common Chart.js data format issues:

```javascript
// Example of valid chart data format
[
  {"segment": "Enterprise", "value": 250},
  {"segment": "Mid-market", "value": 150},
  {"segment": "SMB", "value": 100}
]
```

## Theme Switching Issues

If theme switching isn't working correctly:

1. Ensure you're using the latest Bootstrap version (5.3+)
2. Verify the `data-bs-theme` attribute is being set on the HTML element
3. Check for CSS overrides that might be interfering with theme variables
4. Make sure your custom CSS uses Bootstrap's CSS variables

Manual theme switching test:

```javascript
// In the browser console, try:
document.documentElement.setAttribute('data-bs-theme', 'dark');

// Then switch back:
document.documentElement.setAttribute('data-bs-theme', 'light');
```

## Mobile Responsiveness Problems

If the presentation doesn't adapt properly to mobile devices:

1. Check that the viewport meta tag is correctly set in `index.html`
2. Ensure you're using Bootstrap's responsive classes correctly
3. Test with different device sizes using browser dev tools
4. Verify that images and charts have responsive sizing

Required viewport meta tag:

```html
<meta name="viewport" content="width=device-width, initial-scale=1.0">
```

## XML Transformation Errors

If you're experiencing XML transformation issues:

1. Check for well-formedness in your XML (balanced tags, proper nesting)
2. Validate your XML against the schema using a validator
3. Look for special characters that might need to be escaped
4. Check for namespace issues in the XML or XSL files
5. Try processing with a simpler XML file to isolate the issue

Common XML errors and fixes:

| Error | Fix |
|-------|-----|
| Unescaped special characters | Replace `&` with `&amp;`, `<` with `&lt;`, etc. |
| Missing closing tags | Ensure all elements have proper closing tags |
| Incorrect tag nesting | Ensure tags are properly nested (close inner tags before outer ones) |
| Namespace issues | Check namespace declarations and prefixes |

## Common Error Messages

| Error Message | Likely Cause | Solution |
|---------------|--------------|----------|
| `TypeError: Cannot read properties of undefined (reading 'addEventListener')` | DOM element not found | Check that all required HTML elements with the correct IDs exist |
| `SyntaxError: Unexpected token in JSON` | Invalid JSON in chart data or options | Validate your JSON with a JSON linter |
| `Failed to load resource: net::ERR_FILE_NOT_FOUND` | Missing file or incorrect path | Check file paths and ensure all required files are present |
| `XML parsing error: Premature end of data in tag` | Incomplete XML structure | Ensure all XML tags are properly closed |
| `Bootstrap's JavaScript requires jQuery` | Using older Bootstrap version | Upgrade to Bootstrap 5.3+ which doesn't require jQuery |

## Debugging Tools

The presentation system includes a built-in debug mode that can help identify issues. Add `?debug=true` to your URL to enable verbose logging in the console.

## Still Having Issues?

If you're still experiencing problems after trying the troubleshooting steps above, here are additional resources that may help:

1. Check the official Bootstrap documentation for potential version-specific issues
2. Look for Chart.js compatibility issues if using custom chart configurations
3. Consider browser-specific issues (try in a different browser)
4. Check for JavaScript console errors that might provide more specific information
5. Post your issue to the community forum with a minimal reproducible example

## Resources

For additional help and information, consult these resources:

- [Bootstrap Documentation](https://getbootstrap.com/docs/)
- [Chart.js Documentation](https://www.chartjs.org/docs/)
- [XML Specification](https://www.w3.org/TR/xml/)
- [XSLT Specification](https://www.w3.org/TR/xslt/)
- [Community Forum](#)
- [GitHub Repository](#)
- [Report an Issue](#)
- [Contributing Guidelines](#)
