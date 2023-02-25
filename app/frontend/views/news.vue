<template>
  <div>
	 news
   {{rock}}
  </div>
</template>
<script setup lang="ts">
  import { ref, inject, onMounted } from 'vue'
  const axios: any = inject('axios')
  import { useLogStore } from '../store.js'
  const store = useLogStore()
  const rock = computed(() => store.thisrock)
  const pos = ref(0)

  onMounted(() => {
     getList()
  })
    const getList = (): void => {
      axios
        .get("/news",  { params: { pos: pos.value } })
        .then((response: { data: any }) => {
          console.log(response.data)
        });
    };
     

</script>

<style scoped>

</style>