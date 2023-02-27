import { defineConfig } from 'vite'
import FullReload from 'vite-plugin-full-reload'
import RubyPlugin from 'vite-plugin-ruby'
import vue from '@vitejs/plugin-vue'
import vuetify, { transformAssetUrls } from 'vite-plugin-vuetify'
import { visualizer } from "rollup-plugin-visualizer"
import Components from 'unplugin-vue-components/vite'
import {
  VuetifyResolver,
} from 'unplugin-vue-components/resolvers'
import AutoImport from 'unplugin-auto-import/vite'
// import path from 'path';
export default defineConfig({
 
  plugins: [
    visualizer(),
  	FullReload(['config/routes.rb', 'app/views/**/*', 'app/frontend/**/*'], { delay: 200 }),
    RubyPlugin(),
    vue({
      include: [/\.vue$/, /\.md$/],
      template: { transformAssetUrls }
    }),
    vuetify({ 
      autoImport: true,
      treeShake: true,
      styles: { 
        configFile: 'src/settings.scss',    
      }
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

    // css: {
    // // Add your global CSS file here
    // preprocessorOptions: {
    //   scss: {
    //     additionalData: `@import "./src/styles/global.scss";`,
    //   },
    // },
  // },
 
})
