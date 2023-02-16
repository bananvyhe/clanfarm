<template>
  <div>
		<v-layout >
			<v-app-bar density="compact" class="py-0">
				{{arrivedState.bottom }} {{isScrolling }}
			</v-app-bar>
				123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>123<br>	
				<div v-if="bottom">Uhuy! Sampai bawah</div>	
		</v-layout>
  </div>
</template>
<script setup lang="ts">
	import { ref, computed } from 'vue'
	import { useScroll } from '@vueuse/core'
	// const content = ref(<HTMLElement | null>(null))
	// const { arrivedState } = useScroll(content)
	const { x, y, isScrolling, arrivedState, directions } = useScroll(document)

	const bottom = computed(() => {
	  if (arrivedState.bottom) {
	    console.log('Yay!')
	    console.log( arrivedState.bottom )
	    return true
	  }
	  return false
	})
</script>

<style scoped>

</style>