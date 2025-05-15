/**
 * Presentation.js - Modern JavaScript for Bootstrap-based XML/XSL presentations
 */

// Use an IIFE to avoid global namespace pollution but expose necessary functions
const PresentationApp = (() => {
  // State management
  const state = {
    slidesContainer: null,
    slides: [],
    currentSlideIndex: 0
  };

  // Initialize the presentation
  const init = () => {
    console.log("Initializing presentation");
    
    // Get DOM elements
    state.slidesContainer = document.getElementById('slides-container');
    if (!state.slidesContainer) {
      console.error("Slides container not found!");
      return;
    }
    
    state.slides = Array.from(state.slidesContainer.children);
    console.log(`Found ${state.slides.length} slides`);
    
    // Set up navigation event listeners
    setupEventListeners();
    
    // Initialize charts if available
    if (typeof Chart !== 'undefined') {
      ChartModule.initCharts();
    }
    
    // Show first slide
    if (state.slides.length > 0) {
      console.log("Activating first slide");
      goToSlide(0);
    }
  };
  
  // Setup all event listeners
  const setupEventListeners = () => {
    // Navigation buttons
    document.getElementById('prev')?.addEventListener('click', previousSlide);
    document.getElementById('next')?.addEventListener('click', nextSlide);
    document.getElementById('fullscreen')?.addEventListener('click', toggleFullscreen);
    document.getElementById('speaker-notes')?.addEventListener('click', toggleSpeakerNotes);
    document.getElementById('close-notes')?.addEventListener('click', toggleSpeakerNotes);
    
    // Keyboard navigation
    document.addEventListener('keydown', handleKeyboardNavigation);
  };

  // Navigation functions
  const goToSlide = (index) => {
    console.log(`Going to slide ${index}`);
    if (!state.slides?.length) return;
    
    if (index < 0 || index >= state.slides.length) return;
    
    // Hide current slide
    state.slides[state.currentSlideIndex]?.classList.remove('active');
    
    // Show new slide
    state.slides[index].classList.add('active');
    state.currentSlideIndex = index;
    
    // Update UI elements
    updateProgress();
    updateSpeakerNotes(state.slides[state.currentSlideIndex]);
  };

  const nextSlide = () => goToSlide(state.currentSlideIndex + 1);
  const previousSlide = () => goToSlide(state.currentSlideIndex - 1);

  const toggleFullscreen = () => {
    if (!document.fullscreenElement) {
      document.documentElement.requestFullscreen().catch(err => {
        console.error(`Error attempting to enable fullscreen:`, err);
      });
    } else {
      document.exitFullscreen();
    }
  };

  const toggleSpeakerNotes = () => {
    const notesPanel = document.getElementById('speaker-notes-panel');
    if (!notesPanel) return;
    
    const isHidden = notesPanel.style.display === 'none' || notesPanel.style.display === '';
    notesPanel.style.display = isHidden ? 'block' : 'none';
    notesPanel.classList.toggle('hidden', !isHidden);
  };

  const updateProgress = () => {
    // Update slide counter
    const counter = document.getElementById('slide-counter');
    if (counter) {
      counter.textContent = `${state.currentSlideIndex + 1} / ${state.slides.length}`;
    }
    
    // Update progress bar
    const progressBar = document.querySelector('.progress-bar');
    if (progressBar) {
      const progressPercentage = ((state.currentSlideIndex + 1) / state.slides.length) * 100;
      progressBar.style.width = `${progressPercentage}%`;
    }
  };

  const updateSpeakerNotes = (slide) => {
    const notesContent = document.getElementById('current-notes');
    if (!notesContent) return;
    
    const notes = slide.getAttribute('data-notes');
    notesContent.textContent = notes || 'No speaker notes available for this slide.';
  };

  const handleKeyboardNavigation = (e) => {
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
        goToSlide(state.slides.length - 1);
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
  };

  /**
   * Chart Module
   */
  const ChartModule = (() => {
    /**
     * Initialize all charts on the page
     */
    const initCharts = () => {
      if (typeof Chart === 'undefined') {
        console.log("Chart.js not available - skipping chart initialization");
        return;
      }
      
      const chartElements = document.querySelectorAll('.chart');
      console.log(`Found ${chartElements.length} charts to initialize`);
      
      chartElements.forEach(chartElement => {
        try {
          const chartType = chartElement.getAttribute('data-chart-type');
          const chartDataStr = chartElement.getAttribute('data-chart-data');
          const chartOptionsStr = chartElement.getAttribute('data-chart-options');
          
          if (!chartType || !chartDataStr) {
            console.error("Missing required chart attributes", chartElement);
            return;
          }
          
          const chartData = JSON.parse(chartDataStr);
          const chartOptions = chartOptionsStr ? JSON.parse(chartOptionsStr) : {};
          
          // Create canvas element for the chart
          const canvas = document.createElement('canvas');
          chartElement.appendChild(canvas);
          
          // Create chart
          createChart(canvas, chartType, chartData, chartOptions);
          
          // Mark chart as loaded to remove loading indicator
          chartElement.classList.add('loaded');
        } catch (error) {
          console.error("Error initializing chart:", error);
          chartElement.innerHTML = `<div class="alert alert-danger">Chart could not be loaded: ${error.message}</div>`;
        }
      });
    };
    
    /**
     * Create a Chart.js chart
     */
    const createChart = (canvas, type, data, customOptions = {}) => {
      // Process data for Chart.js format
      const chartData = processChartData(type, data);
      
      // Default options based on chart type
      const defaultOptions = getDefaultChartOptions(type);
      
      // Merge default options with custom options
      const options = mergeOptions(defaultOptions, customOptions);
      
      // Create the chart
      new Chart(canvas, {
        type,
        data: chartData,
        options
      });
    };
    
    /**
     * Process chart data from XML format to Chart.js format
     */
    const processChartData = (type, data) => {
      // Check if data is already in Chart.js format
      if (data.labels && data.datasets) {
        return data;
      }
      
      // Extract labels and values from data
      const labels = data.map(item => Object.values(item)[0]);
      const values = data.map(item => Object.values(item)[1]);
      
      const primaryColor = getCssVariable('--bs-primary', '#0d6efd');
      
      // Format based on chart type
      if (['pie', 'doughnut'].includes(type)) {
        const colors = generateColors(values.length);
        
        return {
          labels,
          datasets: [{
            data: values,
            backgroundColor: colors,
            borderColor: colors.map(color => adjustColorBrightness(color, -0.2)),
            borderWidth: 1
          }]
        };
      } else if (type === 'line') {
        return {
          labels,
          datasets: [{
            label: 'Value',
            data: values,
            borderColor: primaryColor,
            backgroundColor: hexToRgba(primaryColor, 0.2),
            borderWidth: 2,
            pointRadius: 4,
            pointHoverRadius: 6,
            tension: 0.3
          }]
        };
      } else { // bar, radar, etc.
        return {
          labels,
          datasets: [{
            label: 'Value',
            data: values,
            backgroundColor: hexToRgba(primaryColor, 0.7),
            borderColor: primaryColor,
            borderWidth: 1
          }]
        };
      }
    };
    
    /**
     * Get CSS variable value with fallback
     */
    const getCssVariable = (varName, fallback) => {
      return getComputedStyle(document.documentElement).getPropertyValue(varName).trim() || fallback;
    };
    
    /**
     * Get default options for different chart types
     */
    const getDefaultChartOptions = (type) => {
      // Common options for all chart types
      const bodyColor = getCssVariable('--bs-body-color', '#212529');
      const fontFamily = getCssVariable('--bs-body-font-family', 
        'system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial');
      const borderColor = getCssVariable('--bs-border-color', '#dee2e6');
      
      const commonOptions = {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            display: ['pie', 'doughnut'].includes(type),
            position: 'bottom',
            labels: {
              font: { family: fontFamily },
              color: bodyColor
            }
          },
          tooltip: {
            enabled: true,
            mode: 'index',
            intersect: false,
            bodyFont: { family: fontFamily }
          }
        }
      };
      
      // Chart-specific options
      const typeOptions = {
        bar: {
          scales: {
            y: {
              beginAtZero: true,
              grid: { color: hexToRgba(borderColor, 0.2) },
              ticks: {
                font: { family: fontFamily },
                color: bodyColor
              }
            },
            x: {
              grid: { display: false },
              ticks: {
                font: { family: fontFamily },
                color: bodyColor
              }
            }
          },
          animation: {
            duration: 1000,
            easing: 'easeOutQuart'
          }
        },
        line: {
          scales: {
            y: {
              beginAtZero: true,
              grid: { color: hexToRgba(borderColor, 0.2) },
              ticks: {
                font: { family: fontFamily },
                color: bodyColor
              }
            },
            x: {
              grid: { display: false },
              ticks: {
                font: { family: fontFamily },
                color: bodyColor
              }
            }
          },
          animation: {
            duration: 1500,
            easing: 'easeOutQuart'
          }
        },
        pie: {
          cutout: 0,
          animation: {
            animateRotate: true,
            animateScale: true,
            duration: 1000,
            easing: 'easeOutCirc'
          }
        },
        doughnut: {
          cutout: '50%',
          animation: {
            animateRotate: true,
            animateScale: true,
            duration: 1000,
            easing: 'easeOutCirc'
          }
        }
      };
      
      return mergeOptions(commonOptions, typeOptions[type] || {});
    };
    
    // Helper functions
    const mergeOptions = (obj1, obj2) => {
      const result = {...obj1};
      
      for (const key in obj2) {
        if (Object.prototype.hasOwnProperty.call(obj2, key)) {
          if (obj2[key] !== null && typeof obj2[key] === 'object' && !Array.isArray(obj2[key]) &&
              obj1[key] !== null && typeof obj1[key] === 'object' && !Array.isArray(obj1[key])) {
            result[key] = mergeOptions(obj1[key], obj2[key]);
          } else {
            result[key] = obj2[key];
          }
        }
      }
      
      return result;
    };
    
    const generateColors = (count) => {
      // Bootstrap colors
      const colors = [
        getCssVariable('--bs-primary', '#0d6efd'),
        getCssVariable('--bs-secondary', '#6c757d'),
        getCssVariable('--bs-success', '#198754'),
        getCssVariable('--bs-info', '#0dcaf0'),
        getCssVariable('--bs-warning', '#ffc107'),
        getCssVariable('--bs-danger', '#dc3545')
      ];
      
      // Generate variations if we need more
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
    };
    
    const adjustColorBrightness = (hexColor, factor) => {
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
    };
    
    const hexToRgba = (hex, alpha) => {
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
    };
    
    // Public API
    return {
      initCharts
    };
  })();

  // Initialize presentation based on document ready state
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
  
  // Return public API
  return {
    nextSlide,
    previousSlide,
    goToSlide,
    toggleFullscreen,
    toggleSpeakerNotes,
    initCharts: ChartModule.initCharts
  };
})();
