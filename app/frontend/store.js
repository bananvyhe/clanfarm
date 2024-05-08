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
    	// console.log(typeof val)
      const account = ls.get('account');
      console.log(typeof(val))

    const num = Number(loa.value)
      if (!loa.value){
        loa.value = 0
      }
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

    const hitanim = ref(false)
    const thitanim = computed(() => hitanim.value)

    function hitme() {
      hitanim.value = true 
      setTimeout(() => {
        hitanim.value = false
      }, 500);
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
    const health = ref(ls.get('account').health)
    const thealth = computed(() => health.value)
    const maxhealth = ref(ls.get('account').maxhealth)
    const tmaxhealth = computed(() => maxhealth.value)
    const cpoints = ref(ls.get('account').cpoints)
    const tcpoints = computed(() => cpoints.value)
    const avcpoints = ref(ls.get('account').avcpoints)
    const tavcpoints = computed(() => avcpoints.value)
    const dead = ref(ls.get('account').dead)
    const tdead = computed(() => dead.value)
    const online = ref(ls.get('account').online)
    const tonline = computed(() => online.value)
    const gramlog = ref(ls.get('gramlog'))
    // const tgramlog = computed(() => gramlog.value)

    let valueall;
    function makevalues() {
      valueall = {
        signedIn: signedIn.value,
        ctsrf: ctsrf.value,
        currentUser: currentUser.value,
        loa: loa.value,
        role: role.value,
        expirience: expirience.value,
        lvl: lvl.value,
        progress: progress.value,
        health: health.value,
        maxhealth: maxhealth.value,
        cpoints: cpoints.value,
        avcpoints: avcpoints.value,
        dead: dead.value,
        online: online.value,
      }     
    }

    function setCurrentUser (currentUser, csrf) { 
      currentUser.value = currentUser.id
      signedIn.value = true
      ctsrf.value = csrf
      loa.value = currentUser.loa
      expirience.value = currentUser.expirience
      lvl.value = currentUser.lvl
      progress.value = currentUser.progress
      health.value = currentUser.health
      maxhealth.value = currentUser.maxhealth
      cpoints.value = currentUser.cpoints
      avcpoints.value = currentUser.avcpoints
      dead.value = currentUser.dead
      online.value = currentUser.updated_at
      makevalues()
      savesign()
    }
    function setctsrf(UserData, ) {
      makevalues()
      ctsrf.value = val
      valueall.ctsrf = val
      ls.set('account', valueall)
    }  
    function setgramlog(val) {
      // makevalues()
      const gramlogjson  = JSON.stringify(val)
      // valueall.gramlog = JSON.stringify(val)
      ls.set('gramlog', val)
      console.log (gramlog)
      const gramid = ls.get('gramlog').id
      console.log (gramid)
      gramlog.value = gramlogjson
    }     
    function setdead(val) {
      makevalues()
      dead.value = val
      valueall.dead = val
      ls.set('account', valueall)
    } 
    function setcp(val) {
      makevalues()
      avcpoints.value = val
      valueall.avcpoints = val
      ls.set('account', valueall)
    }

    function sethealth(val) {
      makevalues()
      // console.log(val)
      health.value = val
      valueall.health = val
      ls.set('account', valueall)
    }

    function savesign(val) {
      ls.set('account', valueall)
    }

    function regincrements(val) {
      makevalues()
      const loainc = loa.value += val
      valueall.loa = loainc
      ls.set('account', valueall)
    }

    function setlvl(val) {
      makevalues()
      lvl.value = val
      valueall.lvl = val
      ls.set('account', valueall)
    }

    function setprogress(val) {
      makevalues()
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
        online: "",
        signedIn: false,
        ctsrf: "",
        currentUser: "",
        loa: "",
        role: "",
        expirience: "",
        lvl: "",
        progress: "",
 
      }
      signedIn.value = false
       loa.value = 0
      // ls.set('currentUser', 0) 
      currentUser.value = ""
      // ls.set('signedIn', false) 
      
      // ls.set('ctsrf', 0) 
      ctsrf.value = ""
      ls.set('account', value)
    }

    function refresh (csrf) {
      signedIn.value = true
      ctsrf.value = csrf
      valueall.ctsrf = csrf
      ls.set('account', valueall)

    }

  return { 
    // tgramlog,
    setgramlog,
    tonline,
    trock, 
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
    setprogress,
    thealth,
    sethealth,
    tmaxhealth,
    thitanim,
    hitme,
    tavcpoints,
    tcpoints,
    setcp,
    tdead,
    setdead,
    setctsrf }
})