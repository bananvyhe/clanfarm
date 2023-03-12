<template>
  <div class="main mx-0 my-0">
    <!-- <drop class="drops"></drop> -->{{store.tloa}}{{  loc  }}{{store.tpumpkdead}}
<!-- :class="loc  ? 'unit' : 'off'  " -->
    <div class="unit" v-on:click="handler()" > 
      <div class="hpoints d-flex justify-center subtitle-2">{{hpoints}}</div> 
      <!-- <damagecomp ref="hitt"></damagecomp> -->
      <div class="hpbar">
        <v-progress-linear :model-value="hp" color="success"></v-progress-linear>
      </div>
      <div class="character" :style="[  !ready ?  {cursor: 'not-allowed'}:{} ]"></div>
      <!-- :class="loc  ? 'character' : 'death'" -->
    </div>

	</div>
</template>
<script setup lang="ts">
  import { ref, reactive, onMounted, watch } from 'vue';
  import { useLogStore } from '../../store.js'
  import { promiseTimeout, useTimeout } from '@vueuse/core'
 
  const store = useLogStore()
  // import Drop from './packs/components/drop.vue'
  // import { mapState, mapActions } from 'pinia'  
	// import Damagecomp from './damagecomp.vue'
  
  import { gsap } from "gsap";
  import ls from 'localstorage-slim';
  import { damagecomp } from './damagecomp'
  // import  pubow  from '../images/sprites/monsters/pumpkinbow.png'
const pubow = new URL("../images/sprites/monsters/pumpkinbow.png", import.meta.url).href;
const pua = new URL("../images/sprites/monsters/pumpkina.png", import.meta.url).href;
  // const classObject = reactive({
  //   active: true,
  //   'text-danger': false    
  // })
  const hpoints = ref(124)
  const hp = ref(100)
  const dmg = ref()
  const loc = ref()
 

  const { ready, start } = useTimeout(1000, { controls: true })
    // <p>Ready: {{ ready.toString() }}</p>
    // <button :disabled="!ready" @click="start()">  
  const { hitcalc, damageData } = damagecomp()
  
  function handler(){
    if (ready.value == true) {
      hitpumpk()
      hitn()
      start()
    }
    console.log(ready.value)
  }
 
 
  function hitn(){
    var hitn = gsap.timeline();
    hitn.to(".character",{
       x: -4,
       duration: 0.2,  
       ease: "elastic.in",
    }).to(".character", {
      x: 0,
      duration: 0.2,  
      ease: "elastic.out", 
    })      
  }
 
  function hitpumpk(){
  //      // var interval = 15000000;
    // var interval = 26500;
    var interval = 7000;
    hitcalc()
    dmg.value =  damageData.hit 
    var hpleft = hpoints.value - dmg.value
    var percentcut = hpleft * 100 / hpoints.value
    hpoints.value = hpleft
    hp.value = percentcut

    if (hpoints.value <= 0){
      ls.set('hey', "death") 
      store.setPumpkDead()
      reset();
      var min = 2
      var max = 5
      var loa = Math.random() * (max - min) + min;
      loa =  Math.round(loa)
      loa = Number(loa)
      store.increments(loa)            
      }else{
        console.log("else hitpumpk ")
      }  
      function reset(){
         // занесение в локалсторадж даты окончания таймера
        var endt =  +new Date + interval
        ls.set('endTimer', endt)  
         // console.log("endt")
         // console.log(endt)
      }          
    }

    onMounted(() => {
    if (ls.get('hey') != "death"){
      loc.value = "alive"
      console.log("666")
    }
    if(ls.get('endTimer') == "death"){
       ls.set('hey', "alive") 
    } 
    if (ls.get('hey')){
       loc.value = ls.get('hey')
    }

    window.addEventListener('load', () => {
      // var self = this
      setInterval(function(){
        if( ls.get('hey') == "death" ){
          // занесение в переменную оставшиеся милисекунды до окончания(обратный отсчет)
          var getendt = ls.get('endTimer')
          var remaining = getendt - new Date;
          console.log(getendt)
        }
        // если отсчет не завершился то присваиваем статус "мертвый" в локалсорадж
        if( remaining >= 0 ){
          store.setPumpkDead 
          ls.set('hey', "death") 
          console.log("dead")
          console.log(remaining)
        }else if ( remaining < 0 ){
          console.log(remaining)
          console.log("remaining < 0 ")
          store.setPumpkAlive 
          var alive = gsap.timeline();
          alive.to(".unit",{
            delay: 2,
            // className: "+=unit",
          })
        // gsap.set(".character", {

        //   backgroundImage: 'url('+pua+ ')',
        // });          
          var m1 = gsap.timeline();
          m1.to(".character",{
            delay: 2,
            // className: "+=character",
            onComplete: ressurect
          })
          console.log("alive")
          ls.set('hey', "alive") 
        }
      }, 1000);   

      var self = this

      function ressurect() {  
        hp.value = 100
        hpoints.value = 124
        pumpk()
      }

      function pumpk() {
        gsap.set(".character", {
          scale: 1.5,
          backgroundImage: 'url('+pua+')',

        });

        var m1 = gsap.timeline();
        m1.to(".character",{
          duration: 1,
          repeat:-1,
          repeatDelay: 1,
           delay:1,

          backgroundPosition: "-528px",
          ease: "steps(11)",
          
 
          onRepeat: myFunction
        })

        function myFunction(){
 
          if (store.tpumpkdead){
             m1.kill()
             var m2 = gsap.timeline();
            m2.to(".character",{
              // className: "+=death",
 
                duration: 1,
                backgroundPosition: "-960px",
                ease: "steps(20)",              
                backgroundImage: 'url('+pubow+')',
                onComplete: end
            })

            // console.log("death")
            // m1.to(".character",{
            //   className: "+=death",
            //   onComplete: endFunc
            // })
            // function endFunc(){
            //   console.log("endFunc")
            //   m1.kill()

            //   var m2 = gsap.timeline();
            //   m2.to(".death",{
            //     duration: 1,
            //     backgroundPosition: "-960px",
            //     ease: "steps(20)",
            //     onComplete: end
            //   })
              function end(){
                var m2 = gsap.timeline();
                m2.to(".unit",{
                  // className: "+=off",
 
                })
              }
            // }
          } 
        }
      }
      var master = gsap.timeline();
      if (ls.get('hey') == "alive" || !ls.get('hey')){
        master.add(pumpk())
      }
    })
  })
 
</script>
<style scoped>
.drops{
  bottom: 0px;
  right: 0px;
}
.mob:hover{
  cursor: url("../images/sword.png"), pointer;
}
.main{
  position: relative;
}

.hpoints{

}
.off{
	/*opacity: 0;*/
}
.death{
  image-rendering: pixelated;
	/*background: url(../images/sprites/monsters/pumpkinbow.png);*/
  width: 48px;  height: 48px; 
}
.hpbar{
  margin: 0 7px ;
}
.unit{

  width: 48px;
}
.unit:hover{
}

.character {
  /*z-index: 2;*/
  position: relative;
  background-repeat: repeat-x;
  /*background: url(../images/sprites/monsters/pumpkina.png);*/
  image-rendering: pixelated;
  width: 48px;  height:48px; 
  cursor: url("../images/sword.png"), pointer;
}
.character:hover{
  cursor: url("../images/sword.png"), pointer;
}
</style>