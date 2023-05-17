<template>
  <div class="">
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
                    <div v-bind="props" class=" hovbut">
                     {{element.qty}}
                    </div>

                  </template>
                  <span>
                    <h4 > {{element.title}}</h4>
                    {{element.desc}}
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
// const invarray = computed(() => store.tinventory)
  const store = useLogStore()
  const plain: any = inject('plain')
  const secured: any = inject('secured')

  const menu = ref(false)
 
    // const thisinv = computed(() => store.tinventory)
// import { mapState, mapActions } from 'pinia' 
// import { useLogStore } from 'store.js'
// import axios from 'axios'  
import draggable from "vuedraggable"
// export default {
  // components: { draggable },
 
  
  // data() {
  //   return {
  //     fav: true,
  //     menu: false,
  //     message: false,
  //     hints: true,
  //     dis: false,
  //     responseClan: false,
  //     dialogBuildClan: false,   
  //     result: [],
  //     delay: 500,
  //     clicks: 0,
  //     timer: null,  
  //     items: [],
  //     isOpen: false,
  //   }
  // },
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
        .catch(error => { this.setError(error, 'Something went wrong') })
      
    }
  // watch: {
  
  //   isOpen(){
  //     if (this.isOpen == true) {
 
  //     }
  //   }
  // },
  // computed: {   
  //   ...mapState(useLogStore, {
  //     thisinv: "thisinv",
  //   }),      
  //   ...mapState(useLogStore, {
  //     loareg: "thisloareg",
  //   }),    
  // },
  // created() {
  //   this.getloareg()
  //   this.menuget()
  // },
  // methods: {
  //   ...mapActions(useLogStore, ["setinv"]),
  //   ...mapActions(useLogStore, ["setLoareg"]),     
  //   getloareg(){
  //      this.$http.secured.get('/my_items')
  //     .then(response => { 
  //       console.log(response.data)
 
  //       this.setLoareg(response.data)
  //     })
  //     .catch(error => { this.setError(error, 'Something went wrong') })
  //   }, 
  onMounted(() => {
    console.log("menuget")
    menuget()
  })
  function menuget(){
    
    secured
    .get('/my_items/menuget')
    .then(response => { 

      store.setinv(response.data)
      console.log(response.data)
      // this.items = this.thisinv
    })
    .catch(error => { this.setError(error, 'Something went wrong') })            
  }
  function oneClick(el, id) {
    console.log(el)
    console.log(id)
      // this.clicks++
      //   if (this.clicks === 1) {
      //     var self = this
      //     this.timer = setTimeout(function() {
      //       self.result.push(event.type);
      //       self.clicks = 0
      //     }, this.delay);
      //   } else {
 
      //     clearTimeout(this.timer);
      //     this.result.push('dblclick');
      //     this.clicks = 0;
      //     this.itemUse(event, id)
      //   }
    }  
  //   itemUse(name, id){
 
  //     if (name == 'Права лидера'){
  //       this.dialogBuildClan = true;
 
  //     }
  //     axios({
  //       method: 'post',
  //       url: `/my_items/${id}/use_item`,
  //       data: {
  //         name: name
  //       },
  //       headers: {
  //         'Authorization': 'bearer '+this.token.access
  //       } 
  //     }).then((response) => { 
         
  //     })
  //   },

 
        
  // }
// }
</script>
<style scoped>
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