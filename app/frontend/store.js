import { defineStore } from "pinia";

export const useLogStore = defineStore('logStore', () => {

  const rock = ref(4)

  const thisrock = computed(() => rock.value)

  // function increment() {
  //   count.value++
  // }

  return { rock, thisrock }
})