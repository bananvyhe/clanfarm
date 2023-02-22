<template>
  <div>
		<v-layout >
			<v-app-bar density="compact" class="topmenu py-0">
				{{arrivedState.bottom }} {{isScrolling }} 
			</v-app-bar>
			<!-- <v-btn @click = "topmenu"></v-btn> -->
				123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123
<!-- 				<br>123directions.bottom {{directions.bottom}} <br>showmenutop.status {{showmenutop.status}}<br> isScrolling {{isScrolling }} <br>directions.top {{directions.top}}<br>toBottom {{toBottom}}<br>toTop {{toTop
				}}<br> -->
				123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br><br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br><br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>
				<!-- <div v-if="bottom">Uhuy! Sampai bawah</div>	 -->
		</v-layout>
  </div>
</template>
<script setup lang="ts">
import { gsap } from "gsap";
import { ref, computed, watch, reactive, onMounted, onBeforeMount, toRefs } from 'vue'
import { useScroll } from '@vueuse/core'
import { debounce } from 'lodash'
const { x, y, isScrolling, arrivedState, directions } = useScroll(document)
const { left: toLeft, right: toRight, top: toTop, bottom: toBottom } = toRefs(directions)

onMounted(() => {

})

//  

const m1 = gsap.timeline();

let isFirstUpdate = true
const showmenutop = reactive({ status: true});

const debouncedFunc = debounce(() => {
  m1.to(".topmenu",{
    duration: 0.5,
    y: 0,
    ease: "elastic.in",
  });
  showmenutop.status = true;
  console.log("scroll top");
}, 500);

watch(() => toTop.value, 
	(newVal, oldVal) =>{
		console.log(newVal)
		console.log(oldVal)
		if (isFirstUpdate) {
      isFirstUpdate = false
    } else {
    	debouncedFunc();			 
    }
  },
	{deep: true}
)

const debouncedFuncbot = debounce(() => {
  m1.to(".topmenu",{
  duration: 0.5,
  y: -48,
  ease: "elastic.in",
})
 showmenutop.status = false
  console.log("scroll botom");
}, 500);

watch(() => toBottom.value, 
	(newVal, oldVal) =>{
		console.log(newVal)
		console.log(oldVal)
 		if (isFirstUpdate) {
      isFirstUpdate = false
    } else {
    	debouncedFuncbot();			 
    }
	}, 
	{deep: true}
)
</script>

<style scoped>

</style>