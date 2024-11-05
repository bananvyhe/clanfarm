<template>
  <div class="schedule">
    {{hours}}{{schedule}}
    <div v-for="hour in hours" :key="hour" class="hour-block">

      <div class="hour-label">{{ formatHour(hour) }}</div>

      <div
        class="schedule-item"
        v-for="(item, index) in schedule[hour]"
        :key="index"
        @click="removeItem(hour, index)">
        {{ item.name }}
      </div>

      <button @click="addItem(hour)">Add</button>
    </div>
  </div>
</template>

<script setup lang="ts">
 

// Определение типа для события
interface ScheduleItem {
  name: string;
}

const hours = Array.from({ length: 24 }, (_, i) => i);

// Инициализация schedule с пустыми массивами для каждого часа
const schedule = ref<{ [key]: ScheduleItem[] }>(
  Object.fromEntries(hours.map(hour => [hour, []]))
);

function setItem(hour, index) {

  schedule.value[hour].push({ name });

}

function addItem(hour) {
  const name = prompt("Enter event name:");
  if (name) {
    schedule.value[hour].push({ name });
  }
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
