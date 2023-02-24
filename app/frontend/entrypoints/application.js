// To see this message, add the following to the `<head>` section in your
// views/layouts/application.html.erb
//
//    <%= vite_client_tag %>
//    <%= vite_javascript_tag 'application' %>
console.log('Vite ⚡️ Rails')

// If using a TypeScript entrypoint file:
//     <%= vite_typescript_tag 'application' %>
//
// If you want to use .jsx or .tsx, add the extension:
//     <%= vite_javascript_tag 'application.jsx' %>

console.log('Visit the guide for more information: ', 'https://vite-ruby.netlify.app/guide/rails')

// Example: Load Rails libraries in Vite.
//
// import * as Turbo from '@hotwired/turbo'
// Turbo.start()
//
// import ActiveStorage from '@rails/activestorage'
// ActiveStorage.start()
//
// // Import all channels.
// const channels = import.meta.globEager('./**/*_channel.js')

// Example: Import a stylesheet in app/frontend/index.css
// import '~/index.css'
import { createApp } from 'vue/dist/vue.esm-bundler';
import { createPinia } from 'pinia'
import App from '../app.vue'
import router from '../router'

// const app = createApp({
// data() {
//     return {
//      course: 'Intro to Vue 3 and Rails'
//     }  
//   }  
// })  
import 'vuetify/styles'
import { createVuetify } from 'vuetify'
import * as ThemeDefinition  from 'vuetify'

const myCustomLightTheme = {
  dark: false,
  colors: {
    background: '#FFFFFF',
    surface: '#FFFFFF',
    primary: '#6200EE',
    'primary-darken-1': '#3700B3',
    secondary: '#03DAC6',
    'secondary-darken-1': '#018786',
    error: '#B00020',
    info: '#2196F3',
    success: '#4CAF50',
    warning: '#FB8C00',
  }
}
const pinia = createPinia()
const app = createApp(App);
const vuetify = createVuetify({
theme: {
    defaultTheme: 'dark',
    themes: {
      myCustomLightTheme,
    }  	
  }	
});

document.addEventListener('DOMContentLoaded', () => {
app.use(pinia)
app.use(router);
app.use(vuetify);
app.mount('#app');
// createApp(App).mount('#app') 
console.log("app", app);
})