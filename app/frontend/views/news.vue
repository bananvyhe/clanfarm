<template>
  <div>
	 news
   {{rock}}
  </div>
</template>
<script setup lang="ts">
  import { inject, onMounted } from 'vue'
  const axios: any = inject('axios')
  import { useLogStore } from '../store.js'
  const store = useLogStore()
  const rock = computed(() => store.thisrock)
  onMounted(() => {
     getList()
  })
    const getList = (): void => {
      axios
        .get("/news")
        .then((response: { data: any }) => {
          console.log(response.data)
        });
    };
     

</script>

<style scoped>

</style>