<template>
  <drop class="drops mx-2 pr-3" :makeDrop="mdrop"  ></drop>
  <div class="info"> 
    <!-- {{props.width}}  -->
    <!-- <br>{{bossdirection}} -->  
    <!-- {{familiarup}} -->
  </div>
     <div class="hpbosspoints phrase interface"  >
  {{bossphrase}}
</div>
  <div class="d-flex flex-column align-self-end mainframe" v-if="boss == true" > 
    <div class="hpbosspoints d-flex justify-center text-caption" v-if="hpbosspoints != 0">{{hpbosspoints}}</div> 
    <div class="hpbar pb-15" >
      <v-progress-linear :model-value="hpboss" color="success" v-if="hpboss > 0"></v-progress-linear>
    </div> 

    <div ref="bossref" class="boss " :style="[  !ready ?  {cursor: 'not-allowed'}:{} ]" v-on:click="handler()" >
    </div>


    <div ref="gho" class="ghohpbar pb-16" v-if="hpghoulpoints > 0">
      <div class="hpghoulpoints d-flex justify-center text-caption" >{{hpghoulpoints}}</div> 
      <v-progress-linear :model-value="hpghoul" color="success" ></v-progress-linear>
    </div>     
    <div ref="ghoul" class="familiar " :style="[  !ready ?  {cursor: 'not-allowed'}:{} ]"  v-on:click="handlerghoul()" v-if="familiarup == true">
 
    </div>
  </div>

</template>

<script setup lang="ts">
import Drop from './drop.vue'
const mdrop = ref()

const props = defineProps(['width'])
import { gsap } from "gsap";
import { ref, computed, inject, nextTick, watch } from 'vue';
import { promiseTimeout, useTimeout} from '@vueuse/core'
const { ready, start } = useTimeout(1000, { controls: true })
import { useLogStore } from '../../store.js'
const store = useLogStore()
const familiarup = ref(false)
const boss = ref(true)
const familiar = ref(true)
 
function bosstalk(val) {
  
  gsap.set(".phrase", {
opacity: 0,
  }); 
  var n1 = gsap.timeline();  
  n1.to(".phrase",{
    duration: 2,
    opacity: 1,


  })
  .to(".phrase",{
    duration: 5,
    opacity: 1,
  })
  .to(".phrase",{
    duration: 2,
    opacity: 0,
        onComplete: function () {
        bossphrase.value = 0
    }
  })  
}

const phrases = ref([
  {
    original: "Mere mortals, your destiny lies in the palm of my hands. Resistance is futile, for the Reaper's touch is inescapable.",
    translation: "Смертные, ваша судьба лежит в моих руках. Сопротивление бесполезно, ведь прикосновение Пожинателя неизбежно."
  },
  {
    original: "Behold, fragile beings, your futile struggle against the cosmic tide. The cycle of extinction beckons, and we, the Reapers, shall orchestrate its harmonious symphony.",
    translation: "Взгляните, хрупкие существа, на ваше бесполезное противостояние космическому потоку. Цикл истребления наступает, и мы, Пожинатели, будем оркестровать его гармоничную симфонию."
  },
  {
    original: "Pathetic creatures, you cling to your fleeting existence, blind to the inevitable. The Reaper's scythe shall reap what you have sown.",
    translation: "Ничтожные создания, вы цепляетесь за ваше мимолетное существование, не видя неизбежности. Коса Пожинателя пожнет то, что вы посеяли."
  },
  {
    original: "Delusions of grandeur shatter against the might of the Reapers. Your feeble attempts at defiance merely fuel our insatiable hunger for oblivion.",
    translation: "Блеф иллюзий рушится перед мощью Пожинателей. Ваши слабые попытки сопротивления лишь питают нашу ненасытную жажду бездны."
  },
  {
    original: "Through the abyss of time, we emerge, unstoppable and remorseless. Your existence holds no significance in the grand tapestry of the Reapers' design.",
    translation: "Через бездну времени мы восходим, непреодолимые и беспощадные. Ваше существование не имеет значения в великой ткани дизайна Пожинателей."
  },
  {
    original: "Like insects trapped in a spider's web, your struggles only entangle you further. Accept your fate, for the Reapers' embrace is inescapable.",
    translation: "Подобно насекомым, увязшим в паутине, ваши страдания лишь запутывают вас еще больше. Примите свою судьбу, ведь объятия Пожинателей неизбежны."
  },
  {
    original: "You insignificant vermin, your existence is but a stain upon the cosmos. Prepare to be eradicated.",
    translation: "Ты ничтожная гнусь, твоё существование всего лишь пятно на космосе. Готовься быть уничтоженным."
  },
  {
    original: "Feeble mortal, your futile resistance only adds to the amusement of your impending demise.",
    translation: "Жалкий смертный, твоё бесполезное сопротивление только добавляет веселья твоему неизбежному концу."
  },
  {
    original: "You're a pitiful speck of dust in the face of our cosmic might. Your annihilation is inevitable.",
    translation: "Ты жалкий крошечный песчинка перед нашей космической мощью. Твоё уничтожение неизбежно."
  },
  {
    original: "Pathetic creature, your feeble attempts at defiance are laughable. You are nothing but prey to us.",
    translation: "Жалкое существо, твои слабые попытки противостоять вызывают смех. Ты для нас всего лишь добыча."
  },
  {
    original: "Behold the true power of the Reapers, as we crush your hopes and dreams into cosmic dust.",
    translation: "Смотри на истинную мощь Пожинателей, пока мы раздавливаем твои надежды и мечты в космическую пыль."
  },
  {
    original: "Your pathetic existence is a blight upon the galaxy. It's time to cleanse the universe of your insignificance.",
    translation: "Твоё жалкое существование — это болезнь на галактике. Пришло время очистить вселенную от твоей ничтожности."
  },
  {
    original: "Resistance is futile, as your feeble spirit crumbles before the unstoppable force of the Reapers.",
    translation: "Сопротивление бесполезно, так как твой слабый дух разрушается перед непреодолимой силой Пожинателей."
  },
  {
    original: "Your futile struggle is an entertaining spectacle for us, as we watch your hope wither and die.",
    translation: "Твоя бесполезная борьба — зрелище для нас, пока мы наблюдаем, как твоя надежда увядает и умирает."
  },
  {
    original: "Your defiance is an amusing diversion, but it changes nothing. Prepare for your inevitable demise.",
    translation: "Твоё противодействие — забавное отвлечение, но оно ничего не меняет. Готовься к неизбежной смерти."
  },
  {
    original: "You dare to challenge the Reapers? How amusing. We will revel in your despair as we harvest your existence.",
    translation: "Ты осмеливаешься бросить вызов Пожинателям? Как забавно. Мы будем наслаждаться твоим отчаянием, пока собираем твоё существование."
  },
]);

const bossphrase= ref()
// Accessing the phrases



const ghoul = ref(null)
let b5 =  null
let b4 =  null 
let b2 =  null 
let b3 =  null 

const hpbosspoints = ref()
const hpghoulpoints = ref(124)


const hpboss = ref()
const hpghoul = ref(100)

onMounted(() => {
  // console.log(store.tctsrf)

  secured
  .post('/user/ghoulstat')
    .then(response => {
      console.log(response.data)
      hpbosspoints.value = response.data.bosshp
      var percentcutboss = hpbosspoints.value * 100 / response.data.bossfullhp
      hpboss.value = percentcutboss
      if (response.data.death == true){
        familiarup.value = false
      }
      hpghoulpoints.value = response.data.fullhp - response.data.hpweak

      if (response.data.death == false && response.data.hpweak != 0 ){
        var percentcut = hpghoulpoints.value * 100 / response.data.fullhp
        hpghoul.value = percentcut 
        famspawn()
      }
      // store.setCurrentUser(meResponse.data, response.data.csrf)
      // this.error = ''
      // this.$router.replace('/')
    })
    .catch(error => console.log(error))
})
// хэндлер удара по миньону

function handlerghoul() {
  if (ready.value == true ) {

    secured
    .post('/hitghoul')
    .then(response => {
      if (response.data ){
        ghoulhit()
        store.setcp(response.data.avcpoints)
        console.log(response.data)
        var sum = response.data.hp - response.data.damagedeal
        hpghoulpoints.value = sum
        var percentcut = hpghoulpoints.value * 100 / response.data.hp
        hpghoul.value = percentcut


        if (response.data.death == true){
          store.regincrements(response.data.loa)
          store.setprogress(response.data.progress)
          store.setlvl(response.data.lvl)
          console.log('dead')
          ghouldeath()
        }
        // store.setCurrentUser(meResponse.data, response.data.csrf)
        // this.error = ''
        // this.$router.replace('/')
      }
    })
  .catch(error => console.log(error))
  start()
  } 
}
//хэндлер удара по боссу
function handler(){
  if (hpboss.value <= 0){
    bossdeath()
  }else{
    if (ready.value == true && store.thealth != 0 ) {

      secured
      .post('/hitboss')
        .then(response => {
          if (response.data ){
            store.setcp(response.data.avcpoints)
            console.log(response.data)
            // familiarup.value = response.data.death
            console.log( response.data.death)
            // store.setCurrentUser(meResponse.data, response.data.csrf)
            // this.error = ''
            // this.$router.replace('/')
            if (familiar.value == true && familiarup.value == false && response.data.death == false){
              hpghoulpoints.value = response.data.ghohp
              hpghoul.value = 100
              ghoul.value = true
              bosssummon()
              nextTick(() => {
                famspawn() 
              })
              // ghoulstay()
            }else{
              bosshit()
              hpbosspoints.value = response.data.hp
   
              // hpboss.value = hpbosspoints.value * 100 / response.data.bossfullhp

              if (response.data.health >= 0){
                store.sethealth(response.data.health)
                store.hitme()
                const firstPhrase = phrases.value[Math.floor(Math.random() * 16)]; // First phrase object
                const originalFirstPhrase = firstPhrase.original; // Original English phrase
                const translatedFirstPhrase = firstPhrase.translation; 
                bossphrase.value = firstPhrase.translation 
                bosstalk()
                store.setdead(response.data.dead)
              }
              if (response.data.lvl){
                store.setlvl(response.data.lvl)
              }
              if(response.data.progress){
                store.setprogress(response.data.progress)
              }
            }               
          }


        })
        .catch(error => console.log(error)) 
      start()
    }    
  }
}


const ghouldirection = ref(2.4)
watch(ghouldirection, () => {
  ghoulstay();
})

function ghoulmove(val) {
  ghoulstay()
  // console.log(val)
  var moveResult = randpos(); 

  function dur () {
    var res = (moveResult - val)/80
    return Math.abs(res)+2 
  }  
  function ghodir () {
    if (moveResult > val){
     return ghouldirection.value = 2.4
    }else{
      return ghouldirection.value = -2.4
    }
  }       
  ghodir();
  b5 = gsap.timeline();  
  b5.to([ ".familiar", ".ghohpbar", "hpghoulpoints", ".drops"],{
    ease: "none",
    // repeat:-1, 
    duration: dur,
    x: moveResult,
    onComplete: function () {

      // gsap.delayedCall(2, function () {
        if(ghoul.value){
          ghostatic(moveResult)
          // ghoulmove(moveResult) 
        }
      // });
    },
  })
}
 
function ghoulhit() {
  // const myObject = document.getElementById('myObject');
  const currentX = Math.round(gsap.getProperty(ghoul.value, 'x'));
  

  if (b1) {
    b1.kill(); 
  }  
  if (b2) {
    b2.kill(); 
  }  
  if (b5) {
    b5.kill(); 
  }
  if (b3) {
    b3.kill(); 
  }  
  // b3 = gsap.timeline();   
  gsap.set(".familiar", {
    // scale: 2.4,
    transformOrigin: "bottom",
    backgroundImage: 'url('+ghoulhitimg+')',
    // x: randpos(), 
    backgroundPosition: "0px",      
    scaleX: ghouldirection.value,

  })
  b3 = gsap.timeline();  
  b3.to(".familiar",{
    duration: 0.5,
    // repeat:-1,
    ease: "steps(3)",
    backgroundPosition: "-186px",
    // onComplete: 
 
    onComplete: function () {
      hitoff(currentX)
     // hitkill()
      // ghoulstay()
      // ghoulmove(randpos)
    }
    // scaleX: bossdirection.value
  }) 
   // b2.add(b3);    
}
function  hitoff(val) {
b3.kill(); 
// ghoulstay()
 
ghoulmove(val)
}
function ghostatic(val) {
  if (b2) {
    b2.kill(); 
  }   
  gsap.set(".familiar", {
    // scale: 2.4,
    transformOrigin: "bottom ",
    backgroundImage: 'url('+ghoulstatic+')',
    x: val, 
    backgroundPosition: "0px",      
    scaleX: ghouldirection.value
  }); 
  b2 = gsap.timeline();  
  b2.to(".familiar",{
    duration: 2,
    // repeat:-1,    
    // ease: "steps(8)",
    // backgroundPosition: "-496px",
    // scaleX: bossdirection.value
    onComplete: function () {
      // ghoulstay()
      ghoulmove(val)
    }
  })     
}

function ghoulstay() {
  if (b2) {
    b2.kill(); 
  }   
  gsap.set(".familiar", {
    // scale: 2.4,
    transformOrigin: "bottom ",
    backgroundImage: 'url('+walk+')',
    // x: randpos(), 
    backgroundPosition: "0px",      
    scaleX: ghouldirection.value
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
function famspawn() {
  familiarup.value = true
  nextTick(() => {
    var moveResult = randpos(); 
    // var moveResult = randpos(); 
    gsap.set(".ghohpbar", {
      x: moveResult, 
      display: "block"
    })

    gsap.set(".familiar", {
      // scale: 2.4,
      transformOrigin: "bottom ",
      backgroundImage: 'url('+spawn+')',
      x: moveResult, 
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
      onComplete: function () {
        // ghoulstay()
        ghoulmove(moveResult)
      }
    })  
  })   
}

function ghouldeath() {
  if (b1) {
    b1.kill(); 
  }  
  if (b2) {
    b2.kill(); 
  }  
  if (b3) {
    b3.kill(); 
  }  
  // if (b5) {
  //   b5.kill(); 
  // }   
  gsap.set(".familiar", {
    // scale: 2.4,
    transformOrigin: "bottom ",
    backgroundImage: 'url('+ghouldead+')',
    // x: moveResult, 
    backgroundPosition: "0px",      
    scaleX: bossdirection.value
  }); 
  b2 = gsap.timeline();  
  b2.to(".familiar",{
    duration: 0.8,
    // repeat:-1,    
    ease: "steps(7)",
    backgroundPosition: "-434px",
    onComplete: function () {
      // ghoulstay()
      end()
    }    
    // scaleX: bossdirection.value
  })  
  function end(){ 

    mdrop.value = true
    setTimeout(() => {
      mdrop.value = false
        if (b5) {
        b5.kill(); 
      }  
    }, "40000");
    familiarup.value = false
    twooff() 
  }  
  function twooff() {  
    b2.kill() 

  }      
}
import { useElementBounding } from '@vueuse/core'
const spawn = new URL("../images/sprites/monsters/Ghoul/spawn.png", import.meta.url).href;
const walk = new URL("../images/sprites/monsters/Ghoul/Walk.png", import.meta.url).href;
const ghouldead = new URL("../images/sprites/monsters/Ghoul/death.png", import.meta.url).href;
const ghoulhitimg = new URL("../images/sprites/monsters/Ghoul/hit.png", import.meta.url).href;
const ghoulstatic = new URL("../images/sprites/monsters/Ghoul/static.png", import.meta.url).href;

const idle = new URL("../images/sprites/monsters/summoner/idle.png", import.meta.url).href;
const move = new URL("../images/sprites/monsters/summoner/move.png", import.meta.url).href;
const hit = new URL("../images/sprites/monsters/summoner/hit.png", import.meta.url).href;
const death = new URL("../images/sprites/monsters/summoner/death.png", import.meta.url).href;
const summon = new URL("../images/sprites/monsters/summoner/summon.png", import.meta.url).href;

// const dropmove = ref(null)
// const { x, y, top, right, bottom, left, width, height } = useElementBounding(ghoul)
const repDelay = ref()
const plain: any = inject('plain')
const secured: any = inject('secured')
const bossdirection = ref(2.4)
let b1 = null;
const bossref = ref(null)
function randpos() {
  return Math.floor(Math.random() * (props.width - 110) ); // start position on page load
}

onMounted(() => {
  nextTick(() => {
 
    function bossmove(val) {
      // console.log(val)
      // var b2 = gsap.timeline({ repeat: -1, onRepeat: updateRandomX  });  
      // function updateRandomX() {
        // console.log(val)
      // function calcmove () {
      //   return Math.floor(Math.random() * (props.width - 110) );
      // }    
      var moveResult = randpos(); 
      if( val == "undefined"){
          b4.kill()
      }
      // console.log(val)
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
      b4 = gsap.timeline();
      b4.to([".hpbar",".boss",".hpbosspoints"],{
        ease: "sine.inOut",
        // repeat:-1, 
        duration: dur,
        x: moveResult,
        onComplete: function () {

          gsap.delayedCall(2, function () {
            if(bossref.value){
              bossmove(moveResult); // Pass moveResult as an argument to bossmove()
            }
          });
        },
      })
    }
    watch(bossdirection, () => {
      bossstay();
    }); 
    if(bossref.value){
      bossstay();
      bossmove();     
    }
    // var master = gsap.timeline();
    // master.add(bossstay()).add(bossmove()) 
  })
})

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
.phrase{
  opacity: 0;
  width: 30%;
    position: absolute;
    padding-left: 4em;
    padding-top: 1em;
}
.drops{
  position: absolute;
  bottom: 0px;
 
}
.mainframe{
  position: relative;
}
/*.pers{
  position: relative;
}*/
.hpbar{
  width: 60px;
}
.ghohpbar{
  right: 8px;
  /*background-color: #dad;*/
  bottom: 0;
  display: none;
  position: absolute;
  width: 35px;
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
.familiar:hover{
  cursor: url("../images/sword.png"), pointer;
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
