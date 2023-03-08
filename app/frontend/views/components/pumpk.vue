<template>
  <div class="main mx-0 my-0">

    <!-- <drop class="drops"></drop> -->

    <div   :class="loc == 'alive' ? 'unit' : 'off'  " v-on:click="handler()" > 
      <div class="hpoints d-flex justify-center subtitle-2">{{hpoints}}</div> 
      <!-- <damagecomp ref="hitt"></damagecomp> -->
      <div class="hpbar">
        <v-progress-linear :value="hp" color="success"></v-progress-linear>
      </div>
      <div :class="loc == 'alive' ? 'character' : 'death'" :style="[  reuse ?  {cursor: 'not-allowed'}:{} ]"></div>
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

  //   export default {   
	 //  components: {
	 //    'damagecomp': Damagecomp,
  //     'drop': Drop
	 //  },
  const classObject = reactive({
    active: true,
    'text-danger': false    
  })
  const hpoints = ref(124)
  const hp = ref(100)
  const dmg = ref()
  const loc = ref()
  //   data: function (){
  //     return {
  //       classObject: {
  //         active: true,
  //         'text-danger': false
  //       },        
  //     	hpoints: 124,
  //       hp: 100,
  //       dmg: '',
  //       loc: ''
  //     }
  //   },

  //   watch:{
  //     pumpkdead: function (val){
  //       if (val == true){

  //       }else{

  //       }
  //     }
  //   },
  const pumpkdead = computed(() => store.tpumpkdead)
  //   computed:{
  //     ...mapState(useLogStore, {
  //       reuse: "thisreuse",
  //     }),         
  //     ...mapState(useLogStore, {
  //       signedIn: "thissignedIn",
  //     }), 
  //     ...mapState(useLogStore, {
  //       pumpkdead: "thispumpkdead",
  //     }),          
  //   },
  //   methods: {
  //     ...mapActions(useLogStore, ["reuseCalc"]),        
  //     ...mapActions(useLogStore, ["increments"]),
  //     ...mapActions(useLogStore, ["setPumpkDead"]),
  //     ...mapActions(useLogStore, ["setPumpkAlive"]),   
  //     incloareg(){

  //     },
const { ready, start } = useTimeout(1000, { controls: true })
    // <p>Ready: {{ ready.toString() }}</p>
    // <button :disabled="!ready" @click="start()">  
function handleClick(){

}
  //   	handler(arg1,arg2){
        
  //       if (this.reuse == false){
  //         this.hitn()
  //         if (ls.get('hey') == "death"){
  //           console.log("pumpk is dead!")
  //         }else{
  //           this.hitpumpk()
  //           this.reuseCalc()
  //         }
  //       }else{

  //       }

  //   	},

  //     hitn(){
  //       var hitn = gsap.timeline();
  //       hitn.to(".character",{
  //          x: -4,
  //          duration: 0.2,  
  //          ease: "elastic.in",
  //       }).to(".character", {
  //         x: 0,
  //         duration: 0.2,  
  //         ease: "elastic.out", 
  //       })    
  //     },
function hitpumpk(){
  //      // var interval = 15000000;
        // var interval = 26500;
        var interval = 7000;
}
  //   	hitpumpk(){
  //   		// var interval = 15000000;
  //       // var interval = 26500;
  //       var interval = 7000;
  //   		this.$refs.hitt.hitcalc();
  //   		this.dmg = this.$refs.hitt.hit
		// 		var hpleft = this.hpoints - this.dmg
  //       var percentcut = hpleft * 100 / this.hpoints
  //       this.hpoints = hpleft
  //       this.hp = percentcut
  //       console.log(this.hp)
  //       if (this.hpoints <= 0){
  //     		ls.set('hey', "death") 
  //         this.setPumpkDead()
  //     		reset();
  //     		var min = 2
		// 	    var max = 5
		// 	    var loa = Math.random() * (max - min) + min;
		// 	    loa =  Math.round(loa)
		// 	    loa = Number(loa)

  //         if (this.signedIn == true){
  //           this.$http.secured.post('/incloareg', {loa: loa})
  //           .then(response => { 
  //              console.log(response)
  //              this.increments(loa)   
  //           })
  //           .catch(error => { this.setError(error, 'Something went wrong') })
  //         }else{
  //           this.increments(loa)            
  //         }
  //       }else{
  //       	console.log("else hitpumpk ")
  //       }
  //       function reset(){
  //     		// занесение в локалсторадж даты окончания таймера
  //     		var endt =  +new Date + interval
		// 		   ls.set('endTimer', endt)  
		// 		  // console.log("endt")
		// 		  // console.log(endt)
		// 		}
  //   	}
  //   },

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
 
        var self = this
       setInterval(function(){
         if( ls.get('hey') == "death" ){
           // занесение в переменную оставшиеся милисекунды до окончания(обратный отсчет)
           var getendt = ls.get('endTimer')
           var remaining = getendt - new Date;
           console.log(getendt)
         }
         // если отсчет не завершился то присваиваем статус "мертвый" в локалсорадж
         if( remaining >= 0 ){
            self.setPumpkDead()
           ls.set('hey', "death") 
           console.log("dead")
           console.log(remaining)
            }else if ( remaining < 0 ){
              self.setPumpkAlive()

           var alive = gsap.timeline();
           alive.to(".off",{
              delay: 2,
               className: "+=unit",
             })
             var m1 = gsap.timeline();
             m1.to(".death",{
              delay: 2,
               className: "+=character",
                 onComplete: ressurect
             })
               console.log("alive")
               ls.set('hey', "alive") 
            }
        }, 1000);    
       var self = this
       function ressurect() {  
         self.hp = 100
         self.hpoints = 124
         pumpk()
       }

        function pumpk() {
          gsap.set(".character", {
            scale: 1.5,
          });

          var m1 = gsap.timeline();
          m1.to(".character",{
            duration: 1,
            repeat:-1,
            repeatDelay: 1,
            backgroundPosition: "-528px",
            ease: "steps(11)",
            onRepeat: myFunction
          })
          function myFunction(){
             if (ls.get('hey') == "death"){
             console.log("death")
             m1.to(".character",{
               className: "+=death",
               onComplete: endFunc
             })
             function endFunc(){
               m1.kill()
               var m2 = gsap.timeline();
               m2.to(".death",{
                 duration: 1,
                 backgroundPosition: "-960px",
                 ease: "steps(20)",
                 onComplete: end
               })
               function end(){
                  var m2 = gsap.timeline();
                  m2.to(".unit",{
                    className: "+=off",
                    // onComplete: oregen
                  })
                }
             }
           }
          }
        }
        var master = gsap.timeline();
        if (ls.get('hey') == "alive" || !ls.get('hey')){
          master.add(pumpk())
        }
      })




  })
 	// 	created() {

		// 	if (ls.get('hey') != "death"){
  //   		this.loc = "alive"
  //   		console.log("666")
  //   	}
 	// 	},
  //   mounted() {
  //   	if(ls.get('endTimer') == "death"){
  //   		ls.set('hey', "alive") 
  //   	} 
 
  //   	if (ls.get('hey')){
  //   		this.loc = ls.get('hey')
  //   	}
    	
  //     window.addEventListener('load', () => {
 
  //       var self = this
		// 		setInterval(function(){
		// 			if( ls.get('hey') == "death" ){
		// 				// занесение в переменную оставшиеся милисекунды до окончания(обратный отсчет)
		// 				var getendt = ls.get('endTimer')
		// 	    	var remaining = getendt - new Date;
		// 	    	console.log(getendt)
		// 	  	}
		// 	  	// если отсчет не завершился то присваиваем статус "мертвый" в локалсорадж
		// 	    if( remaining >= 0 ){
  //           self.setPumpkDead()
		// 	      ls.set('hey', "death") 
		// 	      console.log("dead")
		// 	      console.log(remaining)
  //           }else if ( remaining < 0 ){
  //             self.setPumpkAlive()

		// 	      var alive = gsap.timeline();
		// 	      alive.to(".off",{
  //             delay: 2,
	 // 						className: "+=unit",
	 // 					})
	 // 					var m1 = gsap.timeline();
	 // 					m1.to(".death",{
  //             delay: 2,
	 // 						className: "+=character",
	 // 							onComplete: ressurect
	 // 					})
	 // 				    console.log("alive")
	 // 				    ls.set('hey', "alive") 
  //           }
  //       }, 1000);		
		// 	  var self = this
		// 	  function ressurect() {	
		// 	  	self.hp = 100
		// 	  	self.hpoints = 124
		// 	  	pumpk()
		// 	  }

  //       function pumpk() {
  //         gsap.set(".character", {
  //           scale: 1.5,
  //         });

  //         var m1 = gsap.timeline();
  //         m1.to(".character",{
  //           duration: 1,
  //           repeat:-1,
  //           repeatDelay: 1,
  //           backgroundPosition: "-528px",
  //           ease: "steps(11)",
  //           onRepeat: myFunction
  //         })
  //         function myFunction(){
  //    				if (ls.get('hey') == "death"){
  //           	console.log("death")
		// 		    	m1.to(".character",{
		// 			     	className: "+=death",
		// 			     	onComplete: endFunc
		// 		    	})
		// 			  	function endFunc(){
		// 			    	m1.kill()
		// 			    	var m2 = gsap.timeline();
		// 			  		m2.to(".death",{
		// 	          	duration: 1,
		// 	          	backgroundPosition: "-960px",
		// 	          	ease: "steps(20)",
		// 	          	onComplete: end
		// 	          })
  //       	      function end(){
  //                 var m2 = gsap.timeline();
  //                 m2.to(".unit",{
  //                   className: "+=off",
  //                   // onComplete: oregen
  //                 })
  //               }
		// 		      }
		// 		    }
  //         }
  //       }
  //       var master = gsap.timeline();
  //       if (ls.get('hey') == "alive" || !ls.get('hey')){
  //         master.add(pumpk())
  //       }
  //     })
  //   }
  // }
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
	opacity: 0;
}
.death{
  image-rendering: pixelated;
	background: url(../images/sprites/monsters/pumpkinbow.png);
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
  z-index: 2;
  position: relative;
  background: url(../images/sprites/monsters/pumpkina.png);
  image-rendering: pixelated;
  width: 48px;  height:48px; 
  cursor: url("../images/sword.png"), pointer;
}
.character:hover{
  cursor: url("../images/sword.png"), pointer;
}
</style>