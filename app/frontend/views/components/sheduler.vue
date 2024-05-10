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

  <div v-for="(item, index) in date" :key="index"  >
    <div class="d-flex ma-2">
      <VueDatePicker 
  
      dark locale="ru"  
      time-picker-inline 
      disable-month-year-select  
      uid="demo"
      class="vdp " 
      auto-apply :min-date="new Date()"  
      :format="format"  
 
        :modelValue="item" 
        @update:modelValue="newValue => updateDate(index, newValue)"
      model-type="timestamp"/>
 
      <div class="d-flex align-center mx-2">{{item}}</div>
    </div>
  </div>
  <div class="d-flex ">
    <v-btn @click="addItem" class="px-2">
      добавить
    </v-btn>
    <div id="telegram-login-button" class="d-flex align-center mx-2" > </div>  
    <div>{{store.tgramlog}}</div>
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

// import { useLogStore } from './store.js'  
// const store = useLogStore()

// import { ref, computed, watch, reactive, onMounted, onBeforeMount, toRefs } from 'vue'

// const plain: any = inject('plain')
// const secured: any = inject('secured')
  const date = ref([''])
// const addItem = () => {
//   date.value.push('666');
// };
// const date = ref(new Date().getTime());
  const addItem = () => {
  // date.value.push(new Date().getTime().toString());
  date.value.push('')
};
 
  const updateDate = (index, newValue) => {
    date.value[index] = newValue;
    // date.value[index] = date.value[index].value;

    console.log(date.value) 
  };
 
  const format = (date) => {
  const day = date.getDate();
  const month = date.getMonth() + 1;
  const year = date.getFullYear();
  const hours = date.getHours();
  const minutes = date.getMinutes();
  return `${day}.${month}.${year} ${hours}:${minutes}`;
}
onMounted(() => {
  window.onTelegramAuth = (user) => {
    telegr.value = "Авторизация прошла успешно!";
    console.log(telegr.value)
    console.log(user)
    const sendteleg = () => {
        secured
        .post('/users/addtelegram',{id: store.tgramlog.id})
        .then(response => {
          console.log(response)
 
        })
      .catch(error => console.log(error))
     
    };
    store.setgramlog(user)
    sendteleg();
 

  };
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
})
// if(!ls.get('gramlog')){

// }
</script>

<style scoped  lang="scss" >
.vdp{
  width: 200px;
}
</style>