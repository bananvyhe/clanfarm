<template>
<div class="d-flex">
<!--   <VueDatePicker v-model="date" dark locale="ru"  time-picker-inline disable-month-year-select  uid="demo"    class="vdp" auto-apply :min-date="new Date()"  :format="format"  model-type="timestamp"/>
  <div class="d-flex align-center mx-2">
    <p v-if="date"> {{ date }}</p>
  </div> -->


  <div v-for="item in date" :key="item">
 {{item}}
  </div>
   <v-btn @click="addItem">
  добавить
</v-btn>
<!--     <v-switch
    density ="compact"
      v-model="people"
      color="primary"
      label="John"
      value="John"
      hide-details
    ></v-switch>
    <v-switch
      density ="compact"
      v-model="people"
      color="primary"
      label="Jacob"
      value="Jacob"
      hide-details
    ></v-switch> -->

</div> 

</template>
<script setup lang="ts">
 const switcher = ref(true)
 const people = ref(['John'])
// import { useLogStore } from './store.js'  
// const store = useLogStore()

// import { ref, computed, watch, reactive, onMounted, onBeforeMount, toRefs } from 'vue'

// const plain: any = inject('plain')
// const secured: any = inject('secured')
const date = ref(['123', '567', '896'])
const addItem = () => {
  date.value.push('666');
};
// const date = ref(new Date().getTime());
const format = (date) => {
  const day = date.getDate();
  const month = date.getMonth() + 1;
  const year = date.getFullYear();
  const hours = date.getHours();
  const minutes = date.getMinutes();
  return `${day}.${month}.${year} ${hours}:${minutes}`;
}
onMounted(() => {
 
})
 
</script>

<style scoped  lang="scss" >
.vdp{
  width: 200px;
}
</style>