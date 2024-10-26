<template>
  <div class="invent">
    <!-- {{items}} -->
     <v-menu
      v-model="menu"
      :close-on-content-click="false"
      :nudge-width="200"
      location="bottom">
      <template v-slot:activator="{ props }">
        <div
          class="inventory d-flex"
          color="indigo"
          dark
          v-bind="props"
           >
                       <div class="d-flex skulpos" >
            <div class="loa px-0 align-self-center" >{{store.tloa}}</div>
            <div class="skull align-self-center"></div>        
          </div>
        </div>

      </template>

      <v-card 
        elevation="2"
        min-height="200"
        min-width="300">
        <div v-if="store.tinventory == 0" class="d-flex justify-center"><h4>пустой инвентарь</h4></div>
        <draggable class=" d-flex " v-model="invarray" item-key="id" @change="itemMoved">{{element}}
          <template class="inv  align-self-stretch" #item="{element}">
            <div class="">
              <div v-on:click="oneClick(element.item, element.listid)"  class="item-inv px-1 py-0" v-bind:style="{backgroundImage: 'url(/images/'+element.item+'.png'}">

                <v-tooltip top>
                  <template  v-slot:activator="{ props}"  class=" ">
                    <div v-bind="props" class=" hovbut d-flex align-end justify-end tshad" >
                     {{element.qty}}
                    </div>

                  </template>
                  <span>
                    <div  class="setochka">
                      <h4>{{element.title}}</h4>
                      <div class="text-caption shad">{{element.desc}}</div>        
                    </div>
                  </span>                
                </v-tooltip>

              </div>
            </div>
          </template>
        </draggable>

        <!-- {{store.tinventory}} -->
<!--         <draggable 
 
          class="inv"
          :list="Array.from(store.tinventory)"
          @change="itemMoved"> -->

<!--           <div v-for="(item, index) in store.tinventory" 
            class="one-item" 
            v-on:click="oneClick(item.item_name, item.listid)" 
            :key="item.id">
            <v-tooltip  top>
               <template v-slot:activator="{props}">
                <div v-bind="props" class="item-inv px-1 py-0 d-flex justify-end align-end" v-bind:style="{backgroundImage: 'url(/images/'+item.item+'.png'}">
                {{item.qty}}              
                </div>
              </template>
                <span>
                  <h4>{{item.title}}</h4> 
                  <span class="caption">{{item.desc}}</span></span>
 
            </v-tooltip>
          </div>    -->       
        <!-- </draggable> -->


      </v-card>

    </v-menu>
  <!-- <div style="width: 500px; font-size: 0.8em"> -->
    <!-- {{thisinv}} -->
    <!-- <br> -->
    <!-- {{items}} -->
  <!-- </div> -->

  </div>
</template>
<script setup lang="ts">
const retryCount = ref(3);
const retryDelay = ref(1000);

import { ref, computed, inject, onMounted } from 'vue';
import { useLogStore } from '../../store.js' 
const invarray = computed({
  get(){
    return store.tinventory
  },
  set(val){
    store.setinv(val)
  }
  
})
  const store = useLogStore()
  const plain: any = inject('plain')
  const secured: any = inject('secured')
  const menu = ref(false) 
  import draggable from "vuedraggable"

  function itemMoved(event) {
    const evt = event.added || event.moved
    if (evt == undefined) {return}
    const element = evt.element
    console.log(event)
    var data = new FormData
      
    data.append("my_item[position]", event.moved.newIndex  + 1)
    data.append("my_item[my_item_id]", event.moved.element.id  )
    console.log(data.my_item)
      secured
      .patch(`/my_items/${element.id}/move`, data)
        .then(response => { 
  
      menuget()
      })
      .catch(error => console.log(error)) 
  }
  onMounted(() => {
    if (store.tsignedIn){
    console.log("menuget")
      menuget();
    }
  })
  async function menuget() {
    const apiUrl = '/my_items/menuget'; // Customize the API URL here
    try {
      const response = await secured.get(apiUrl)
      store.setinv(response.data)
      console.log(response.data)

    } catch (error) {
      await handleAxiosError(error, apiUrl, retryCount.value, retryDelay.value);
    }
  }
  async function handleAxiosError(error, url, retryCount, retryDelay) {
    if (retryCount > 0) {
      await new Promise(resolve => setTimeout(resolve, retryDelay));
      return menuget(url, retryCount - 1, retryDelay);
    } else {
      throw error;
    }
  }    
  // function menuget(){
    
  //   secured
  //   .get('/my_items/menuget')
  //   .then(response => { 

  //     store.setinv(response.data)
  //     console.log(response.data)
  //     // this.items = this.thisinv
  //   })
  //   .catch(error => console.log(error))            
  // }
  function oneClick(el, id) {
    console.log(el)
    console.log(id)
  }  
</script>
<style scoped>
 .skull{
  position: relative;
  z-index: 110;
  height: 20px;
  width: 20px;
  background-size: cover;
  background-image: url('../images/goldshtuken.png');
  image-rendering: pixelated;
 }
  .skulpos{
    z-index: 111;
    scale: 0.8;
    position: absolute;
    bottom: -5px;
/*      border: 1px solid color( $screenbg shade(56%));; */
  text-shadow: 0px 3px #222, 2px 0px #222;
  }
  .invent{
    height: 40px;
    width: 60px;
      background-image: url('../images/bag2.png');
  background-size: contain;
  background-position: center;
  }
.hovbut{
  height: 100%;

}
.item-inv {
  border: 1px solid color( $screenbg shade(56%));; 
  text-shadow: 0px 1px #222, 1px 0px #222;
  height: 44px; 
  width: 44px; 
  /*background: url(../../images/goldenore.png);*/
  /*background-color: #dad;*/
  /*display: flex;*/
  cursor: pointer;
   
  background-size: contain;
  padding: 0.3em 0 0 0.5em;

}
 .inventory{
  /*background-color: #ada;*/
  width: 50px;
  height: 40px;
  /*background-color: #dad;*/
  position: absolute;
  right: 0;

 }
.uiframe{
  padding-top: 0.25em;
}
.cash {
  display: flex;
}

.one-item {
  padding: 0.1em;
}
.inv {
  /*background-color: #dad;*/
  padding: 0.3em 0 0;
/*  display: flex;
  flex-direction: row;*/
}
.rock{
  display: flex;
  flex-direction: row;
  align-items: center;
}
/*.cry {
  border: 1px solid color( $screenbg shade(56%));; 
  text-shadow: 0px 1px #222, 1px 0px #222;
  height: 18px; 
  width: 18px; 
  background-image: url('../images/cry.jpg');
  background-size: contain;
  padding: 0.3em 0 0 0.5em;
  margin-right: 0.3em;
} */
.tooldrop{
  text-align: left;
  width: 15em;
  margin: -0.3em -0.1em;
  font-size: 0.9em;
/*  :is(h5){
    padding-left: 0.5em;
  }
  p{
    text-align: center;
  }*/
}
.slots{
  box-shadow: inset 0px 0px 8px rgba(0,0,0,0.3);
  padding: 0.5em 0.5em;
  /*background-color: #dad;*/
  margin: -0.8em -1em;
  display: flex;
  flex-direction: column;
}
</style>