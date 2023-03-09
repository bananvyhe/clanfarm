import { defineStore } from "pinia";
import ls from 'localstorage-slim'; 
export const useLogStore = defineStore('logStore', () => {

  const rock = ref(4)
  const loa = ref(ls.get('load'))
  const trock = computed(() => rock.value)
  const tloa = computed(() => loa.value)

  const pumpkdead = ref(false)
  const tpumpkdead = computed(() => pumpkdead.value)

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

  return { rock, trock, loa, tloa, tpumpkdead, increments, setPumpkAlive, setPumpkDead }
})