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
            <template v-slot:activator="{ props}" :name="''+item.id" class="d-flex justify-end">
              <div 
              :style="[ store.tsignedIn == true ?  {cursor: 'pointer'}:{cursor: 'not-allowed'} ]" 
              v-on:click="pickdrop(item.id)">
                <div  v-bind="props" class="ore"  v-bind:style="{backgroundImage: 'url(/images/'+item.item+'.png'}">
                </div>
              </div>
              <div class="energy"></div>
            </template>
            <span>
              <h4 >{{item.title}}</h4>
              <span >
                <div class="text-caption shad">{{item.desc}}</div>
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
import { ref, onMounted, watch, nextTick, inject } from 'vue';
const plain: any = inject('plain')
const secured: any = inject('secured') 
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
        drop.value = 0
      }
  })

  // watch(() => drop.value, (val) => {

  // })

  function getdrop(){
 			plain
      .get('/my_items/getdrop')
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

function newdropanim(){
  if (tl) {
    tl.kill(); 
  }
  if (tle) {
    tle.kill(); 
  }  
  var tl = gsap.timeline();
  var tle = gsap.timeline();
  if (props.makeDrop == true){
    
    const elements = document.querySelectorAll('.ore');
    tl.staggerFromTo([...elements].reverse(), 1, {opacity: 0, y: 50}, {opacity: 1, y: 0}, 0.5)
     .eventCallback("onComplete", oreswing)
    tl.play()

    gsap.set(".energy", {
       background: 'url(/images/energyonce.gif?a='+Math.random()+')',
    });  
    
    const elementse = document.querySelectorAll('.energy');
    tle.staggerFromTo([...elementse].reverse(), 1, {opacity: 0 }, {opacity: 1 }, 0.5);
    tle.play()
  }else{
    tl.kill();
    tle.kill();
  }
}

function oreswing(){
  console.log('oreswing')

  const elements = gsap.utils.toArray('.ore'); // select all elements with class "ore"
  const duration = 1.5; // set the duration of each shake animation
  const delay = 0.2; // set the delay between each element animation

  gsap.to(elements, {
    y: "+=2", // move elements 2px down
    duration: duration, // set the duration of the animation
    ease: "power1.inOut", // set the easing function
    yoyo: true, // animate back to original position after completing the animation
    repeat: -1, // repeat the animation continuously
    stagger: {
      each: delay, // set the delay between each element animation
      from: "random", // set the starting position of the staggered delay to a random element
    },
  });
}

function pickdrop(val){
  console.log("pickdrop")
  console.log(val)
  if (store.tsignedIn == true){
    secured
    .post('/my_items/pickdrop',{id: val})
    .then(response => { 
      // console.log(response.data)

      store.upinv(response.data)
      const newArray = drop.value.filter(item => item.id !== val);
      drop.value = newArray;
      // drop.value.map(item => {
      //   console.log(item)
      //   if (item.listid === val) {
      //     return {...item, qty: item.qty++};
      //   }
      //   return item;
      // });

    })
    .catch(error => { this.setError(error, 'Something went wrong') })   
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