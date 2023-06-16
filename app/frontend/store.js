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

    function upinv(val) {
      console.log("upinv")
      console.log(val)
 
        const itemIndex = inventory.value.findIndex(item => item.listid === val.id);  
        if (itemIndex === -1) {
          const newItem = {id: val.id, listid: val.listid, qty: 1, title: val.title, desc: val.desc, item: val.item, position: val.position};
          inventory.value.push(newItem);   
          // }       
        } else {
          // console.log(itemIndex)
          inventory.value[itemIndex] = {...inventory.value[itemIndex], qty: inventory.value[itemIndex].qty + 1};
        // const newArray = inventory.value.map(item => {
        //   console.log("inventory.value.map")
        //   if (item.listid === val.listitem.id) {
        //     return {...item, qty: item.qty++};
        //   } 
        //   return item;
        // });
        }      
 
    } 

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
      const account = ls.get('account');
      account.loa = loa.value += val
      ls.set('account', account);
      // ls.set('account', { loa: reg})     
    }

    function decrements(val) {
    	console.log(val)
      const account = ls.get('account');
      account.loa = loa.value -= val
      // let res = loa.value -= val
      ls.set('account', account);
      // ls.set('account', { loa: res })     
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
    const expirience = ref(ls.get('account').expirience)
    const texpirience = computed(() => expirience.value)
    const lvl = ref(ls.get('account').lvl)
    const tlvl = computed(() => lvl.value)
    const progress = ref(ls.get('account').progress)
    const tprogress = computed(() => progress.value)

    function setCurrentUser (currentUser, csrf) {
      console.log(currentUser)
      currentUser.value = currentUser.id
      signedIn.value = true
      ctsrf.value = csrf
      loa.value = currentUser.loa
      expirience.value = currentUser.expirience
      progress.value = currentUser.progress
      lvl.value = currentUser.lvl
      const value = {
        signedIn: true,
        ctsrf: csrf,
        currentUser: currentUser.id,
        loa: currentUser.loa,
        role: currentUser.role,
        expirience: currentUser.expirience,
        lvl: currentUser.lvl,
        progress: currentUser.progress,
      }

      ls.set('account', value)
    }


    const valueall = {
      signedIn: signedIn.value,
      ctsrf: ctsrf.value,
      currentUser: currentUser.value,
      loa: loa.value,
      role: role.value,
      expirience: expirience.value
    }

    function regincrements(val) {
      const loainc = loa.value += val
      valueall.loa = loainc
      ls.set('account', valueall)
    }

    function setlvl(val) {
      lvl.value = val
      valueall.lvl = val
      ls.set('account', valueall)
    }

    function setprogress(val) {
      progress.value = val
      valueall.progress = val
      ls.set('account', valueall)
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
        role: "",
        expirience: ""
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
    setinv,
    setCurrentUser, 
    unsetCurrentUser, 
    unsetLoa,
    tctsrf, 
    trole,
    temail,
    tinventory,
    setinv,
    upinv,
    texpirience,
    regincrements,
    tlvl,
    tprogress,
    setlvl,
    setprogress }
})