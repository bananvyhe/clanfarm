import { defineStore } from "pinia";
import ls from 'localstorage-slim'; 
export const useLogStore = defineStore(
  'logStore', 
  () => {

    const rock = ref()
    const loa = ref(ls.get('load'))
    const trock = computed(() => rock.value)
    const tloa = computed(() => loa.value)

    const signedIn = ref(false)
    const tsignedIn = computed(() => signedIn.value)

    const pumpkdead = ref()
    const tpumpkdead = computed(() => pumpkdead.value)

    function setrock() {
      if (!rock.value){
        rock.value = 1
      }
      rock.value += 1
    }
    function setPumpkDead() {
      pumpkdead.value = true
    }

    function setPumpkAlive() {
      pumpkdead.value = false
    }
    function increments(val) {
    	console.log(val)
      loa.value += val
      ls.set('load', loa.value)     
    }  
    function decrements(val) {
    	console.log(val)
      loa.value -= val
      ls.set('load', loa.value)     
    }  

  return { trock, tloa, tpumpkdead, increments, decrements, setPumpkAlive, setPumpkDead, tsignedIn, setrock }
})