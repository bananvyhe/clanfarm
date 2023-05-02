<template>
  <div class="d-flex "> 
<!--     {{ls.get('account').signedIn}}
{{ls.get('account').loa}} -->
    <div v-if="store.tsignedIn == true">
      <v-btn
        color="primary"  
        @click="signOut">выйти
      </v-btn>  
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
