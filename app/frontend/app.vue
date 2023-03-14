<template>
  <div>
		<v-layout >
			<v-app-bar density="compact" class="topmenu py-0">
        <v-container  class="py-0 fill-height" >
          <div class="my-0" >
            {{message}}<i> {{ tl }}</i> 
            <div class="subtitle-2 my-0 subt">
              Yandex neural network translator API 
            </div>
          </div>
          <v-spacer></v-spacer>
<!--           <userbar></userbar> -->
        </v-container>
			</v-app-bar>
		 <v-main >
        <v-container class="pt-0 cont" > 

          <router-view></router-view>
          
        </v-container>
      </v-main>
		</v-layout>
  </div>
</template>
<script setup lang="ts">
// import pumpk from './views/components/pumpk.vue'
import { gsap } from "gsap";
import { ref, computed, watch, reactive, onMounted, onBeforeMount, toRefs } from 'vue'
import { useScroll } from '@vueuse/core'
import { debounce } from 'lodash'
const { x, y, isScrolling, arrivedState, directions } = useScroll(document)
const { left: toLeft, right: toRight, top: toTop, bottom: toBottom } = toRefs(directions)
onMounted(() => {

})

const m1 = gsap.timeline();
const message = ref("Throne and Liberty ")
const tl = ref("mmorpg")
let isFirstUpdate = true
const showmenutop = reactive({ status: true});

// const debouncedFunc = debounce(() => {
//   m1.to(".topmenu",{
//     duration: 0.5,
//     y: 0,
//     ease: "elastic.in",
//   });
//   showmenutop.status = true;
//   console.log("scroll top");
// }, 500);

watch(() => toTop.value, 
	(newVal, oldVal) =>{
		// console.log(oldVal)
		// console.log(newVal)
		if (isFirstUpdate) {
      isFirstUpdate = false
    } else {
    	if (newVal == true){
			  m1.to(".topmenu",{
			    duration: 0.5,
			    y: 0,
			    ease: "elastic.in",
			  });    		
    	}
    	// debouncedFunc();			 
    }
  },
	{deep: true}
)

// const debouncedFuncbot = debounce(() => {
//   m1.to(".topmenu",{
// 	  duration: 0.5,
// 	  y: -48,
// 	  ease: "elastic.in",
// 	})
//  showmenutop.status = false
//   console.log("scroll botom");
// }, 500);

watch(() => toBottom.value, 
	(newVal, oldVal) =>{
		// console.log(oldVal)
		// console.log(newVal)
 		if (isFirstUpdate) {
      isFirstUpdate = false
    } else {
    	if (newVal == true){
			  m1.to(".topmenu",{
				  duration: 0.5,
				  y: -48,
				  ease: "elastic.in",
				})
    	}
    	// debouncedFuncbot();
    }
	}, 
	{deep: true}
)
</script>

<style scoped>
  .cont{
    position: relative;
  }
</style>