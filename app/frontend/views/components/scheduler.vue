<template>
<div class=" ">
<!--   <VueDatePicker v-model="date" dark locale="ru"  time-picker-inline disable-month-year-select  uid="demo"    class="vdp" auto-apply :min-date="new Date()"  :format="format"  model-type="timestamp"/>
  <div class="d-flex align-center mx-2">
    <p v-if="date"> {{ date }}</p>
  </div> -->
<!--     <v-switch
    density ="compact"
      v-model="people"
      color="primary"
      label="John"
      value="John"
      hide-details
    ></v-switch>
    <v-switch
      density ="compact"
      v-model="people"
      color="primary"
      label="Jacob"
      value="Jacob"
      hide-details
    ></v-switch> -->
    <!-- {{sortedDate}} -->
    <!-- <br><br> -->
<!-- {{date}} -->
<!-- {{  }}ss -->
  <div  v-for="(item, index) in sortedDate" :key="index"  >
    <div class="d-flex mt-2 mb-1 mx-2 pa-0 align-center" >

      <VueDatePicker
      :disabled="item.switch_value == true ? true : false"
        dark locale="ru"
        placeholder="Выбор даты" 
        @closed="alertFn"
        @focus="fillCurrentTime(item.name, item.schedule)"
       
        :format="customDateFormat"
        @update:modelValue="(newValue) => updateDate(item.name, newValue)"
      
        class="vdp d-flex my-1" 
        auto-apply :min-date="new Date()"  
        :modelValue="item.schedule" 
        model-type="timestamp"/>

        <div v-if="item.schedule != null && store.tsignedIn == true" class="d-flex flex-row align-center interface">
<!--           <div style="width: 96px;">
         </div> -->
 
          <v-text-field 
            placeholder="Введите текст..."
            class="my-0 mx-2"
            v-model="item.text"
            :disabled="item.switch_value == true ? true : false"
            density="compact"
            variant="solo-inverted" 
            hide-details 
            clearable>
          </v-text-field>
          <div class="d-flex"  >
            <v-checkbox 

              density="mini"
              class="mx-2 d-flex mr-10"
              v-if="item.pub == false" 
              v-model="item.pub" 
              label="в паблик">
            </v-checkbox> 
          </div>
          <div class="mx-2"  v-if="item.pub == true">
            <div> длительность рейда</div>
            <v-rating
              class="mr-2"
              density="compact"
              half-increments
              hover
              :length="5"
              :size="22"
              :model-value="item.duratiom"
              active-color="primary"
            />
          </div>
          <div v-if="item.pub == true">

            <v-slider
              label="слоты"
              style="width: 260px;"
              density="mini"
              v-if="item.pub == true"
              v-model="item.vacan"
              :max="70"
              :step="1"
              class="my-2 mr-7"
              hide-details
            >
            <template v-slot:append>
<!--               <v-text-field
                placeholder="слоты"
                v-model="item.vacan"
                density="compact"
                style="width: 80px"
                type="number"
                variant="outlined"
                hide-details
              ></v-text-field> -->
                <div
                      style="width: 22px;"
            class="text-h5 font-weight-light d-flex justify-end"
            v-text="item.vacan"
          ></div>
            </template>
            </v-slider> 
          </div>


          <div>
              <!-- :loading="loadingItems[item.id]"  -->
            <v-switch
              density="compact"
              class=" pl-2 pt-0 swi"
              color="primary"
              v-model="item.switch_value"
              :label="item.switch_value ? 'вкл' : 'выкл'" 
              @update:modelValue="handleSwitchChange(item.name, item.schedule, item.text, item.switch_value, item.vacan, item.duration, item.pub)"
              hide-details>
            </v-switch> 
          </div>

          <div class="ma-2 animated-time">
          <!-- 3ч:59м -->
          {{ formattedTime(item.remainingSeconds, item.schedule)}}
          </div>
          <v-btn
            v-if="item.switch_value == false"
            @click="removeById(item.name)"
            icon="$delete" variant="plain"
            max-height="27"
            max-width="27"
           color="warning">
          </v-btn>   
        </div>
      </div>
 
    </div>
  <div class="d-flex py-1">
    <div :style="[ true ?  {cursor: 'not-allowed'}:{}]">
      <v-btn 
      :disabled="isButtonDisabled" 
      @click="addItem" 
      class="px-2">
        добавить
      </v-btn>    
    </div>
 
    <div v-if="store.tsignedIn" id="telegram-login-button" class="d-flex align-center mx-2" ></div>  
    <!-- <div>{{store.tgramlog}}</div> -->
  </div>

</div> 

</template>
<script setup lang="ts">
import { gsap } from "gsap";
import { useLogStore } from '../../store.js'
const store = useLogStore()
const plain: any = inject('plain')

const secured: any = inject('secured')
const switcher = ref(true)
const people = ref(['John'])
const telegr = ref('');
const customDateFormat = 'dd/MM/yyyy, HH:mm';
import { v4 as uuidv4 } from 'uuid';
const date = ref([{ name: 0, schedule: null, switch_value: false, text: null, remainingSeconds: null, vacan: null, duration: null, pub: false }])



// const loadingItems = reactive({});

const handleSwitchChange = (name, vremya, text, switch_value, vacan, duration, pub) => {
  // loadingItems[id] = true;
  console.log("---------0000---------") 
  console.log(name)
  console.log(vremya) 

  console.log("---------0000---------") 
  if (switch_value == true){
    secured
      .post("/shed", {uniqid: name, milliseconds: vremya, text: text, switch_value: switch_value, vacan: vacan, duration: duration, pub: pub })
      .then((response: { data: any }) => {
      console.log(response.data)
    });  
  }else{
    secured
      .post("/shed/off", {name: name, switch_value: switch_value, vacan, duration, pub: pub })
      .then((response: { data: any }) => {
      console.log(response.data)
    });  
  }
}
const sortedDate = computed(() => {
  return date.value.slice().sort((a, b) => new Date(a.date) - new Date(b.date));
});
const power = ref(78)
const fillCurrentTime = (ind, vremya) => {
  // const now = new Date().getTime();
  // date.value[0].date = now;  // Устанавливаем текущее время

  if (vremya != null) {
    console.log("vremya esty"+date) 
console.log(date.value.length ) 
  }else{
    
    const now = new Date().getTime();
    const val = ref(uuidv4());

    // if (date.length > 0) {
    //   const item = date.value.find(d => d.name === ind);
    //   // item.date = vremya;
    // }else{
      const item = date.value.find(d => d.name === ind);
      item.schedule = now
      item.name = val
    // }
  }
}

// Функция для удаления элемента по id
function removeById(id) {
  date.value = date.value.filter(item => item.name !== id);
  console.log(`Элемент с id ${id} удалён.`);
}
const addItem = () => {
  const nowdate = Date.now() 
  const val = ref(uuidv4());
  console.log(val.value) 

  date.value.push({ name: val, schedule: nowdate, switch_value: false, text: null, remainingSeconds: null, vacan: null, duration: null, pub: false}); 
  // date.value.push('')
};

const updateDate = (index, newValue) => {
// date.value[index] = newValue;
// date.value[index] = date.value[index].value;

  console.log(date.value) 
  // const item = date.value[index];
  const item = date.value.find(d => d.name === index);
  item.schedule = newValue
  // const nomer =  date.value.length
  const now = Math.floor(Date.now()); // Текущее время в секундах
  // console.log(date.length)
  if (item) {
    item.schedule = newValue;
    item.remainingSeconds = item.schedule - now;
    // item.id = nomer
  }

};
const vaba = ref("выкл"); 
const alertFn = () => {
} 

const format = (date) => {
  const day = date.getDate();
  const month = date.getMonth() + 1;
  const year = date.getFullYear();
  const hours = date.getHours();
  const minutes = date.getMinutes();
  return `${day}.${month}.${year} ${hours}:${minutes}`;
}

const isButtonDisabled = computed(() => {
  return !store.tsignedIn || date.value.some(d => d.name === 0);
});

async function telega() {
  if(store.tsignedIn){
// Инициализация Telegram Login Widget при загрузке компонента
    const script = document.createElement('script');
    script.src = 'https://telegram.org/js/telegram-widget.js?22';
    script.setAttribute('data-telegram-login', 'farmspot_bot');
    script.setAttribute('data-size', 'medium');
    script.setAttribute('data-radius', '10');
    script.setAttribute('data-request-access', 'write');
    script.setAttribute('data-onauth', 'onTelegramAuth(user)');
    script.async = true;
    document.getElementById('telegram-login-button').appendChild(script);
  }
}

// const remainingTimes = ref(date.value.map(item => item.date - Math.floor(Date.now() / 1000))); // Массив оставшегося времени

// Функция для форматирования времени
const formattedTime = (remSeconds, timestamp ) => {

  // Если timestamp больше, чем 10^10, это миллисекунды — делим на 1000
  // if (timestamp > 1e10) {
  //   timestamp = Math.floor(timestamp / 1000); // Приводим к секундам
  // }

  // console.log(typeof timestamp)

  if ( isNaN(timestamp)) {
    timestamp = Math.floor(Date.parse(timestamp) / 1000); // Приводим к секундам
  // console.log(timestamp)
  } else if (timestamp > 1e10) {
    timestamp = Math.floor(timestamp / 1000); // Приводим к секундам, если это миллисекунды
  }
  // console.log(timestamp)
  const now = Math.floor(Date.now() / 1000); // Текущее время в секундах
  // console.log(now)
  const remainingSeconds = timestamp - now; // Разница между текущим временем и timestamp

  console.log(remainingSeconds)
  if (remainingSeconds <= 0) {
    return ' ';
  }

  const days = Math.floor(remainingSeconds / 86400); // 86400 секунд в дне
  const hours = Math.floor((remainingSeconds % 86400) / 3600);
  const minutes = Math.floor((remainingSeconds % 3600) / 60);
  if (days > 0) {
    return `${days}д:${hours}ч:${minutes}м`; // Если остались дни
  }
  return `${hours}ч:${minutes}м`;
};

// Перезапуск анимации при добавлении новых элементов
// watch(date, (newVal, oldVal) => {
//   console.log(newVal)
//   if (newVal.length > oldVal.length) {
//     nextTick(() => {
//       const addedItemIndex = newVal.length - 1;
//       startTimerForItem(addedItemIndex, newVal[addedItemIndex]);
//     });
//   }
// });
// const remainingSeconds = ref([]);

const updateRemainingTimes = ( ) => {
  const now = Math.floor(Date.now()); // Текущее время в секундах
  // date.remainingSeconds.value = sortedDate.value.map(item => item.date - now);

  date.value.forEach(item => {
     // console.log(item)

    if ( isNaN(item.schedule)) {
      item.schedule = Math.floor(Date.parse(item.schedule)  ); // Приводим к секундам
      // console.log(item.schedule)
    } else if (item.schedule > 1e10) {
      // console.log(item.schedule)
      item.schedule = Math.floor(item.schedule  ); // Приводим к секундам, если это миллисекунды
      // console.log(item.schedule)
    }
    if (item.schedule && item.remainingSeconds > 0 ){
      item.remainingSeconds = item.schedule - now;
      console.log(item.remainingSeconds)   
    }

  });

};
 
async function shedGet() {
  const apiUrl = '/shed'; // Customize the API URL here
  try {
        const response = await secured.get(apiUrl)
        // store.setinv(response.data)
        console.log(response.data)
  if (response.data !=0){
    date.value = response.data; 
  }


  } catch (error) {
    await handleAxiosError(error, apiUrl, retryCount.value, retryDelay.value);
  }
}
async function handleAxiosError(error, url, retryCount, retryDelay) {
  if (retryCount > 0) {
    await new Promise(resolve => setTimeout(resolve, retryDelay));
    return menuget(url, retryCount - 1, retryDelay);
  } else {
    throw error;
  }
} 
// Запуск интервала для обновления времени 


// Остановка интервала при демонтировании компонента
onBeforeUnmount(() => {
  clearInterval(timerInterval);
});

onUpdated(() => {
  console.log("onUpdated")
  // telega()
})
 

let timerInterval = null;
onMounted(() => {
  console.log("onMounted")
  updateRemainingTimes();
  timerInterval = setInterval(updateRemainingTimes, 10000); // Обновляем каждые 10 сек
  shedGet()
  window.onTelegramAuth = (user) => {
    telegr.value = "Авторизация прошла успешно!";
    console.log(telegr.value)
    console.log(user)
    const sendteleg = () => {
        secured
        .post('/users/addtelegram',{id: store.tgramlog.id, username: store.tgramlog.username })
        .then(response => {
          console.log(response)
        })
      .catch(error => console.log(error))
    };
    store.setgramlog(user)
    sendteleg();
  };
  if (store.tsignedIn){
    telega()  
  }

})
 

</script>

<style scoped  lang="scss" >
.animated-time {
  font-size: 14px;
  font-weight: bold;
  display: inline-block;
}
.swi{

}
.interface{
width: 100%;

}
.progresbar{

}
.vdp{
  width: 250px;
}
</style>