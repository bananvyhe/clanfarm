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
            <div class="px-2 text-body-1">
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

          <v-btn
          class="px-2 py-0 mx-2 but"
          @click="clickhandler(item.id, $event)"
          :disabled="isButtonDisabled"
          small>
            открыть
          </v-btn> 
                          
          </v-col>
        </v-row>
      </v-card>
 
  </div>
</template>
<script setup lang="ts">


  import { ref, reactive, inject, onMounted, watch  } from 'vue'
  const axios: any = inject('axios')
  import { useLogStore } from '../store.js'
  const store = useLogStore()

  import { useScroll } from '@vueuse/core'
  const {arrivedState} = useScroll(document)  
  
  const pos = ref(0)
  const alld = ref([])
  const { bottom } = toRefs( arrivedState )
  watch(() => bottom.value, (val) => {
    if (val == true){
      getList(val)
    }
    console.log(val)
  })
 
  const rock = computed(() => store.trock)

  onMounted(() => {
     getList()
  })

  const getList = (val): void => {
    axios
      .get("/news", { params: { pos: pos.value } })
      .then((response: { data: any }) => {
        console.log(response.data)
        alld.value = response.data
        alld.value = alld.value.concat(response.data);
        pos.value = Object.keys(alld.value).length
        // console.log( Object.keys(alld.value).length)
    });
  };

  const loa = computed(() => store.tloa)
  const isButtonDisabled = computed(() => {
    console.log(loa.value)
    return loa.value < 5;
  });
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
.but{
  /*background-color: #dad;  */
  position: absolute;
  bottom: 1.5em;
  right: 1.5em;
}
</style>