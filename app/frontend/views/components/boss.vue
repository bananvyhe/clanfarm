<template>
  <div class="info"> 
    <!-- {{props.width}}  -->
    <!-- <br>{{bossdirection}} -->
  </div>
 
  <div class="d-flex flex-column align-self-end"> 
    <div class="hpbar pb-15">
      <v-progress-linear :model-value="hp" color="success"></v-progress-linear>
    </div> 
    <div  class="boss " :style="[  !ready ?  {cursor: 'not-allowed'}:{} ]"  v-on:click="handler()" >
    </div>
  </div>

</template>

<script setup lang="ts">
const hp = ref(60)
function handler(){
  if (ready.value == true ) {
    start()
  }
  console.log(ready.value)
}


const props = defineProps(['width'])
import { gsap } from "gsap";
const idle = new URL("../images/sprites/monsters/summoner/idle.png", import.meta.url).href;
const move = new URL("../images/sprites/monsters/summoner/move.png", import.meta.url).href;
const hit = new URL("../images/sprites/monsters/summoner/hit.png", import.meta.url).href;
const death = new URL("../images/sprites/monsters/summoner/death.png", import.meta.url).href;
const summon = new URL("../images/sprites/monsters/summoner/summon.png", import.meta.url).href;
import { ref, computed, inject, nextTick, watch } from 'vue';
import { promiseTimeout, useTimeout} from '@vueuse/core'
const { ready, start } = useTimeout(1000, { controls: true })
// const el = ref(null)
// const { x, y, top, right, bottom, left, width, height } = useElementBounding(el)
const repDelay = ref()
const plain: any = inject('plain')
const secured: any = inject('secured')
const bossdirection = ref(2.4)
onMounted(() => {
  nextTick(() => {
    function randpos() {
      const res = Math.floor(Math.random() * (props.width - 110) ); // start position on page load
      return res
    }
    function bossstay() {
      gsap.set(".boss", {
        // scale: 2.4,
        transformOrigin: "bottom 65%",
        backgroundImage: 'url('+move+')',
        // x: randpos(), 
        // backgroundPosition: "0px",      
         scaleX: bossdirection.value
        // backgroundPosition: "0px",
      });   
   
    } 
      var b1 = gsap.timeline();  
      b1.to(".boss",{
        duration: 1,
        repeat:-1,    
        ease: "steps(5)",
        backgroundPosition: "-230px",
        // scaleX: bossdirection.value
      })
    function bossmove(val) {
      // var b2 = gsap.timeline({ repeat: -1, onRepeat: updateRandomX  });  
      // function updateRandomX() {
        // console.log(val)
        function calcmove () {
          return Math.floor(Math.random() * (props.width - 110) );
        }    
        var moveResult = calcmove(); 
        function dur () {
          var res = (moveResult - val)/80
          return Math.abs(res)+2 
        }  
        function bosdir () {
          if (moveResult > val){
           return bossdirection.value = 2.4
          }else{
            return bossdirection.value = -2.4
          }
 
        }       
        bosdir();
        // console.log(bosdir ()) 

        // console.log( dur ())

        gsap.to([".hpbar",".boss"],{
          ease: "sine.inOut",
          // repeat:-1, 
          duration: dur,
          x: moveResult,
          onComplete: function () {
            gsap.delayedCall(2, function () {
              bossmove(moveResult); // Pass moveResult as an argument to bossmove()
            });
          },
        })
      // }
    }
watch(bossdirection, () => {
  bossstay();
}); 
    bossstay();
    bossmove();
    // var master = gsap.timeline();
    // master.add(bossstay()).add(bossmove()) 
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
/*.pers{
  position: relative;
}*/
.hpbar{
  width: 60px;
}
.info{
  position: absolute;
  right: 0;
}
.boss {
  /*z-index: 2;*/
  scale: 2.4;
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
