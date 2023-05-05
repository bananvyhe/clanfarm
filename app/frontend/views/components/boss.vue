<template>
  <div class="d-flex flex-grow-1 flex-shrink-0">


  <div class="boss d-flex align-self-end mb-2" :style="[  !ready ?  {cursor: 'not-allowed'}:{} ]"></div>
  </div>
</template>

<script setup lang="ts">
import { gsap } from "gsap";
const idle = new URL("../images/sprites/monsters/summoner/idle.png", import.meta.url).href;
const move = new URL("../images/sprites/monsters/summoner/move.png", import.meta.url).href;
const hit = new URL("../images/sprites/monsters/summoner/hit.png", import.meta.url).href;
const death = new URL("../images/sprites/monsters/summoner/death.png", import.meta.url).href;
const summon = new URL("../images/sprites/monsters/summoner/summon.png", import.meta.url).href;
import { ref, computed, inject } from 'vue';
import { promiseTimeout, useTimeout } from '@vueuse/core'
const { ready, start } = useTimeout(1000, { controls: true })
const plain: any = inject('plain')
const secured: any = inject('secured')

onMounted(() => {
  nextTick(() => {
    var master = gsap.timeline();
    master.add(bossmove())
  })
})

function bossidle() {
  gsap.set(".boss", {
    scale: 2.4,
    transformOrigin: "bottom",
    backgroundImage: 'url('+idle+')',
    backgroundPosition: "0px",
  });  
  var b1 = gsap.timeline();  
  b1.to(".boss",{
    duration: 1,
    repeat:-1,    
    ease: "steps(5)",
    backgroundPosition: "-230px",
  })
} 

function bossmove() {
  gsap.set(".boss", {
    scale: 2.4,
    transformOrigin: "bottom",
    backgroundImage: 'url('+move+')',
    backgroundPosition: "0px",
  });  
  var b1 = gsap.timeline();  
  b1.to(".boss",{
    duration: 1,
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
