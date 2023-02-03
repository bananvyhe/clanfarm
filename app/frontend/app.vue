<template>
  <div id="app">
    <p>{{ message }}</p>
  </div>
</template>

<script setup>
  import {ref} from 'vue'
  const message = ref('hello, composition API')
</script>

<style scoped>

</style>