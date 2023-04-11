import { defineStore } from "pinia";
import ls from 'localstorage-slim'; 
export const useLogStore = defineStore(
  'logStore', 
  () => {

    const rock = ref()
    const loa = ref(ls.get('load'))

    const trock = computed(() => rock.value)
    const tloa = computed(() => loa.value)

    const role = ref(ls.get('role'))
    const trole = computed(() => role.value)

    const email = ref(ls.get('email'))
    const temail = computed(() => email.value)


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

    const currentUser = ref(ls.get('currentUser'))
    const signedIn = ref(ls.get('signedIn'))
    const tsignedIn = computed(() => signedIn.value)
    const ctsrf = ref(ls.get('ctsrf'))
    const tctsrf = computed(() => ctsrf.value)
    function setCurrentUser (currentUser, csrf) {
      console.log(currentUser)
      // currentUser.value = currentUser.id
      ls.set('currentUser', currentUser.id)
      signedIn.value = true
      ls.set('signedIn', true)
      ctsrf.value = csrf
      ls.set('ctsrf', csrf)
      // loa.value = loa
      ls.set('load', currentUser.loa)

      ls.set('role', currentUser.role)
    }
    function unsetLoa () {
      loa.value = null
      ls.set('load', "") 
    }

    function unsetCurrentUser () {
      ls.set('currentUser', 0) 
      currentUser.value = ""
      ls.set('signedIn', false) 
      signedIn.value = false
      ls.set('ctsrf', 0) 
      ctsrf.value = ""
    }

    function refresh (csrf) {
      signedIn.value = true
      ctsrf.value = csrf
    }

  return { trock, 
    tloa, 
    tpumpkdead, 
    increments, 
    decrements, 
    setPumpkAlive, 
    setPumpkDead, 
    tsignedIn, 
    setrock, 
    setCurrentUser, 
    unsetCurrentUser, 
    tctsrf, 
    trole,
    temail }
})