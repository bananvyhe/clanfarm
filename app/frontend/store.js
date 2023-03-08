import { defineStore } from "pinia";

export const useLogStore = defineStore('logStore', () => {

  const rock = ref(4)
  const loa = ref(7)
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
  

  return { rock, trock, loa, tloa, pumpkdead }
})