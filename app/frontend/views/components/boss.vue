<template>
  <div class="info"> 
    <!-- {{props.width}}  -->
    <!-- <br>{{bossdirection}} -->
  </div>
 
  <div class="d-flex flex-column align-self-end mainframe" v-if="boss == true"> 
    <div class="hpbar pb-15">
      <v-progress-linear :model-value="hp" color="success" v-if="hp > 0"></v-progress-linear>
    </div> 
    <div  class="boss " :style="[  !ready ?  {cursor: 'not-allowed'}:{} ]" v-on:click="handler()" >
    </div>
    <div class="familiar mb-1" :style="[  !ghoul ?  {display: 'none'}:{} ]">
      
    </div>
  </div>

</template>

<script setup lang="ts">
const boss = ref(true)
const familiar = ref(true)
const ghoul = ref(true)
let b2 = ref(null)
const hp = ref(60)
function handler(){
  if (hp.value <= 0){
    bossdeath()
     
  }else{
    if (ready.value == true ) {
      if (familiar.value == true){
        ghoul.value = true
        bosssummon()
        famspawn() 
      }else{
        bosshit()
      }
      start()
    }    
  }

}
function famspawn() {
  gsap.set(".familiar", {
    scale: 2.4,
    transformOrigin: "bottom ",
    backgroundImage: 'url('+spawn+')',
    // x: randpos(), 
    backgroundPosition: "0px",      
    scaleX: bossdirection.value
  }); 
  b2 = gsap.timeline();  
  b2.to(".familiar",{
    duration: 1,
    // repeat:-1,    
    ease: "steps(10)",
    backgroundPosition: "-620px",
    // scaleX: bossdirection.value
    onComplete: ghouldeath
  })     
}
function ghoulwalk() {
  if (b2) {
    b2.kill(); 
  }   
  gsap.set(".familiar", {
    scale: 2.4,
    transformOrigin: "bottom ",
    backgroundImage: 'url('+walk+')',
    // x: randpos(), 
    backgroundPosition: "0px",      
    // scaleX: bossdirection.value
  }); 
  b2 = gsap.timeline();  
  b2.to(".familiar",{
    duration: 1.4,
    repeat:-1,    
    ease: "steps(8)",
    backgroundPosition: "-496px",
    // scaleX: bossdirection.value
  })     
}
function ghouldeath() {
  if (b2) {
    b2.kill(); 
  }   
  gsap.set(".familiar", {
    scale: 2.4,
    transformOrigin: "bottom ",
    backgroundImage: 'url('+ghouldead+')',
    // x: randpos(), 
    backgroundPosition: "0px",      
    // scaleX: bossdirection.value
  }); 
  b2 = gsap.timeline();  
  b2.to(".familiar",{
    duration: 1.4,
    repeat:-1,    
    ease: "steps(7)",
    backgroundPosition: "-434px",
    // scaleX: bossdirection.value
  })     
}
const props = defineProps(['width'])
import { gsap } from "gsap";
const spawn = new URL("../images/sprites/monsters/Ghoul/spawn.png", import.meta.url).href;
const walk = new URL("../images/sprites/monsters/Ghoul/Walk.png", import.meta.url).href;
const ghouldead = new URL("../images/sprites/monsters/Ghoul/death.png", import.meta.url).href;

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
let b1 = null;
nextTick(() => {
  function randpos() {
    const res = Math.floor(Math.random() * (props.width - 110) ); // start position on page load
    return res
  }
})


onMounted(() => {
  nextTick(() => {


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
function bossdeath() {
  if (b1) {
    b1.kill(); 
  }     
  gsap.set(".boss", {
    // scale: 2.4,
    transformOrigin: "bottom 65%",
    backgroundImage: 'url('+death+')',
    backgroundPosition: "0px",
    scaleX: bossdirection.value,
  });  
  b1 = gsap.timeline();  
  b1.to(".boss",{
    duration: 1.4,
    // repeat:-1,    
    ease: "steps(9)",
    backgroundPosition: "-414px",
    onComplete: bossdead
  })
} 
function bossdead() {
  b1.kill(); 
  boss.value = false
}
function bosssummon() {
  if (b1) {
    b1.kill(); 
  }    
  gsap.set(".boss", {
    // scale: 2.4,
    transformOrigin: "bottom 65%",
    backgroundImage: 'url('+summon+')',
    backgroundPosition: "0px",
    scaleX: bossdirection.value,
  });  
   b1 = gsap.timeline();  
  b1.to(".boss",{
    duration: 0.7,
    // repeat:-1,    
    ease: "steps(8)",
    backgroundPosition: "-368px",
    onComplete: bossstay
  })
} 

function bosshit() {
  if (b1) {
    b1.kill(); 
  }   
  gsap.set(".boss", {
    transformOrigin: "bottom 65%",
    backgroundImage: 'url('+hit+')',
    backgroundPosition: "0px",
    scaleX: bossdirection.value,
  });  
  b1 = gsap.timeline();  
  b1.to(".boss",{
    duration: 0.5,
    // repeat:1,    
    ease: "steps(3)",
    backgroundPosition: "-138px",
    onComplete: bossstay
  })
}

function bossstay() {
  if (b1) {
    b1.kill(); 
  }  
  gsap.set(".boss", {
    // scale: 2.4,
    transformOrigin: "bottom 65%",
    backgroundImage: 'url('+move+')',
    // x: randpos(), 
    backgroundPosition: "0px",      
    scaleX: bossdirection.value
  });   

   b1 = gsap.timeline();  
  b1.to(".boss",{
    duration: 1,
    repeat:-1,    
    ease: "steps(5)",
    backgroundPosition: "-230px",
    // scaleX: bossdirection.value
  })
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





</script>

<style scoped>
.mainframe{
  position: relative;
}
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
.familiar {
  /*background-color: #dad;*/
  position: absolute;
  bottom: 0;
  /*z-index: 2;*/
  scale: 2.4;
 
  background-repeat: repeat-x;
  /*background: url(../images/sprites/monsters/pumpkina.png);*/
  image-rendering: pixelated;
  width: 62px;  height:33px; 
/*  cursor: url("../images/sword.png"), pointer;*/
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
