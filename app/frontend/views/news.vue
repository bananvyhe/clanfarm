<template>
  <div>
	 news
   {{rock}}
  </div>
</template>
<script setup lang="ts">
  import { inject } from 'vue'
  import { useLogStore } from '../store.js'
  const store = useLogStore()
  const rock = computed(() => store.thisrock)
</script>

<style scoped>

</style>