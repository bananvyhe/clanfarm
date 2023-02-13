import { defineConfig } from 'vite'
import FullReload from 'vite-plugin-full-reload'
import RubyPlugin from 'vite-plugin-ruby'
import vue from '@vitejs/plugin-vue'
import vuetify from 'vite-plugin-vuetify'
import { visualizer } from "rollup-plugin-visualizer"
import Components from 'unplugin-vue-components/vite'
import {
  VuetifyResolver,
} from 'unplugin-vue-components/resolvers'
import AutoImport from 'unplugin-auto-import/vite'
// import path from 'path';
export default defineConfig({
  // resolve: {
  //   alias: {
  //     '@/': `${path.resolve(__dirname, './src')}/`,
  //   },
  // }, 
  // server: {
    // watch: {
      // usePolling: true,
    // }
  // },
  plugins: [
    visualizer(),
  	FullReload(['config/routes.rb', 'app/views/**/*', 'app/frontend/**/*'], { delay: 200 }),
    RubyPlugin(),
    vue({
      include: [/\.vue$/, /\.md$/],
    }),
    vuetify({ 
      styles: { configFile: 'src/settings.scss' }
    }),
    AutoImport({
      imports: ['vue'],
      dts: 'src/auto-imports.d.ts',
    }),
    Components({
      resolvers: [
          VuetifyResolver(),
      ],      
      extensions: ['vue', 'md'],
      // allow auto import and register components used in markdown
      include: [/\.vue$/, /\.vue\?vue/, /\.md$/],
    })    
  ],
})
