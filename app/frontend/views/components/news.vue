<template>

<v-row>
    <v-col v-for="item in alld" class="d-flex flex-column px-1 my-2 py-2 " cols="12" sm="6" >
      <v-row>
        <v-col class="colcontainer ">
          <div class="urlsite play d-flex align-end justify-end pb-8 pr-8" :style="{ transform: 'rotate(' + -3 + 'deg)' }">{{item.pic.match(/^(?:https?:\/\/)?(?:[^@\/\n]+@)?(?:www\.)?([^:\/\n]+)/im)[1]}}
          </div>
          <div 
            class="align-top float-left mr-1 px-3 py-md-1 mx-md-1 ">

            <div 
              alt="{backgroundImage: 'url('+ item.pic} {backgroundImage: apiUrl == 'https://farmspot.ru' ? 'url(' + item.pic + ')' : '' }" 
              class ="pic px-0 align-center my-2" v-bind:style="{backgroundImage: apiUrl == 'https://farmspot.ru' ? 'url(' + item.pic + ')' : '' }" >
            </div>
          </div >
          <div class="px-2 pt-2 pb-2 colr">
            <h3>{{ item.head }}</h3>
          </div>
          <div class="px-2 text-body-1">
            {{item.desc}}… 
          </div>
          <v-card-subtitle
          class="px-2 py-0 float-left date play">
 
                {{new Date(item.created_at).toLocaleDateString()}}
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
 
          <v-tooltip location="start" >
            <template v-slot:activator="{ props }">
              <div  class="overbut px-2 py-0 mx-2"  v-bind="props" v-if="isButtonDisabled" :style="{cursor: 'not-allowed'}"> 
                  </div>
                <v-btn 

                color="primary"
                  class="px-2 py-0 mx-2 but"
                  v-bind="props"
                  @click="handleClick(item.id, item.head)"
                  :disabled="isButtonDisabled" 
                  size="small">
                  открыть
                  </v-btn>                    
            
            </template>
            <span class=" d-flex align-center"  v-if="!isButtonDisabled">
              <div class="mr-1">потратить: 5</div>
              <div class="skull">
              </div>
            </span>
            <span class=" "  v-if="isButtonDisabled">
              недостаточно очков действия
            </span>
          </v-tooltip>

        </v-col>
      </v-row>
    </v-col>
     </v-row>

    <v-dialog
      v-model="showModal"
      max-width="1080px"
      width="95%">
      <v-card 
      class="px-md-5 py-md-2">
      <v-card-title class="pb-md-4">
          <h5>{{ tithead }}</h5>
        </v-card-title>
        <v-card-text >
          <span class="text-body-1" v-html="fullarticle"></span> 
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn
            color="green darken-1 "
            text
            @click="showModal = false">
            Закрыть
            </v-btn>
          </v-card-actions>
      </v-card>
    </v-dialog>  


 
</template>
<script setup lang="ts">
  const apiUrl = window.APP_CONFIG.apiUrl;
  const skull = new URL("../images/skull.png", import.meta.url).href;
  import { ref, reactive, inject, onMounted, watch, computed  } from 'vue'
  const plain: any = inject('plain')
  const secured: any = inject('secured')
  const axios: any = inject('axios')
  import { useLogStore } from '../../store.js'
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
    console.log(bottom.value) 
     getList()
     console.log("getlist")
  })

  const getList = (val): void => {
    plain
      .get("/news", { params: { pos: pos.value } })
      .then((response: { data: any }) => {
        console.log(response.data)
        // alld.value = response.data
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

//article full modal view mech
 
  const showModal = ref(false)
  const fullarticle = ref()
  const tithead = ref()

  function handleClick(val, head){
    store.decrements(5)
    console.log(val)
    showModal.value = true
    plain
      .post("/fullnews", {  id: val  })
      .then((response: { data: any }) => {
      // console.log(response.data.fullarticle)
      fullarticle.value = response.data.fullarticle
      tithead.value = head
      // console.log( Object.keys(alld.value).length)
    });    
  }  
</script>

<style scoped>
.urlsite{
  /*background-color: #dad;*/
  z-index: -1;
  color: #222;
  overflow: hidden;
  position: absolute;
  font-size:  28px;
  height: 100%;
  width: 100%;
}

.colcontainer{
  position: relative;
  overflow: hidden;
}
.overbut{
  /*background-color: #dad;*/
    bottom: 1.5em;
  right: 1.5em;
  height: 2em; 
  width: 6em;
  position: absolute;
  z-index: 1000;
}
.skull{
  opacity: 0.6;
  height: 1.1em;
  width: 1.1em;
  background-image: url('../images/skull.png');
  /*image-rendering: pixelated;*/
  background-size: 100%;
 
}
.pic {
  /*background-color: #dad;*/
  width: 100px;
  height: 100px;
}
.colr{
  /*color: #60845b;*/
  /*color: #657d62;*/
  color: #96ab94;
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