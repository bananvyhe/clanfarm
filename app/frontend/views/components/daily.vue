<template>
  <div class="schedule">

  <v-item-group multiple>
    <v-container>
      
        <div
          v-for="n in hours"
          :key="n"
          cols="1"
          class="my-2"
        >
          <v-item v-slot="{ isSelected, toggle }">
            <v-card
              :color="isSelected ? 'primary' : ''"
              class="d-flex align-center selectable-item"
              height="40"
              width="100"
              dark
              @mousedown="startSelection(toggle)"
              @mousemove="onMouseMove(toggle, isSelected)"
              @mouseup="endSelection"
            >
              <v-scroll-y-transition>
                <div
                  class=" flex-grow-1 text-center"
                >
                 {{ formatHour(n) }}
                </div>
              </v-scroll-y-transition>
            </v-card>
          </v-item>
        </div>
       
    </v-container>
  </v-item-group>




    {{hours}}{{schedule}}
    <div v-for="hour in hours" :key="hour" class="hour-block d-flex">
      <v-hover>
        <template v-slot:default="{ isHovering, props }">
      <div class="hour-label">{{ formatHour(hour) }}</div>
        <div
        v-bind="props"
        :color="isHovering ? 'primary' : undefined"
        class="schedule-item"
        v-for="(item, index) in schedule[hour]"
        :key="index"
        @click="removeItem(hour, index)"
        @contextmenu.prevent="handleRightClick">
        {{ item   }}
        </div>
      
        </template>
      </v-hover>

      <button @click="addItem(hour, index)">Add</button>
    </div>
  </div>
</template>

<script setup lang="ts">
const isSelecting = ref(false);

const startSelection = (toggle) => {
  isSelecting.value = true;
  toggle(); // Выделить первый элемент на котором нажата кнопка
};

const onMouseMove = (toggle, isSelected) => {
  if (isSelecting.value && !isSelected) {
    toggle(); // Выделить элемент, если он еще не выбран
  }
};

const endSelection = () => {
  isSelecting.value = false;
};

// Сброс флага при отпускании кнопки за пределами элементов
const onGlobalMouseUp = () => {
  isSelecting.value = false;
};

onMounted(() => {
  window.addEventListener('mouseup', onGlobalMouseUp);
});

onUnmounted(() => {
  window.removeEventListener('mouseup', onGlobalMouseUp);
});



// Определение типа для события
interface ScheduleItem {
  name: string;
}

const hours = Array.from({ length: 24 }, (_, i) => i);
// Инициализация schedule с пустыми массивами для каждого часа
const schedule = ref<{ [key]: ScheduleItem[] }>(
  Object.fromEntries(hours.map(hour => [hour, []]))
);

const handleRightClick = (event) => {
  console.log("Right-click detected", event);
  // Ваш код для обработки клика правой кнопкой
};

function setItem(hour, index) {

  schedule.value[hour].push({ name });

}

function addItem(hour, index) {
  // const name = prompt("Enter event name:");
  if (schedule.value[hour][0] == null) {
  console.log(typeof schedule.value[hour])
  schedule.value[hour].push( true );
  console.log( schedule.value[hour][0])
  }else if(typeof schedule.value[hour] === 'boolean'){
    // schedule.value[hour].push({ tru });
    // console.log('boolean')
  }
  // if (name) {
  //   schedule.value[hour].push({ name });
  // }
}

function removeItem(hour: number, index: number) {
  schedule.value[hour].splice(index, 1);
}

function formatHour(hour: number) {
  return hour < 10 ? `0${hour}:00` : `${hour}:00`;
}
</script>

<style>
.schedule {
  display: flex;
  flex-direction: column;
  max-width: 300px;
  margin: auto;
}
.hour-block {

/*  background-color: #ada;*/
  display: flex;
  align-items: center;
  margin-bottom: 10px;
}
.hour-label {
  width: 50px;
}
.schedule-item {
  background-color: #90caf9;
  margin-left: 10px;
  padding: 5px;
  cursor: pointer;
}
button {
  margin-left: auto;
}
</style>
