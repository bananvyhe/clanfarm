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
          class="inventory d-flex "
          color="indigo"
          dark
          v-bind="props"
           >
        </div>
        <div class="px-2">
 
        </div>
      </template>
      <v-card
        elevation="2"
        min-height="200"
        min-width="300">
        <div v-if="thisinv == 0" ><h4>пустой инвентарь</h4></div>
        <draggable 
 
          class="inv"
          :list="Array.from(thisinv)"
          @change="itemMoved">
<!--           <div v-for="(item, index) in thisinv" class="one-item" v-on:click="oneClick(item.item_name, item.listid)" :key="item.id">
            <v-tooltip  top>
               <template v-slot:activator="{ on, attrs}">
                <div v-on="on" v-bind="attrs" class="item-inv px-1 py-0 d-flex justify-end align-end" v-bind:style="{backgroundImage: 'url(/images/'+item.item+'.png'}">
                {{item.qty}}              
                </div>
              </template>
                <span>
                  <span style="color:#ffe79f;">{{item.title}}</span> 
                  <br><span class="caption">{{item.desc}}</span></span>
 
            </v-tooltip>
          </div>  -->         
        </draggable>


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
import { ref, computed, inject } from 'vue';
import { useLogStore } from '../../store.js' 
  const store = useLogStore()
  const plain: any = inject('plain')
  const secured: any = inject('secured')

  const menu = ref(false)
 
    const thisinv = computed(() => store.tinventory)
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
  //   menuget(){
  //     console.log("menuget")
  //     this.$http.secured.get('/my_items/menuget')
  //     .then(response => { 
 
  //       this.setinv(response.data)
  //       this.items = this.thisinv
  //     })
  //     .catch(error => { this.setError(error, 'Something went wrong') })            
  //   },   
  //   oneClick: function(event, id) {
  //     this.clicks++
  //       if (this.clicks === 1) {
  //         var self = this
  //         this.timer = setTimeout(function() {
  //           self.result.push(event.type);
  //           self.clicks = 0
  //         }, this.delay);
  //       } else {
 
  //         clearTimeout(this.timer);
  //         this.result.push('dblclick');
  //         this.clicks = 0;
  //         this.itemUse(event, id)
  //       }
  //   },  
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
  //   itemMoved: function(event) {
  //     console.log(event)
  //     const evt = event.added || event.moved
  //     if (evt == undefined) {return}
  //     const element = evt.element
 

  //     var data = new FormData
        
 
  //     data.append("my_item[position]", event.moved.newIndex  + 1)
  //     data.append("my_item[my_item_id]", event.moved.element.id  )
  //     console.log(data.my_item)
  //       this.$http.secured.patch(`/my_items/${element.id}/move`, data)
  //         .then(response => { 
    
  //       this.menuget()
  //       })
  //       .catch(error => { this.setError(error, 'Something went wrong') })
      
  //   },
 
        
  // }
// }
</script>
<style scoped>
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
  display: flex;
  flex-direction: row;
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
  h5{
    padding-left: 0.5em;
  }
  p{
    text-align: center;
  }
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