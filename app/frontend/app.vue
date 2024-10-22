<template>
  <div :class="{ hit: store.thitanim }">

		<v-layout >
			<v-app-bar density="compact" class="topmenu py-0">
        <v-container  class="d-flex align-center py-0 my-0 px-2" >
          <!-- {{store.tctsrf}} -->
          <router-link to="/"> 
            <div class=" wel "  >
                <h3 class=" pr-1">
                  {{message}} 
                  <!-- <v-btn @click="hello">hello</v-btn> -->
                </h3>
              <div class=" subs" >
              <span class=" pr-1 text-body-2 mmod d-flex float-right"> {{ tl }}</span> 
              <span class="text-caption my-0 subt">
                <!-- Yandex ai translator API  -->
              </span>
              </div>
            </div>
          </router-link> 

          <v-spacer></v-spacer>
          <userbar></userbar>
        </v-container>
			</v-app-bar>
		 <v-main >
        <v-container class="pt-0 cont px-0"  >   
          <!-- {{store.tsignedIn}} -->
          <logina v-if="store.tsignedIn"></logina>
          <hat v-else></hat>
          <scheduler class=" "></scheduler>
          <router-view></router-view>
<!-- <notifications /> -->
<notifications position="bottom left" classes="my-notification" >
<!--     <template #body="props">
    <div class="my-notification">
      <p class="title">
        {{ props.item.title }}
      </p>
      <button class="close" @click="close">
        <i class="fa fa-fw fa-close"></i>
      </button>
      <div v-html="props.item.text"/>
    </div>
  </template> -->
</notifications>          
        </v-container>
      </v-main>
		</v-layout>
  </div>
</template>
<script setup lang="ts">

// import { createConsumer } from "@rails/actioncable"
// createConsumer('https://ws.localhost:3000/cable')
// import { createConsumer } from "@rails/actioncable";

// const consumer =  createConsumer("http://localhost:3000/cable");
// const messages = ref([]);
// const subscription = consumer.subscriptions.create({ channel: 'room_channel' }, {
//   connected() {
//     console.log('Connected to the channel.');
//   },
//   disconnected() {
//     console.log('Disconnected from the channel.');
//   },
//   received(data) {
//     console.log('Received data from the channel:', data);
//     messages.value.push(data.message);
//   },
// });
const message = ref("Напоминалка")
const tl = ref("telegram-bot")

import hat from './views/components/hat.vue' 
import logina from './views/components/login_area.vue' 
import scheduler from './views/components/scheduler.vue'

import { useRouter, useRoute } from 'vue-router'
const router = useRouter()
const route = useRoute()    
import { useLogStore } from './store.js'  
const store = useLogStore()
// import hat from './views/components/hat.vue' 

import userbar from './views/components/userbar.vue'
import { gsap } from "gsap";
import { ref, computed, watch, reactive, onMounted, onBeforeMount, toRefs } from 'vue'
import { useScroll } from '@vueuse/core'
import { debounce } from 'lodash'
const { x, y, isScrolling, arrivedState, directions } = useScroll(document)
const { left: toLeft, right: toRight, top: toTop, bottom: toBottom } = toRefs(directions) 


const plain: any = inject('plain')
const secured: any = inject('secured')

// import { createConsumer } from "@rails/actioncable";
// createConsumer('https://ws.example.com/cable')

// Use a function to dynamically generate the URL
// const consumer = createConsumer(getWebSocketURL)

// function getWebSocketURL() {
//   return `http://localhost:3000/cable?token=${store.tctsrf}`
// }
// consumer.subscriptions.create({ channel: "RoomChannel"},{
//     received(data) {
//     console.log(data)
//   },
// })

// const consumer =  createConsumer("http://localhost:3000/cable");

// const subscription = consumer.subscriptions.create({ channel: 'RoomChannel'  }, {
//   connected() {
//     console.log('Connected to the channel.');
//   },
//   disconnected() {
//     console.log('Disconnected from the channel.');
//   },
//   received(data) {
//     console.log('Received data from the channel:', data);
//     // messages.value.push(data.message);
//   },
// }); 
 

function hello () {
  plain
    .post('/hello', {data: "hj" })
    // .then(response => signinSuccessful(response))
    // .catch(error => signinFailed(error))
    .then((response: { data: any }) => {
      // console.log(response.data.message)  
      // signinSuccessful(response)
   
    })
    .catch(error => {
      notify({ title: "Ошибка авторизации", type: 'error', text: error.response.data.message});
      // console.log(error.response.data.message)          
    })
}


// import { useTheme } from "vuetify";
// const theme = useTheme();
//  theme.global.name.value = "customDarkTheme";
 
onMounted(() => {
 console.log(status)
})

const m1 = gsap.timeline();



let isFirstUpdate = true
const showmenutop = reactive({ status: true});

// const debouncedFunc = debounce(() => {
//   m1.to(".topmenu",{
//     duration: 0.5,
//     y: 0,
//     ease: "elastic.in",
//   });
//   showmenutop.status = true;
//   console.log("scroll top");
// }, 500);

watch(() => toTop.value, 
	(newVal, oldVal) =>{
		// console.log(oldVal)
		// console.log(newVal)
		if (isFirstUpdate) {
      isFirstUpdate = false
    } else {
    	if (newVal == true){
			  m1.to(".topmenu",{
			    duration: 0.5,
			    y: 0,
			    ease: "elastic.in",
			  });    		
    	}
    	// debouncedFunc();			 
    }
  },
	{deep: true}
)
watch(() => store.tsignedIn, 
  (newVal, oldVal) =>{
    // console.log(oldVal)
    // console.log(newVal)
    if (newVal == false)
      router.push({ name: "welc" });
 
    },
  {deep: true}
)


// const debouncedFuncbot = debounce(() => {
//   m1.to(".topmenu",{
// 	  duration: 0.5,
// 	  y: -48,
// 	  ease: "elastic.in",
// 	})
//  showmenutop.status = false
//   console.log("scroll botom");
// }, 500);

watch(() => toBottom.value, 
	(newVal, oldVal) =>{
		// console.log(oldVal)
		// console.log(newVal)
 		if (isFirstUpdate) {
      isFirstUpdate = false
    } else {
    	if (newVal == true){
			  m1.to(".topmenu",{
				  duration: 0.5,
				  y: -48,
				  ease: "elastic.in",
				})
    	}
    	// debouncedFuncbot();
    }
	}, 
	{deep: true}
)
</script>

<style scoped  lang="scss" >
 @import './src/global.scss';
.hit{
  background-color: red;
}
.mmo {
  line-height: 1em;
}
.subs{
  color: #65627d;
  }
  .wel{
    color: $welgrey1;
    /*color: #9694ab;*/
    line-height: 1em;
    /*margin-top: -8px;*/
    white-space: nowrap;
  }
  .subt{
    
    line-height: 1em;
  }
  .cont{
    position: relative;
  }
</style>