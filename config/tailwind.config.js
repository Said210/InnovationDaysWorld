const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    colors: {
      transparent: 'transparent',
      current: 'currentColor',
      'white': '#ffffff',
      'black': '#000000',
      'primary': {
        100: '#d2dfea',
        200: '#a5bfd4',
        300: '#789ebf',
        400: '#4b7ea9',
        500: '#1E5E94',
        600: '#184b76',
        700: '#123859',
        800: '#0c263b',
        900: '#06131e',
      },
      'secondary': {
        100: '#dfd6e9',
        200: '#bfadd3',
        300: '#9f84be',
        400: '#7f5ba8',
        500: '#5F3292',
        600: '#4c2875',
        700: '#391e58',
        800: '#26143a',
        900: '#130a1d',
      },
      'grey': {
        100: '#f6f6f6',
        200: '#ededed',
        300: '#c8c8c8',
        400: '#b5b5b5',
        500: '#a3a3a3',
        600: '#828282',
        700: '#626262',
        800: '#414141',
        900: '#212121',
      }
    },
    extend: {
      fontFamily: {
        montserrat: ['Montserrat', 'sans-serif'],
        sans: ['ui-sans-serif', 'system-ui', '-apple-system','Inter var', ...defaultTheme.fontFamily.sans],
        icon: ['FontAwesome']
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography')
  ]
}
