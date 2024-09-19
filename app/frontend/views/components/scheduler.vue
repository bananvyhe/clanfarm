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
<!-- {{date}} -->
<!-- {{  }}ss -->
  <div v-for="(item, index) in date" :key="index"  >
    <div class="d-flex ma-2 pa-0 align-center">

      <VueDatePicker
        dark locale="ru"  
        placeholder="Выбор даты" 
        @closed="alertFn"
      @focus="fillCurrentTime(index, item.date)"
        ref="datepicker"
        :format="customDateFormat"
   
        uid="demo"
        class="vdp d-flex" 
        auto-apply :min-date="new Date()"  
        :modelValue="item.date" 
        @update:modelValue="newValue => updateDate(index, newValue)"
        model-type="timestamp"/>

        <v-switch
           class=" pl-3 "
          color="primary"
     
          v-model="item.switchValue"
          :label="`${item.switchValue}`"
          false-value="выкл"
          true-value="вкл"
          hide-details>
        </v-switch>  
      </div>



 
    </div>
  <div class="d-flex">
    <div :style="[ true ?  {cursor: 'not-allowed'}:{}]">
      <v-btn 
      :disabled="isButtonDisabled" 
      @click="addItem" 
      class="px-2">
        добавить
      </v-btn>    
    </div>
 
    <div v-if="store.tsignedIn" id="telegram-login-button" class="d-flex align-center 

mx-2" ></div>  
    <!-- <div>{{store.tgramlog}}</div> -->
  </div>

    <div></div>


</div> 

</template>
<script setup lang="ts">
  import { useLogStore } from '../../store.js'
  const store = useLogStore()
  const plain: any = inject('plain')

  const secured: any = inject('secured')
  const switcher = ref(true)
  const people = ref(['John'])
  const telegr = ref('');
  const customDateFormat = 'dd/MM/yyyy, HH:mm';

  const date = ref([{ id: '0', date: null, switchValue: "выкл" }])

  const fillCurrentTime = (ind, vremya) => {
    // const now = new Date().getTime();
    // date.value[0].date = now;  // Устанавливаем текущее время
 
    if (vremya != null) {
      console.log("vremya esty"+date) 

    }else{
      const now = new Date().getTime();
 
       date.value[ind].date = now
       
      console.log(date.value[0].date ) 
      // console.log("vremya null"+date) 
      // console.log(item) 
    }
  };


// const addItem = () => {
//   date.value.push('666');
// };
// const date = ref(new Date().getTime());
  const addItem = () => {
  // date.value.push(new Date().getTime().toString());

    const val = date.value.length;
    console.log(val) 


    date.value.push({ id: val, date: null, switchValue: "выкл" }); 
    // date.value.push('')
  };
 
  const updateDate = (index, newValue) => {
    // date.value[index] = newValue;
    // date.value[index] = date.value[index].value;

    console.log(date.value) 
    const item = date.value[index];
    // const nomer =  date.value.length

    console.log(date.length)
    if (item) {
      item.date = newValue;
      // item.id = nomer
    }



    // selectedDate.value = newValue;
    if (newValue && !selectedDate) {
      selectedTime.value = {
        hours: newValue.getHours(),
        minutes: newValue.getMinutes(),
      };

      console.log("ththth")
    }

    // console.log(selectedTime.value) 
  };


const vaba = ref("выкл"); 
const selectedDate = ref(null);  // Выбранная дата
// const lastSelectedDate = ref(null);  // Последняя сохраненная дата
const selectedTime = ref({hours: null, minutes: null});  // Отдельно храним выбранное время
const alertFn = () => {
  // alert('Menu closed');
  // if (!selectedDate.value) {
  //   selectedDate.value = lastSelectedDate.value || new Date();  // Используем последнее выбранное время или текущее время
  //    const newDate = new Date(selectedDate.value);
  //   newDate.setHours(selectedTime.value.hours);
  //   newDate.setMinutes(selectedTime.value.minutes);
  //   selectedDate.value = newDate;
  // } else {
  //   lastSelectedDate.value = selectedDate.value;  // Обновляем последнюю выбранную дату
  // }
  // lastSelectedDate.value = selectedDate.value;
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
    console.log(store.tsignedIn)
    return !store.tsignedIn;
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
onUpdated(() => {
  console.log("onUpdated")
  telega()
})
onMounted(() => {
console.log("onMounted")
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
 telega()
})
// if(!ls.get('gramlog')){

// }
</script>

<style scoped  lang="scss" >
.vdp{
  width: 200px;
}
</style>