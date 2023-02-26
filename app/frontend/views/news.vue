<template>
  <div>
 
      <v-card v-for="item in alld" class="px-1 my-2 py-2 ">
        <v-row>
          <v-col>
            <div 
            class="align-top float-left mr-1 px-3 py-md-1 mx-md-1">
            <!-- v-bind:style="{backgroundImage: 'url('+ item.pic}" -->
              <div class ="pic px-0 align-center my-2" >
                <!-- {{pos}} -->
              </div>
            </div >
            <div class="px-2 pt-2 pb-2 colr"
             >
              <h3>{{ item.head }}</h3>
            </div>
            <div class="px-2 body-1">
            {{item.desc}}… 
            </div>
            <v-card-subtitle
            class="px-2 py-0 float-left date">
            {{item.date}} 
            </v-card-subtitle>
          <v-btn  
            target="_blank" 
            v-bind:href="item.link"
            class="px-1 py-0 float-left"
            color="orange lighten-2"
            variant="text"
            size="x-small">
            источник
          </v-btn>              
          </v-col>
        </v-row>
      </v-card>
 
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
.pic {
  /*background-color: #dad;*/
  width: 100px;
  height: 100px;
}
.colr{
  /*color: #60845b;*/
  color: #657d62;
}
.date{
  color: #9d9681; 
}
</style>