module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      fontFamily: {
        bizud: ['BIZ UDGothic', 'sans-serif'],
      },
    },
  },
  plugins: [require("daisyui")],
  daisyui: {
    themes: [
      {
        mytheme: {
        
          "primary": "#d1d5db",
                  
          "secondary": "#d1d5db",
                  
          "accent": "#d1d5db",
                  
          "neutral": "#d1d5db",
                  
          "base-100": "#ffffff",
                  
          "info": "#d1d5db",
                  
          "success": "#d1d5db",
                  
          "warning": "#d1d5db",
                  
          "error": "#d1d5db",
                  },
                },
              ],
            },
}
