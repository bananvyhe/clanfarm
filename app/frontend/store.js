import { defineStore } from "pinia";
import ls from 'localstorage-slim'; 
export const useLogStore = defineStore(
  'logStore', 
  () => {

    const rock = ref()
    const trock = computed(() => rock.value)

    const inventory = ref([]) 
    const tinventory = computed(() => inventory.value)

    const pumpkdead = ref()
    const tpumpkdead = computed(() => pumpkdead.value)

    function setinv(val) {
      // console.log(val)
      inventory.value = val

    } 
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
      ls.set('account', { loa: loa.value })     
    }

    function decrements(val) {
    	console.log(val)
      loa.value -= val
      ls.set('account', { loa: loa.value })     
    }

    const currentUser = ref(ls.get('account').currentUser)
    const signedIn = ref(ls.get('account').signedIn)
    const tsignedIn = computed(() => signedIn.value)
    const ctsrf = ref(ls.get('account').ctsrf)
    const tctsrf = computed(() => ctsrf.value)
    const loa = ref(ls.get('account').loa)
    const tloa = computed(() => loa.value)
    const role = ref(ls.get('account').role)
    const trole = computed(() => role.value)
    const email = ref(ls.get('email'))
    const temail = computed(() => email.value)
      // ls.set("data", {superman: "Clark Kent", power: 100})
      // ls.set("data.power", 150);

    function setCurrentUser (currentUser, csrf) {
      const value = {
        signedIn: true,
        ctsrf: csrf,
        currentUser: currentUser.id,
        loa: currentUser.loa,
        role: currentUser.role
      }
      currentUser.value = currentUser.id
      signedIn.value = true
      ctsrf.value = csrf
      loa.value = currentUser.loa
      ls.set('account', value)
    }

    function unsetLoa () {
      loa.value = 0
      ls.set('account.loa', 0) 
    }

    function unsetCurrentUser () {
      const value = {
        signedIn: false,
        ctsrf: "",
        currentUser: "",
        loa: "",
        role: ""
      }
      loa.value = 0
      // ls.set('currentUser', 0) 
      currentUser.value = ""
      // ls.set('signedIn', false) 
      signedIn.value = false
      // ls.set('ctsrf', 0) 
      ctsrf.value = ""
      ls.set('account', value)
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
    unsetLoa,
    tctsrf, 
    trole,
    temail,
    tinventory,
    setinv }
})