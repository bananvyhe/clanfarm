<template>

  	<div class="hat">	
	  	<div class="container">
	  		<div class="bgshad3"></div>
		  	<div class="flash"></div>
		  	<div class="clouds2"></div>
		  	<div class="bgshad"></div>
		  	<div class="clouds"></div>
		  	<div class="voodoo ">
<h3>
		  	 поиск партии...  
		  	</h3>
		  	</div>
		  	<div class="warriors"></div>
		  	<div class="warriors brightness"></div>
		  	<div class="bgshad2"></div>
		  	<div v-if="store.tsignedIn != true">
					<pumpk></pumpk>
				</div>
			</div>
  	</div>
		<news></news>

</template>
<script setup lang="ts">
  import { useLogStore } from '../../store.js'  
  const store = useLogStore()
import News from './news.vue'
import pumpk from './pumpk.vue'
import { gsap } from "gsap";
import { SlowMo } from "gsap/EasePack";
import { ref, onMounted, nextTick } from 'vue';
gsap.registerPlugin(SlowMo);

const repDelay = ref()

onMounted(() => {
	console.log("mounted1")
	nextTick(() => {
	console.log("mounted2")
  function voodoo() {
		gsap.set(".voodoo", {
			opacity: 0,	
			scale: 0,
			y: -15,
			// color: "#9f0000",	
		});

		var tl =	gsap.timeline();
			tl.to(".voodoo", {
				y: -15,
  		scale: 0.35,
			opacity: 0.8,	
  		duration: 0.7,  
  		// delay: 0.1,
  		 ease: "circle.in",
  		  
  	}).to(".voodoo", {
  		opacity: 0.7,	 
  		// delay: 0.1,
  		scale: 0.35,
  		y: -35,
  		// scale: 0.35,
			// opacity: 0,	
  		duration: 1.2,  
  		ease: "none",
  	}).to(".voodoo", {
  		// delay: 0.1,
  		y: -60,
  		scale: 0.35,
			opacity: 0,	
  		duration: 1,  
  		ease: "power.out",
  	}, '-=0.8')
	}

  function bgshad3() {
		gsap.set(".bgshad3", {
			opacity: 1,	
			scale: 1,
			y:-0,
		});

		var tl =	gsap.timeline();
			tl.to(".bgshad3", {
  		scale: 1.5,
			opacity: 0.7,	
  		duration: 2.4,  
  		ease: "circ.out", 
  	})
			.to(".bgshad3", {
			// delay: 0.1,
  		y:-45,
  		scale: 1.8,
			opacity: 0,	
  		duration: 4,  
  		ease: "sine.out",
  	})
	}

	function warriors() {
		gsap.set(".warriors", {
			backgroundPositionY: 165,
		});

		var tl =	gsap.timeline();
		tl.to('.warriors', {
			delay: 0.2,
			duration: 2.0,
			ease: "power4.out",
			backgroundPositionY: 0,
		}, '+=1.1');
	}

	function cloud() {
  	gsap.set(".clouds", {

			scale: 1.2,
		});

  	var tl =	gsap.timeline();
		tl.to('.clouds', {
			repeat: -1,
	 		duration: 18,
			backgroundPositionX: -1, 
			ease: "none",
		});
	}
	function cloud2() {
		var tl =	gsap.timeline();
		tl.to('.clouds2', {
			repeat: -1,
			duration: 18,
			backgroundPositionX: -1, 
			ease: "none",
		});
	}
	function brightness() {
		var tl =	gsap.timeline({repeat:-1});
		tl.set('.brightness', {opacity: "0"})
		.to('.brightness', {
			duration: 0.05,
			ease: "sine.in",
			delay: 0.5, 
			opacity: "1"}, 1.1)
		.to('.brightness', {
			delay: 0.3,
			duration: 1.4, 
			opacity: "0", 
			ease: "sine.out"}, '+=0.0')
		.to('.brightness', {
			delay: 1.4,
			duration: 0.05,
				ease: "sine.in",
			opacity: "1"}, '-=0.0')
		.to('.brightness',{
			delay: 0.3,
			duration: 2, 
			opacity: "0", 
			ease: "sine.out",})
		.to('.brightness',{
			delay: 3});		  		
	}

	function flash() {
		var tl =	gsap.timeline({repeat:-1});
		tl.set('.flash', {
			opacity: "0"})
		.to('.flash', {
			duration: 0.05,
			ease: "sine.in",
			delay: 0.5, 
			opacity: "1"}, 1.1)
		.to('.flash', {
			delay: 0.3,
			duration: 1.4, 
			opacity: "0", 
			ease: "sine.out"}, '-=0.0')
		.to('.flash', {
			delay: 1.4,
			duration: 0.05,
			ease: "sine.in",
			opacity: "1"}, '-=0.0')
		.to('.flash', {
			delay: 0.3,
			duration: 2,
			opacity: "0", 
			ease: "sine.out"})
		.to('.brightness',{
			delay: 3});		  		  		
	}
	var master = gsap.timeline();

	master.add(voodoo())
	.add(bgshad3())
  .add(warriors())     //with a gap of 2 seconds
  .add(cloud()) 
  .add(cloud2()) 
		.add(brightness() ) 
		.add(flash() ) 
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
	opacity: 0;
	white-space: nowrap;
 	/*color: #9f0000;*/
 	color: #036e00;
	display: flex;
	align-items: center;
	justify-content: center;
	height: 100%;
	width: 100%;
 
 
	position: absolute;
 
	font-size: 76px;
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

.bgshad3 {
	background-repeat: no-repeat;
	/*background-position: center bottom;*/
	background-size: cover;
	background-image: url('../images/_hat/fog2.jpg');
	position: absolute;
	height: 100%;
	width: 100%;
	background-position: center  -52px;
}
</style>