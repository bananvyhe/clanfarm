<template>
  <div class="d-flex "> 
 
    <div v-if="store.tsignedIn == true" class="d-flex align-center">
      <v-btn
        color="primary"  
        @click="signOut">выйти
      </v-btn>    
      <div  class="d-flex flex-column align-self-start ">
        <div class="interface px-1 d-flex align-self-end ">{{lvl}}</div>
        <div class="interface px-1 d-flex justify-end" style="color: red;" v-if="karma > 0">
<!--           <div class="karma mx-1" v-bind:style="{backgroundImage: 'url('+ karmaimg}"> 
          </div> -->
          карма:
          {{karma}}
        </div>        
      </div>   

      <div class="d-flex flex-column bars">
 
        <v-progress-linear :height="6" class="mb-1" :model-value="userhp" color="success" ></v-progress-linear>
        <v-progress-linear :height="2" class="mb-1" :model-value="exp" color="secondary"  >
         
        </v-progress-linear>
        <div class="interface " style="font-size: 0.8em"  >{{ (exp) }}%</div>
        <div class="d-flex flex-row-reverse ">
          <div v-for="(item, index) in cp" class="cp ml-1 " v-bind:style="{backgroundImage: 'url('+ getImageUrl(index)}"></div>
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
const karmaimg = new URL("../images/karma.png", import.meta.url).href;
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
  const lvl = ref()
  const exp = ref()
//вычисление уровня
onMounted(() => {
  nextTick(() => {
    const levelInfo = calculateLevel(store.texpirience);

    if (levelInfo) {
      const level = levelInfo[0];
      const progress = levelInfo[1];
      lvl.value = level
      exp.value = progress.toFixed(2)

      // console.log("Player Experience:", playerExperience);
      console.log("Player Level:", level);
      console.log("Level Progress:", progress.toFixed(2) + "%");
    } else {
      console.log("Experience exceeds maximum level");
    }
  })
})
 
  function calculateLevel(exp) {
    const levelData = [
      [68, 1],
      [369, 2],
      [1168, 3],
      [2884, 4],
      [6038, 5],
      [11287, 6],
      [19423, 7],
      [31378, 8],
      [48229, 9],
      [71202, 10],
      [101677, 11],
      [141193, 12],
      [191454, 13],
      [254330, 14],
      [331867, 15],
      [426288, 16],
      [540000, 17],
      [675596, 18],
      [835862, 19],
      [920357, 20],
      [1015431, 21],
      [1123336, 22],
      [1246808, 23],
      [1389235, 24],
      [1554904, 25],
      [1749413, 26],
      [1980499, 27],
      [2260321, 28],
      [2634751, 29],
      [2844287, 30],
      [3093068, 31],
      [3389496, 32],
      [3744042, 33],
      [3744042, 33]
    ];

    for (let i = 0; i < levelData.length; i++) {
      if (exp <= levelData[i][0]) {
        return [i + 1, (exp - levelData[i - 1][0]) / (levelData[i][0] - levelData[i - 1][0]) * 100];
      }
    }

    return null; // Experience exceeds maximum level
  }
 
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
.bars {
  width: 120px;
}
.karma {
  height: 19px;
  width: 20px;

}
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
