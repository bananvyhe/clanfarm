import { defineStore } from "pinia";

export const useLogStore = defineStore('logStore', () => {

  const rock = ref(4)
  const loa = ref(7)
  const trock = computed(() => rock.value)
  const tloa = computed(() => loa.value)
  // function increment() {
  //   count.value++
  // }

  return { rock, trock, loa, tloa }
})