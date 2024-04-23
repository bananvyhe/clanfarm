<template>
<div class="d-flex">
  <VueDatePicker v-model="date" dark locale="ru"  time-picker-inline disable-month-year-select  uid="demo"    class="vdp" auto-apply :min-date="new Date()"  :preview-format="format"/>
  <div>
    <p v-if="date"> {{ date }}</p>
  </div>
</div> 
</template>
<script setup lang="ts">
 
 
// import { useLogStore } from './store.js'  
// const store = useLogStore()

// import { ref, computed, watch, reactive, onMounted, onBeforeMount, toRefs } from 'vue'

// const plain: any = inject('plain')
// const secured: any = inject('secured')
const date = ref(new Date());
const format = (date) => {
  const day = date.getDate();
  const month = date.getMonth() + 1;
  const year = date.getFullYear();

  return `${day}/${month}/${year}`;
}
onMounted(() => {
 
})
 
</script>

<style scoped  lang="scss" >
.vdp{
  width: 200px;
}
</style>