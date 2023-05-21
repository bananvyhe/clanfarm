<template>
  <div class="info"> 
    {{props.width}} 
 
  </div>
  <div class="d-flex flex-grow-1 flex-shrink-0 mx-4 pl-9"> 
      <div ref="el" class="boss d-flex align-self-end mb-2" :style="[  !ready ?  {cursor: 'not-allowed'}:{} ]">
        
      </div>
  </div>
</template>

<script setup lang="ts">
const props = defineProps(['width'])
import { gsap } from "gsap";
const idle = new URL("../images/sprites/monsters/summoner/idle.png", import.meta.url).href;
const move = new URL("../images/sprites/monsters/summoner/move.png", import.meta.url).href;
const hit = new URL("../images/sprites/monsters/summoner/hit.png", import.meta.url).href;
const death = new URL("../images/sprites/monsters/summoner/death.png", import.meta.url).href;
const summon = new URL("../images/sprites/monsters/summoner/summon.png", import.meta.url).href;
import { ref, computed, inject, nextTick } from 'vue';
import { promiseTimeout, useTimeout} from '@vueuse/core'
const { ready, start } = useTimeout(1000, { controls: true })
// const el = ref(null)
// const { x, y, top, right, bottom, left, width, height } = useElementBounding(el)
const repDelay = ref()
const plain: any = inject('plain')
const secured: any = inject('secured')
 
onMounted(() => {
  nextTick(() => {

    const startpos =  Math.floor(Math.random() * (props.width - 110) ); // start position on page load
    const direction = Math.random() < 0.5 ? -1 : 1 ; // Randomly choose left or right direction

    gsap.set(".boss", {
      scale: 2.4,
      transformOrigin: "bottom",
      backgroundImage: 'url('+move+')',
      x: startpos,
      backgroundPosition: "0px",      
      // backgroundPosition: "0px",
    });   
    function bossmove() {

      var b1 = gsap.timeline();  
      b1.to(".boss",{
        duration: 1,
        repeat:-1,    
        ease: "steps(5)",
        backgroundPosition: "-230px",
      })
    } 

  // if (direction == -1){


  // }else{

  // }

    var master = gsap.timeline();
    master.add(bossmove())
 
  })
})

function walk() {

}
function bossidle() {
  gsap.set(".boss", {
    scale: 2.4,
    transformOrigin: "bottom",
    backgroundImage: 'url('+idle+')',
    backgroundPosition: "0px",
  });  
  var b1 = gsap.timeline();  
  b1.to(".boss",{
    duration: 2,
    repeat:-1,    
    ease: "steps(5)",
    backgroundPosition: "-230px",
  })
} 

function bosshit() {
  gsap.set(".boss", {
    scale: 2.4,
    transformOrigin: "bottom",
    backgroundImage: 'url('+hit+')',
    backgroundPosition: "0px",
  });  
  var b1 = gsap.timeline();  
  b1.to(".boss",{
    duration: 0.5,
    repeat:-1,    
    ease: "steps(4)",
    backgroundPosition: "-184px",
  })
} 

function bossdeath() {
  gsap.set(".boss", {
    scale: 2.4,
    transformOrigin: "bottom",
    backgroundImage: 'url('+death+')',
    backgroundPosition: "0px",
  });  
  var b1 = gsap.timeline();  
  b1.to(".boss",{
    duration: 1.4,
    repeat:-1,    
    ease: "steps(11)",
    backgroundPosition: "-460px",
  })
} 
function bosssummon() {
  gsap.set(".boss", {
    scale: 2.4,
    transformOrigin: "bottom",
    backgroundImage: 'url('+summon+')',
    backgroundPosition: "0px",
  });  
  var b1 = gsap.timeline();  
  b1.to(".boss",{
    duration: 1.4,
    repeat:-1,    
    ease: "steps(9)",
    backgroundPosition: "-414px",
  })
} 
</script>

<style scoped>
.info{
  position: absolute;
  right: 0;
}
.boss {
  /*z-index: 2;*/
  position: relative;
  background-repeat: repeat-x;
  /*background: url(../images/sprites/monsters/pumpkina.png);*/
  image-rendering: pixelated;
  width: 46px;  height:44px; 
/*  cursor: url("../images/sword.png"), pointer;*/
} 
.boss:hover{
  cursor: url("../images/sword.png"), pointer;
}
</style>
