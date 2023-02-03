import { defineConfig } from 'vite'
import FullReload from 'vite-plugin-full-reload'
import RubyPlugin from 'vite-plugin-ruby'
import vue from '@vitejs/plugin-vue'
export default defineConfig({
 
  server: {
    watch: {
      usePolling: true,
    }
  },
  plugins: [
  	FullReload(['config/routes.rb', 'app/views/**/*', 'app/frontend/**/*'], { delay: 200 }),
    RubyPlugin(),
    vue()
  ],
})