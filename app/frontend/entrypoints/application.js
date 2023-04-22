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
import { createApp, inject } from 'vue/dist/vue.esm-bundler';
import { createPinia } from 'pinia'
import App from '../app.vue'
import router from '../router'
import axios from 'axios'
import VueAxios from 'vue-axios'
import { securedAxiosInstance, plainAxiosInstance } from '../backend/axios'
// import piniaPluginPersistedstate from 'pinia-plugin-persistedstate'
// import { aliases, mdi } from 'vuetify/iconsets/mdi'
 import '@mdi/font/css/materialdesignicons.css'
import Notifications from '@kyvg/vue3-notification'
import ls from 'localstorage-slim';
import encUTF8 from 'crypto-js/enc-utf8';
import AES from 'crypto-js/aes';
ls.config.encrypt = true; 
ls.config.secret = 'bananvyhe';
ls.config.encrypter = (data, secret) => AES.encrypt(JSON.stringify(data), secret).toString();
ls.config.decrypter = (data, secret) => {
  try {
    return JSON.parse(AES.decrypt(data, secret).toString(encUTF8));
  } catch (e) {
    // incorrect/missing secret, return the encrypted data instead
    return data;
  }
};

  // if (ls.get('load')){
  //   var loaf = ls.get('load')
  //   ls.set('account.loa', loaf)
  //   ls.remove('load'); 
  //   console.log("0")
  // }

  if (!ls.get('account').loa){
    ls.set('account.loa', 0)  
    // console.log("0")
  }

  if (!ls.get('account').signedIn){
    ls.set('account.signedIn', false)  
  }  
  // if (!ls.get('role')){
  //   ls.set('role', false)  
  // }
  // if (!ls.get('email')){
  //   ls.set('email', false)  
  // }  
// const app = createApp({
// data() {
//     return {
//      course: 'Intro to Vue 3 and Rails'
//     }  
//   }  
// })  

import 'vuetify/styles'
// import "../src/styles/global.scss"
import { createVuetify } from 'vuetify'
 
import * as ThemeDefinition  from 'vuetify'
// import 'c' 
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
const customDarkTheme = {
  dark: true,
  colors: {
    background: "#15202b",
    // surface: "#15202b",
    'surface-variant': '#ccc1b3',
    primary: "#3f51b5",
    secondary: "#03dac6",
    error: "#ff5722",
  },
};




// app.provide('securedAxiosInstance', securedAxiosInstance)
// app.provide('plainAxiosInstance', plainAxiosInstance)
// app.mixin({
//   mounted() {
//     this.securedAxios = inject('securedAxiosInstance')
//     this.plainAxios = inject('plainAxiosInstance')
//   }
// })

const vuetify = createVuetify({
  // icons: {
  //   defaultSet: 'mdi',
  //   aliases,
  //   sets: {
  //     mdi,
  //   }
  // },  
theme: {
    defaultTheme: 'customDarkTheme',
    themes: {
      customDarkTheme,
      myCustomLightTheme,
    }  	
  }	
});
const pinia = createPinia()
// pinia.use(piniaPluginPersistedstate)
const app = createApp(App);

app.use(pinia)
// document.addEventListener('DOMContentLoaded', () => {

app.use(router);
// app.use(VueAxios, axios)
app.use(VueAxios, {
  secured: securedAxiosInstance,
  plain: plainAxiosInstance
})

app.provide('plain', app.config.globalProperties.plain) 
app.provide('secured', app.config.globalProperties.secured) 
app.provide('axios', app.config.globalProperties.axios)

app.use(vuetify);
app.use(Notifications)
app.mount('#app');
// createApp(App).mount('#app') 
// console.log("app", app);
// })