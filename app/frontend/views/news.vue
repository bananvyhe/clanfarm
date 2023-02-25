<template>
  <div>
    <ul>
      <li v-for="item in alld" >
        {{ item.head }}
      </li>
    </ul>
  </div>
</template>
<script setup lang="ts">
  import { ref, reactive, inject, onMounted } from 'vue'
  const axios: any = inject('axios')
  import { useLogStore } from '../store.js'
  const store = useLogStore()
  const rock = computed(() => store.thisrock)
  const pos = ref(0)
  const alld = ref([])

  onMounted(() => {
     getList()
  })
    const getList = (): void => {
      axios
        .get("/news",  { params: { pos: pos.value } })
        .then((response: { data: any }) => {
          console.log(response.data)
          alld.value = response.data
        });
    };
     

</script>

<style scoped>

</style>