<template>
  <div id="app">
    <p>{{ message }}</p>
    <v-btn color="secondary">tswwss</v-btn>
  </div>
</template>

<script setup>
  import {ref} from 'vue'
  const message = ref('hello, composition API')
</script>

<style scoped>

</style>