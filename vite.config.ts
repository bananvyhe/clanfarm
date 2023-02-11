import { defineConfig } from 'vite'
import FullReload from 'vite-plugin-full-reload'
import RubyPlugin from 'vite-plugin-ruby'
import vue from '@vitejs/plugin-vue'
import vuetify from 'vite-plugin-vuetify'
import { visualizer } from "rollup-plugin-visualizer"
export default defineConfig({
 
  server: {
    watch: {
      usePolling: true,
    }
  },
  plugins: [
    visualizer(),
  	FullReload(['config/routes.rb', 'app/views/**/*', 'app/frontend/**/*'], { delay: 200 }),
    RubyPlugin(),
    vue(),
    vuetify({ 
      autoImport: true,
      // configFile: 'src/settings.scss'
    }), // Enabled by default
  ],
})
