<template>
  <div class="d-flex " :class="{ deathfilther: store.tdead }"> 
 <!-- {{userhp}}  -->
<!--   {{store.tctsrf}}
 {{store.tsignedIn}} -->
 
 <!-- {{route.path}} -->
    <div v-if="store.tsignedIn == false" class="d-flex"> 

    <div id="telegram-login-button"> </div>
    <!-- <p v-if="message">{{ message }}</p> -->


      <!-- <signup></signup> -->
      <!-- <signin></signin> -->
                <div class="loa px-2 align-self-center" >{{store.tloa}}</div>
          <div class="skull align-self-center"></div>   
    </div>
    <div v-if="store.tsignedIn == true" class="d-flex align-center">

      <div v-if="store.tdead">
        <v-btn
          color="secondary"  
          @click="ressurect"> воскреснуть
        </v-btn>    
      </div>

      <v-btn
        color="primary" 
        size="x-small" 
        @click="signOut">выйти
      </v-btn> 


      <div v-if="route.path === '/lobby'" class="d-flex">
        <div  class="d-flex flex-column align-self-start ">
          <div class="interface px-1 d-flex align-self-end ">{{store.tlvl}}</div>
          <div class="interface px-1 d-flex justify-end" style="color: red;" v-if="karma > 0">
   
   
            <!-- <div class="karma mx-1" v-bind:style="{backgroundImage: 'url('+ karmaimg}"> 
            </div> -->
            карма:
            {{karma}}
          </div>        
        </div>   

        <div class="d-flex flex-column bars align-self-start" >
          <v-progress-linear :height="10" class="mb-1 mt-1" :model-value="userhp" color="success" >
            <div class="health play">{{store.thealth}}</div> 
          </v-progress-linear>
          <v-progress-linear :height="2" class="mb-1" :model-value="store.tprogress" color="secondary"  >
          </v-progress-linear>
          <div class="d-flex ">
            <div class="interface " style="font-size: 0.8em" v-html="reducedNumber+' ' + '%'"> </div>
 
            <div class="d-flex flex-row-reverse " style="position: absolute; right: 0; bottom: 0;">
              <div v-for="(item, index) in store.tcpoints" class="cp ml-1 " v-bind:style="{backgroundImage: 'url('+ getImageUrl(index)}">
              </div>
              <div v-if="store.tavcpoints > store.tcpoints" v-for="(item, index) in store.tavcpoints-store.tcpoints" class="cp ml-1 " v-bind:style="{backgroundImage: 'url('+ overcpimg}">
              </div>
            </div>  
          </div>
        </div>
        <div class="useraction d-flex  flex-column ">  
          <inventory> </inventory>
          <div class="d-flex" >
            <div class="loa px-2 align-self-center" >{{store.tloa}}</div>
            <div class="skull align-self-center"></div>        
          </div>
          <div v-if="store.tsignedIn == true">
            <div class=" bag"></div>
          </div>
        </div> 
      </div>


      <div v-else>
        <v-btn><router-link to="/lobby">лобби</router-link></v-btn>
      </div>

    </div>  
 

  
  </div>
</template>

<script setup lang="ts">
const message = ref('');


import { useRouter, useRoute } from 'vue-router'
const router = useRouter()
const route = useRoute()
 
 
const retryCount = ref(3);
const retryDelay = ref(1000);

import { ref, computed, inject, watch, onMounted, mounted   } from 'vue';
const karma = ref(0)
const userhp = ref()
 
const cp = ref(5)
const avcp = ref(0)
const coverp = ref(2)

const reducedNumber = computed(() => {
  // var rep = store.tprogress
  var rep = store.tprogress.toString()
  const regex = /\.\d+/g;
  const modifiedNumber = rep.replace(regex, ".<span style=\"font-size: smaller;\">$&</span>");
  return modifiedNumber;
});
const ressurect = () => {
    secured
    .post('/users/ressurect')
    .then(response => {
      console.log(response.data.health)
      if (response.data.health > 0){
        store.setdead( false)
        store.sethealth(response.data.health)
      }
    })
  .catch(error => console.log(error))
 
};
const getImageUrl = (number) => {
  // console.log(number)
  if ((number+1) <= store.tavcpoints) {
    return greenimg;
  } else {
    return cpimg;
  }
};
const karmaimg = new URL("../images/karma.png", import.meta.url).href;
const greenimg = new URL("../images/cp/green.png", import.meta.url).href;
const overcpimg = new URL("../images/cp/overcp.png", import.meta.url).href;
const cpimg = new URL("../images/cp/cp.png", import.meta.url).href;

import ls from 'localstorage-slim'; 

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
window.onTelegramAuth = (user) => {
  message.value = "Авторизация прошла успешно!";
  console.log(message.value)
  console.log(user)
  // sendUserDataToServer(user);
};
  // Инициализация Telegram Login Widget при загрузке компонента
  const script = document.createElement('script');
  script.src = 'https://telegram.org/js/telegram-widget.js?22';
  script.setAttribute('data-telegram-login', 'farmspot_bot');
  script.setAttribute('data-size', 'large');
  script.setAttribute('data-radius', '10');
  // script.setAttribute('data-auth-url', '/auth/telegram'); // URL для обработки авторизации на вашем сервере
  script.setAttribute('data-request-access', 'write');
  script.setAttribute('data-onauth', 'onTelegramAuth(user)');
  script.async = true;
  document.getElementById('telegram-login-button').appendChild(script);
  if (store.tsignedIn){
    mefetch()
    // console.log(store.tctsrf)
    // secured
    // .get('/me')
    // .then(meResponse => {
    //   console.log(meResponse.data)
    //   store.setCurrentUser(meResponse.data, store.tctsrf)
    //   // this.error = ''
    //   // this.$router.replace('/')

    // })
    // .catch(error => console.log(error)) 
  }
    
  nextTick(() => {
    // console.log(store.tmaxhealth)
    // console.log(store.thealth)
    userhp.value = (store.thealth / store.tmaxhealth)*100
  })
})
async function mefetch() {
  const apiUrl = '/me'; // Customize the API URL here
  try {
    const response = await secured.get(apiUrl)
    store.setCurrentUser(response.data, store.tctsrf)
    console.log(response.data)
  } catch (error) {
    await handleAxiosError(error, apiUrl, retryCount.value, retryDelay.value);
  }
}
async function handleAxiosError(error, url, retryCount, retryDelay) {
  if (retryCount > 0) {
    await new Promise(resolve => setTimeout(resolve, retryDelay));
    return mefetch(url, retryCount - 1, retryDelay);
  } else {
    throw error;
  }
} 
watch(() => store.thealth, ( ) => {
  console.log('store health')
  userhp.value = (store.thealth / store.tmaxhealth)*100
}) 
 
    function signOut(){
      secured
      .delete('/signin')
      .then(response => {
        console.log(store.tsignedIn)
        // store.unsetLoa()
        store.unsetCurrentUser()
        // console.log(store.tsignedIn)
        router.push({ name: "welc" });
        // store.unsetLoa
        // this.$router.replace('/')
      })
      // .catch(error => setError(error, 'Cannot sign out'))
    }
 
 
</script>

<style scoped>
  .deathfilther{
      filter: grayscale(80%);
  }

.bag{
  /*background-color: #dad;*/
  height: 20px;
  width: 62px;
  background-image: url('../images/bag.png');
  background-size: contain;
  background-position: center;
}
.health{
  line-height: 1em;
  font-size: 0.6em;
  color: #222;
 

}
.bars {
  width: 125px;
  position: relative;
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
  /*background-color: #dad;*/
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
