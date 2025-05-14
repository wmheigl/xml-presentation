/**
 * Presentation.js - JavaScript for Bootstrap-based XML/XSL presentations
 */

console.log("==== Presentation.js loaded and executing ====");

// Debug DOM structure
console.log("Document body:", document.body);
console.log("Slides container exists:", !!document.getElementById('slides-container'));
console.log("Navigation buttons:", {
    prev: document.getElementById('prev'),
    next: document.getElementById('next'),
    fullscreen: document.getElementById('fullscreen'),
    notes: document.getElementById('speaker-notes')
});

// Function to highlight interactive elements
function highlightElements() {
    const buttons = document.querySelectorAll('button');
    buttons.forEach(button => {
        button.style.border = '2px solid red';
        console.log("Button found:", button.id || 'unnamed', button);
    });
    
    const slides = document.querySelectorAll('.slide');
    console.log("Slides found:", slides.length);
    slides.forEach((slide, index) => {
        console.log(`Slide ${index}:`, slide);
    });
}

// Run this after a short delay to ensure DOM is processed
setTimeout(highlightElements, 1000);

document.addEventListener('DOMContentLoaded', function() {
    // Initialize presentation
    const slidesContainer = document.getElementById('slides-container');
    const slides = Array.from(slidesContainer.children);
    let currentSlideIndex = 0;

    // for debugging
    console.log("Slides container:", slidesContainer);
    console.log("Number of slides found:", slides.length);
    console.log("First slide:", slides[0]);
    
    // Handle broken images
    const images = document.querySelectorAll('img');
    images.forEach(img => {
        img.onerror = function() {
            // Replace with a generic placeholder
            this.src = 'data:image/svg+xml,%3Csvg width="800" height="450" xmlns="http://www.w3.org/2000/svg"%3E%3Crect width="100%25" height="100%25" fill="%23f0f0f0"/%3E%3Ctext x="50%25" y="50%25" font-family="Arial" font-size="24" text-anchor="middle" fill="%23666666"%3EPlaceholder Image%3C/text%3E%3C/svg%3E';
            this.alt = 'Placeholder image';
        };
    });

    // Show first slide
    if (slides.length > 0) {
        slides[0].classList.add('active');
        updateSpeakerNotes(slides[0]);
    }
    
    // Update progress bar and slide counter
    updateProgress();
    
    // Set up navigation event listeners
    document.getElementById('prev').addEventListener('click', previousSlide);
    document.getElementById('next').addEventListener('click', nextSlide);
    document.getElementById('fullscreen').addEventListener('click', toggleFullscreen);
    document.getElementById('speaker-notes').addEventListener('click', toggleSpeakerNotes);
    document.getElementById('close-notes').addEventListener('click', toggleSpeakerNotes);
    
    // Keyboard navigation
    document.addEventListener('keydown', handleKeyboardNavigation);
    
    // Initialize charts if Chart.js is available
    if (typeof Chart !== 'undefined') {
        initCharts();
    }
    
    /**
     * Navigation functions
     */
    function goToSlide(index) {
        if (index < 0 || index >= slides.length) return;
        
        // Hide current slide
        slides[currentSlideIndex].classList.remove('active');
        
        // Show new slide
        slides[index].classList.add('active');
        currentSlideIndex = index;
        
        // Update UI elements
        updateProgress();
        updateSpeakerNotes(slides[currentSlideIndex]);
    }
    
    function nextSlide() {
        goToSlide(currentSlideIndex + 1);
    }
    
    function previousSlide() {
        goToSlide(currentSlideIndex - 1);
    }
    
    function updateProgress() {
        // Update slide counter
        document.getElementById('slide-counter').textContent = `${currentSlideIndex + 1} / ${slides.length}`;
        
        // Update progress bar
        const progressPercentage = ((currentSlideIndex + 1) / slides.length) * 100;
        document.querySelector('.progress-bar').style.width = `${progressPercentage}%`;
    }
    
    function handleKeyboardNavigation(e) {
        switch (e.key) {
            case 'ArrowRight':
            case ' ':
            case 'PageDown':
                nextSlide();
                e.preventDefault();
                break;
            case 'ArrowLeft':
            case 'PageUp':
                previousSlide();
                e.preventDefault();
                break;
            case 'Home':
                goToSlide(0);
                e.preventDefault();
                break;
            case 'End':
                goToSlide(slides.length - 1);
                e.preventDefault();
                break;
            case 'f':
                toggleFullscreen();
                e.preventDefault();
                break;
            case 'n':
                toggleSpeakerNotes();
                e.preventDefault();
                break;
        }
    }
    
    /**
     * Fullscreen handling
     */
    function toggleFullscreen() {
        if (!document.fullscreenElement) {
            document.documentElement.requestFullscreen().catch(err => {
                console.error(`Error attempting to enable fullscreen: ${err.message}`);
            });
        } else {
            document.exitFullscreen();
        }
    }
    
    /**
     * Speaker notes
     */
    function toggleSpeakerNotes() {
        const notesPanel = document.getElementById('speaker-notes-panel');
        if (notesPanel.style.display === 'none' || notesPanel.style.display === '') {
            notesPanel.style.display = 'block';
            notesPanel.classList.remove('hidden');
        } else {
            notesPanel.style.display = 'none';
            notesPanel.classList.add('hidden');
        }
    }
    
    function updateSpeakerNotes(slide) {
        const notesContent = document.getElementById('current-notes');
        const notes = slide.getAttribute('data-notes');
        
        if (notes) {
            notesContent.textContent = notes;
        } else {
            notesContent.textContent = 'No speaker notes available for this slide.';
        }
    }
    
    /**
     * Chart initialization if Chart.js is available
     */
    function initCharts() {
        const chartElements = document.querySelectorAll('.chart');
        
        chartElements.forEach(chartElement => {
            const chartType = chartElement.getAttribute('data-chart-type');
            const chartData = JSON.parse(chartElement.getAttribute('data-chart-data'));
            const chartOptions = chartElement.getAttribute('data-chart-options') 
                ? JSON.parse(chartElement.getAttribute('data-chart-options')) 
                : {};
            
            // Create canvas element for the chart
            const canvas = document.createElement('canvas');
            chartElement.appendChild(canvas);
            
            // Create chart
            createChart(canvas, chartType, chartData, chartOptions);
            
            // Mark chart as loaded to remove loading indicator
            chartElement.classList.add('loaded');
        });
    }
    
    /**
     * Create a chart using Chart.js
     */
    function createChart(canvas, type, data, customOptions = {}) {
        // Process data for Chart.js format
        const chartData = processChartData(type, data);
        
        // Default options based on chart type
        const defaultOptions = getDefaultChartOptions(type);
        
        // Merge default options with custom options
        const options = mergeOptions(defaultOptions, customOptions);
        
        // Create the chart
        new Chart(canvas, {
            type: type,
            data: chartData,
            options: options
        });
    }
    
    /**
     * Process chart data from XML format to Chart.js format
     */
    function processChartData(type, data) {
        // Check if data is already in Chart.js format (has labels and datasets)
        if (data.labels && data.datasets) {
            return data;
        }
        
        // Extract labels and values from data
        const labels = data.map(item => Object.values(item)[0]);
        const values = data.map(item => Object.values(item)[1]);
        
        // Format based on chart type
        if (type === 'pie' || type === 'doughnut') {
            // Generate colors for pie/doughnut segments
            const colors = generateColors(values.length);
            
            return {
                labels: labels,
                datasets: [{
                    data: values,
                    backgroundColor: colors,
                    borderColor: colors.map(color => adjustColorBrightness(color, -0.2)),
                    borderWidth: 1
                }]
            };
        } else if (type === 'line') {
            return {
                labels: labels,
                datasets: [{
                    label: 'Value',
                    data: values,
                    borderColor: getComputedStyle(document.documentElement).getPropertyValue('--bs-primary').trim() || '#0d6efd',
                    backgroundColor: hexToRgba(getComputedStyle(document.documentElement).getPropertyValue('--bs-primary').trim() || '#0d6efd', 0.2),
                    borderWidth: 2,
                    pointRadius: 4,
                    pointHoverRadius: 6,
                    tension: 0.3
                }]
            };
        } else { // bar, radar, etc.
            return {
                labels: labels,
                datasets: [{
                    label: 'Value',
                    data: values,
                    backgroundColor: hexToRgba(getComputedStyle(document.documentElement).getPropertyValue('--bs-primary').trim() || '#0d6efd', 0.7),
                    borderColor: getComputedStyle(document.documentElement).getPropertyValue('--bs-primary').trim() || '#0d6efd',
                    borderWidth: 1
                }]
            };
        }
    }
    
    /**
     * Get default options for different chart types
     */
    function getDefaultChartOptions(type) {
        // Common options for all chart types
        const commonOptions = {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: type === 'pie' || type === 'doughnut',
                    position: 'bottom',
                    labels: {
                        font: {
                            family: getComputedStyle(document.documentElement).getPropertyValue('--bs-body-font-family').trim() || 'system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial'
                        },
                        color: getComputedStyle(document.documentElement).getPropertyValue('--bs-body-color').trim() || '#212529'
                    }
                },
                tooltip: {
                    enabled: true,
                    mode: 'index',
                    intersect: false,
                    bodyFont: {
                        family: getComputedStyle(document.documentElement).getPropertyValue('--bs-body-font-family').trim() || 'system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial'
                    },
                    backgroundColor: getComputedStyle(document.documentElement).getPropertyValue('--bs-dark').trim() || '#212529',
                    titleColor: getComputedStyle(document.documentElement).getPropertyValue('--bs-light').trim() || '#f8f9fa',
                    bodyColor: getComputedStyle(document.documentElement).getPropertyValue('--bs-light').trim() || '#f8f9fa',
                    borderColor: getComputedStyle(document.documentElement).getPropertyValue('--bs-border-color').trim() || '#dee2e6',
                    borderWidth: 1
                }
            }
        };
        
        // Chart-specific options
        switch(type) {
            case 'bar':
                return mergeOptions(commonOptions, {
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                color: hexToRgba(getComputedStyle(document.documentElement).getPropertyValue('--bs-border-color').trim() || '#dee2e6', 0.2)
                            },
                            ticks: {
                                font: {
                                    family: getComputedStyle(document.documentElement).getPropertyValue('--bs-body-font-family').trim() || 'system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial'
                                },
                                color: getComputedStyle(document.documentElement).getPropertyValue('--bs-body-color').trim() || '#212529'
                            }
                        },
                        x: {
                            grid: {
                                display: false
                            },
                            ticks: {
                                font: {
                                    family: getComputedStyle(document.documentElement).getPropertyValue('--bs-body-font-family').trim() || 'system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial'
                                },
                                color: getComputedStyle(document.documentElement).getPropertyValue('--bs-body-color').trim() || '#212529'
                            }
                        }
                    },
                    animation: {
                        duration: 1000,
                        easing: 'easeOutQuart'
                    }
                });
            case 'line':
                return mergeOptions(commonOptions, {
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                color: hexToRgba(getComputedStyle(document.documentElement).getPropertyValue('--bs-border-color').trim() || '#dee2e6', 0.2)
                            },
                            ticks: {
                                font: {
                                    family: getComputedStyle(document.documentElement).getPropertyValue('--bs-body-font-family').trim() || 'system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial'
                                },
                                color: getComputedStyle(document.documentElement).getPropertyValue('--bs-body-color').trim() || '#212529'
                            }
                        },
                        x: {
                            grid: {
                                display: false
                            },
                            ticks: {
                                font: {
                                    family: getComputedStyle(document.documentElement).getPropertyValue('--bs-body-font-family').trim() || 'system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial'
                                },
                                color: getComputedStyle(document.documentElement).getPropertyValue('--bs-body-color').trim() || '#212529'
                            }
                        }
                    },
                    animation: {
                        duration: 1500,
                        easing: 'easeOutQuart'
                    }
                });
            case 'pie':
            case 'doughnut':
                return mergeOptions(commonOptions, {
                    cutout: type === 'doughnut' ? '50%' : 0,
                    animation: {
                        animateRotate: true,
                        animateScale: true,
                        duration: 1000,
                        easing: 'easeOutCirc'
                    }
                });
            default:
                return commonOptions;
        }
    }
    
    /**
     * Merge two option objects
     */
    function mergeOptions(obj1, obj2) {
        const result = {...obj1};
        
        for (const key in obj2) {
            if (obj2.hasOwnProperty(key)) {
                if (obj2[key] !== null && typeof obj2[key] === 'object' && !Array.isArray(obj2[key]) &&
                    obj1[key] !== null && typeof obj1[key] === 'object' && !Array.isArray(obj1[key])) {
                    result[key] = mergeOptions(obj1[key], obj2[key]);
                } else {
                    result[key] = obj2[key];
                }
            }
        }
        
        return result;
    }
    
    /**
     * Generate an array of colors for charts
     */
    function generateColors(count) {
        // Get theme colors from Bootstrap
        const colors = [
            getComputedStyle(document.documentElement).getPropertyValue('--bs-primary').trim() || '#0d6efd',
            getComputedStyle(document.documentElement).getPropertyValue('--bs-secondary').trim() || '#6c757d',
            getComputedStyle(document.documentElement).getPropertyValue('--bs-success').trim() || '#198754',
            getComputedStyle(document.documentElement).getPropertyValue('--bs-info').trim() || '#0dcaf0',
            getComputedStyle(document.documentElement).getPropertyValue('--bs-warning').trim() || '#ffc107',
            getComputedStyle(document.documentElement).getPropertyValue('--bs-danger').trim() || '#dc3545',
            getComputedStyle(document.documentElement).getPropertyValue('--bs-light').trim() || '#f8f9fa',
            getComputedStyle(document.documentElement).getPropertyValue('--bs-dark').trim() || '#212529'
        ];
        
        // If we need more colors than available, generate variations
        const result = [];
        
        for (let i = 0; i < count; i++) {
            if (i < colors.length) {
                result.push(colors[i]);
            } else {
                // Create variations by adjusting brightness
                const baseColor = colors[i % colors.length];
                const variation = 0.2 + (0.1 * Math.floor(i / colors.length));
                result.push(adjustColorBrightness(baseColor, variation * (i % 2 === 0 ? 1 : -1)));
            }
        }
        
        return result;
    }
    
    /**
     * Adjust color brightness
     */
    function adjustColorBrightness(hexColor, factor) {
        // Remove # if present
        let hex = hexColor.replace('#', '');
        
        // Ensure 6-digit hex
        if (hex.length === 3) {
            hex = hex[0] + hex[0] + hex[1] + hex[1] + hex[2] + hex[2];
        }
        
        // Convert to RGB
        const r = parseInt(hex.substring(0, 2), 16);
        const g = parseInt(hex.substring(2, 4), 16);
        const b = parseInt(hex.substring(4, 6), 16);
        
        // Adjust brightness
        const adjustedR = Math.min(255, Math.max(0, r + (factor * 255)));
        const adjustedG = Math.min(255, Math.max(0, g + (factor * 255)));
        const adjustedB = Math.min(255, Math.max(0, b + (factor * 255)));
        
        // Convert back to hex
        return '#' + 
            Math.round(adjustedR).toString(16).padStart(2, '0') + 
            Math.round(adjustedG).toString(16).padStart(2, '0') + 
            Math.round(adjustedB).toString(16).padStart(2, '0');
    }
    
    /**
     * Convert hex color to rgba
     */
    function hexToRgba(hex, alpha) {
        // Remove # if present
        let rgb = hex.replace('#', '');
        
        // Ensure 6-digit hex
        if (rgb.length === 3) {
            rgb = rgb[0] + rgb[0] + rgb[1] + rgb[1] + rgb[2] + rgb[2];
        }
        
        // Convert to RGB
        const r = parseInt(rgb.substring(0, 2), 16);
        const g = parseInt(rgb.substring(2, 4), 16);
        const b = parseInt(rgb.substring(4, 6), 16);
        
        return `rgba(${r}, ${g}, ${b}, ${alpha})`;
    }
});
