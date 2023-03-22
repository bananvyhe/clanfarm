<template>
 <div class="dropzone d-flex "> 
  <!-- {{drop}} -->
  <!-- {{pumpkdead}} -->
      <div class="d-flex drop ">
        <!-- {{drop}} -->
<!-- {{pumpkdead}} -->
        <div v-for="(item, index) in drop" :key = "item.id" >
            <!-- {{item.id}} -->

          <v-tooltip top >
            <template   v-slot:activator="{ props}" :name="''+item.id" class="d-flex justify-end">

              <div 
              :style="[ signedIn == true ?  {cursor: 'pointer'}:{cursor: 'not-allowed'} ]" 
              v-on:click="pickdrop(item.id)" >
                <div  v-bind="props" class="ore"  v-bind:style="{backgroundImage: 'url(/images/'+item.item+'.png'}">
                </div>
              </div>
              <div class="energy"></div>
            </template>
            <span>
              <span style="color:#286020;" class="font-weight-bold" >
                <b  >{{item.title}}</b> 
                <!-- <b  ></b> -->
              </span> 
              <br>
              <span >
                <!-- {{item.desc}} -->
                {{item.desc}}
              </span>
            </span>
          </v-tooltip> 

      </div>

    </div>
 </div>
</template>

<script setup lang="ts">
// const rock = new URL("../images/sprites/monsters/ore.png", import.meta.url).href;
import { gsap } from "gsap";
import { ref, onMounted, watch, nextTick } from 'vue';
import { useLogStore } from '../../store.js'
const props = defineProps(['makeDrop'])

const store = useLogStore()
const axios: any = inject('axios')
const signedIn = ref(false)
	const drop = ref()
  onMounted(() => {
 		
  })	
	watch(() => props.makeDrop, (val) => {

      if (val == true ){
        getdrop()
      }else{
        var m8 = gsap.timeline();
        m8.to(".ore",{
          opacity: 0,
        })
        .to(".ore",{
          y: 25,
          display: "none",
        })
      }
  })

  watch(() => drop.value, (val) => {

  })

  function getdrop(){
 			 axios.get('/my_items/getdrop')
       // this.$http.plain.get('/my_items/getdrop')
      .then(response => { 
        console.log(response.data)
        drop.value = response.data
        nextTick(() => {
				  // dropanim()
          newdropanim()
        })
      })
      .catch(error => { this.setError(error, 'Something went wrong') })
     
  }
//   methods: {
//     ...mapActions(useLogStore, ["upinv"]),


function newdropanim(){
  var tl = gsap.timeline();
  const elements = document.querySelectorAll('.ore');
  tl.staggerFromTo([...elements].reverse(), 1, {opacity: 0, y: 50}, {opacity: 1, y: 0}, 0.5);
  tl.play()

  gsap.set(".energy", {
     background: 'url(/images/energyonce.gif?a='+Math.random()+')',
  });  
  var tle = gsap.timeline();
  const elementse = document.querySelectorAll('.energy');
  tle.staggerFromTo([...elementse].reverse(), 1, {opacity: 0 }, {opacity: 1 }, 0.5);
  tle.play()

}






  function dropanim(){ 
      gsap.set(".energy", {
          // opacity: 0,
          // display: "none",
        });  	
      var m4 = gsap.timeline();
    
      m4.to(".energy",{
        // stagger: {
        //   each: 1.5,
        //   onComplete: bgnull(),
        // },

        background: 'url(/images/energyonce.gif?a='+Math.random()+')',
        duration: 1.5,
        delay: 2.5, 
        opacity: 1,
        display: "block",
        visibility: "visible",
          stagger: function(index, target, list) {

              console.log(index )
              bgnull(index)
 
          }    
      })




      function bgnull(val){
        
        var mqueue = "m"+ val
        console.log(" pumpkdead" + mqueue)
        var m9 = gsap.timeline();
        m9.to(".energy",{
          // background: 'none',
        })
        gsap.set(".ore", {
          y: 25,
          opacity: 0,
          display: "none",
        });
        var m3 = gsap.timeline();
        m3.to(".ore",{
          stagger: 1.2,
          delay: 2.6,
          y: 0,
          opacity: 1,
          display: "block",
          visibility: "visible",
          duration: 1,
          ease: "power4.out",
          // onComplete: oreswing
        })        
      }

      function oreswing(){
        if (store.tpumpkdead == true){

          var m8 = gsap.timeline({repeat: -1});
          m8.to(".ore",{
            stagger: 0.6,
            y: -3,
            duration: 3,
            ease: "elastic.in",
          })
          .to(".ore",{
            ease: "elastic.out", 
            y: 0,
            duration: 3,
          })   
        }
      }
    
     
  }

//     pickdrop(val){
//       console.log("pickdrop")
//       if (this.signedIn == true){
//          this.$http.secured.post('/my_items/pickdrop',{id: val})
//         .then(response => { 
//           console.log(response.data)
 
//           this.upinv(val)
 
//         })
//         .catch(error => { this.setError(error, 'Something went wrong') })   
//       }   
//     },
  
//   }
// }
</script>

<style lang="css">
.dropzone{
 
  position: absolute;
 
}
 
.drop{
 
  position: relative;
}
.energy{
 
    margin-left: -57px;
    /*visibility: hidden;*/
    /*opacity: 0;*/
  top:-16px;
 

  position: absolute;
  /*position: relative;*/
  width: 150px;
  height: 70px;
  /*background: url(../../../javascript/images/energy27.gif);*/
}
/*.ore{
  display: none;
  z-index: 1;
  position: absolute;
  background-color: #dad;
  opacity: 0;
  bottom: 0px;
  width: 38px;
  height: 38px;
  background: url(../../../javascript/images/ore.png);
  cursor: pointer;
}*/
.ore{

  /*display: none;*/
  /*visibility: hidden;*/
  /*opacity: 0;*/
  z-index: 1;
  /*position: absolute;*/
  position: relative;
  /*bottom: 0px;*/
  width: 38px;
  height: 38px;
  /*background: url(../../../javascript/images/goldenore.png);*/
  /*cursor: pointer;*/
}
</style>