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
                <div  v-bind="props" class="ore "  v-bind:style="{backgroundImage: 'url(/images/'+item.item+'.png'}">
                </div>
              </div>
              <div class="energy"></div>
            </template>
            <span>
              <span style="color:#ffe79f;" >
                <!-- {{item.title}} -->
                {{item.title}}
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
const store = useLogStore()
const axios: any = inject('axios')
const signedIn = ref(false)
	const drop = ref()
  onMounted(() => {
 		
  })	
	watch(() => store.tpumpkdead, (val) => {
      if (val == true){
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
//   watch:{
//     drop: function (){
//       console.log("drop incoming")
//     },
//     pumpkdead: function (val){
//       console.log("DROPval")
//       if (val == true){
//         this.getdrop()
//         console.log('val')
//         console.log(val)
//         console.log('val')
//       }else{
//         var m8 = gsap.timeline();
//         m8.to(".ore",{
//           opacity: 0,
//         })
//         .to(".ore",{
//           y: 25,
//           display: "none",
//         })
//       }
//     }
//   },
//   computed: {   
//     ...mapState(useLogStore, {
//       pumpkdead: "thispumpkdead",
//     }), 
//     ...mapState(useLogStore, {
//       signedIn: "thissignedIn",
//     }),      
//   },
//   created () {
//     console.log("drop")
//   },
//   updated () {
    
//   },
  function getdrop(){
 			 axios.get('/my_items/getdrop')
       // this.$http.plain.get('/my_items/getdrop')
      .then(response => { 
        console.log(response.data)
        drop.value = response.data
        nextTick(() => {
				  dropanim()
        })
      })
      .catch(error => { this.setError(error, 'Something went wrong') })
     
  }
//   methods: {
//     ...mapActions(useLogStore, ["upinv"]),
  function dropanim(){
  	nextTick(() => {
      var m4 = gsap.timeline();
      m4.to(".energy",{
        stagger: {
          each: 1.5,
          onComplete: bgnull,
        },
        background: 'url(/images/energyonce.gif?a='+Math.random()+')',
        duration: 1.5,
        delay: 2.5, 
        opacity: 1,
        visibility: "visible",
      })
      function bgnull(){
        console.log(" pumpkdead")
        var m9 = gsap.timeline();
        m9.to(".energy",{
        background: 'none',
        })
      }
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
        onComplete: oreswing
      })
      function oreswing(){
        var self = this
        if (store.tpumpkdead == true){
          var m8 = gsap.timeline({repeat: -1});
          m8.to(".ore",{
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
    })
     
  }
//     dropanim(){
//       this.$nextTick(function () {
//         var m4 = gsap.timeline();
//         m4.to(".energy",{
//           stagger: {
//             each: 1.5,
//             onComplete: bgnull,
//           },
//           background: 'url(/images/energyonce.gif?a='+Math.random()+')',
//           duration: 1.5,
//           delay: 2.5, 
//           opacity: 1,
//           visibility: "visible",
//         })
//         function bgnull(){
//           console.log(" pumpkdead")
//           var m9 = gsap.timeline();
//           m9.to(".energy",{
//           background: 'none',
//           })
//         }
//         gsap.set(".ore", {
//           y: 25,
//           opacity: 0,
//           display: "none",
//         });
//         var m3 = gsap.timeline();
//         m3.to(".ore",{
//           stagger: 1.2,
//           delay: 2.6,
//           y: 0,
//           opacity: 1,
//           display: "block",
//           visibility: "visible",
//           duration: 1,
//           ease: "power4.out",
//           onComplete: oreswing
//         })
//         function oreswing(){
//           var self = this
//           if (self.pumpkdead == true){
//             var m8 = gsap.timeline({repeat: -1});
//             m8.to(".ore",{
//               ease: "expo.in",
//               y: -3,
//               duration: 3,
//               ease: "elastic.in",
//             })
//             .to(".ore",{
//               ease: "elastic.out", 
//               y: 0,
//               duration: 3,
//             })   
//           }
//         }
//       })
//     },    
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
    visibility: hidden;
    opacity: 0;
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