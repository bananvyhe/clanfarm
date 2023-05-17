<template>

  	<div class="hat">	
	  	<div class="container" ref="el">
 
			<summoner :width = "width"></summoner>
			</div>
  	</div>
		<news></news>

</template>
<script setup lang="ts">
import Summoner from './boss.vue'
import News from './news.vue'
 
import { gsap } from "gsap";
import { SlowMo } from "gsap/EasePack";
import { ref, onMounted, nextTick } from 'vue';
import { useElementBounding } from '@vueuse/core'
 

const el = ref(null)
const { x, y, top, right, bottom, left, width, height } = useElementBounding(el)
const repDelay = ref()

onMounted(() => {
    	// console.log("mounted1")
			nextTick(() => {
// console.log("mounted2")
 
 
})
})

</script>
<style scoped>

/* .pumpkin {
  position: absolute;
 
  bottom: 4px;
  right: 14px;
  z-index: 50;
 }*/
.plashken {
	position: absolute;
	width: 100%;
 
	height: 0.4em;
}
.blank {
	height: 60px;
}
.container {
	height: 100%;
	overflow: hidden;	
	padding: 0;
 z-index: 10;
	display: flex;
	align-items: stretch;
	position: relative;
	background-color: #13151a;
	border-bottom: 2px solid color( #1E1E21 shade(40%));
}
.hat {
	height: 140px;
	top: 0;
 
}
.warriors {
	position: absolute;
	display: flex;
 
	background-repeat: no-repeat;
	background-position: center bottom;
 
	height: 100%;
	width: 100%;
	background-position: 43% 12px;
	background-size: auto 150%;
	background-image: url('../images/_hat/warriors2.png');
}
.war1{
	position: relative;
	background-color: #dad;
 
}
.voodoo {
	/*opacity: 1;*/
	white-space: nowrap;
 
	display: flex;
	align-items: center;
	justify-content: center;
	height: 100%;
	width: 100%;
 
 
	position: absolute;
 
	font-size: 12vh;
}
 
.brightness{
	filter: brightness(35%);
}
.flash {
	opacity: 0;
	position: absolute;
	height: 100%;
	width: 100%;
	background-repeat: no-repeat;
	background-position: center bottom;
	background-size: cover;
	background-image: url('../images/_hat/flash2.jpg');

}
.dvis {
	visibility: visible;
}
.clouds {  
	opacity: 0.3;
	background-repeat: repeat-x;
	position: absolute;
	background-image: url('../images/_hat/clouds2.png');
	background-position: center 0px;
	background-size: 300px  auto;
	height: 100%;
	width: 100%;

}
.clouds2 {  
 
	opacity: 0.9;
	background-repeat: repeat-x;
	position: absolute;
	background-image: url('../images/_hat/clouds2.png');
	background-position: center 0px;
	background-size: 800px auto;
	height: 100%;
	width: 100%;
	
}
.bgshad {
	background: rgb(0,0,0);
	background: linear-gradient(0deg,  rgba(9,66,121,0) 0%, rgba(6,45,82,0) 20%, rgba(0,0,0,0.8071603641456583) 100%);
	position: absolute;

	height: 100%;
	width: 100%;
}
.bgshad2 {
 
	background: rgb(0,0,0);
	background: linear-gradient(180deg, rgba(0,0,0,0) 0%, rgba(0,0,0,0.1) 60%, rgba(0,0,0,0.2) 80%,rgba(0,0,0,0.3) 95%, rgba(0,0,0,0.4) 100%);
	position: absolute;
	height: 100%;
	width: 100%;
}

</style>