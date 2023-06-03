<template>
  <div class="d-flex "> 
<!--     {{ls.get('account').signedIn}}
{{ls.get('account').loa}} -->
    <div v-if="store.tsignedIn == true" class="d-flex align-center">
      <v-btn
        color="primary"  
        @click="signOut">выйти
      </v-btn>    
      <div  class="d-flex flex-column">
        <div class="interface px-1">{{lvl}}</div>
        <div class="interface px-1 d-flex justify-end">к:{{karma}}</div>        
      </div>   

      <div class="d-flex flex-column">
 
           <v-progress-linear :height="8" class="mb-1" :model-value="userhp" color="success" ></v-progress-linear>
           <v-progress-linear :height="2" class="mb-1" :model-value="exp" color="success" ></v-progress-linear>

 
        
        <div class="d-flex flex-row-reverse pt-1">
          <div v-for="(item, index) in cp" class="cp ml-1" v-bind:style="{backgroundImage: 'url('+ getImageUrl(index)}"></div>
          </div>          
        </div>


    </div>  
    <div v-if="store.tsignedIn == false"> 
 
      <signup></signup>
      <signin></signin>
    </div>
 
    <div class="useraction d-flex">  
 
      <inventory  v-if="store.tsignedIn == true"> </inventory>
      <div class="loa px-2 align-self-center" >{{store.tloa}}</div>
      <div class="skull align-self-center"></div>
    </div>
  
  </div>
</template>

<script setup lang="ts">
  const karma = ref(0)
const userhp = ref(80)
const lvl = ref(13)
const exp = ref(50)

const cp = ref(5)
const avcp = ref(3)
const coverp = ref(2)

const getImageUrl = (number) => {
  console.log(number)
  if ((number+1) <= avcp.value) {
    return greenimg;
  } else {
    return cpimg;
  }
};

const greenimg = new URL("../images/cp/green.png", import.meta.url).href;
const overcpimg = new URL("../images/cp/overcp.png", import.meta.url).href;
const cpimg = new URL("../images/cp/cp.png", import.meta.url).href;
import { useRouter, useRoute } from 'vue-router'
const router = useRouter()
const route = useRoute()  
import ls from 'localstorage-slim'; 
  import { ref, computed, inject } from 'vue';
  import { useLogStore } from '../../store.js'  
  const store = useLogStore()
  const plain: any = inject('plain')
  const secured: any = inject('secured')
  import inventory from './inventory.vue';  
 
  // import { useLogStore } from 'store.js'
  import Signup from './sign_up.vue';
  import Signin from './sign_in.vue';
  // import Signin from './packs/components/Signin.vue';
  // const signedIn = computed(() => store.tsignedIn)
// const trock = computed(() => store.trock)
  // const loa = ref()

// export default {
  // data: function () {
  //   return {
  //     loa: "",
  //   }
  // },
 
  // methods: {
  //   ...mapActions(useLogStore, ["unsetLoa"]),     
  //   ...mapActions(useLogStore, ["unsetCurrentUser"]), 
 
    function signOut(){
      secured
      .delete('/signin')
      .then(response => {
        // store.unsetLoa()
        store.unsetCurrentUser()
        router.push({ name: "hat" });
        // store.unsetLoa
        // this.$router.replace('/')
      })
      // .catch(error => setError(error, 'Cannot sign out'))
    }
  // },
//   computed: {
//     ...mapState(useLogStore, {
//       currentUser: "thiscurrentUser",
//     }),     
//     ...mapState(useLogStore, {
//       csrfstat: "thiscsrf",
//     }),    
//     // ...mapState(useLogStore, ['thislog'])
//     ...mapState(useLogStore, {
//       loastat: "thisloa",
//     }),
//     ...mapState(useLogStore, {
//       signedIn: "thissignedIn",
//     }),  
//   },  
// }
</script>

<style scoped>
.cp{
  height: 8px;
  width: 8px;
}
.inve{
  background-color: #dad;
  /*position: relative;*/
  z-index: 100;
  margin-top: -11px;
}
.useraction{
  z-index: 100;
  /*background-color: #ada;*/
  position: relative;
}
.sign{
  width: 380px;
}
 .skull{
  height: 20px;
  width: 20px;
  background-image: url('../images/skull.png');
  image-rendering: pixelated;
 }
</style>
