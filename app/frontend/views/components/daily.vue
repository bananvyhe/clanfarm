<!-- <template>
  <div>
      <VueSchedule v-model="schedule" />
  </div>
</template>

<script setup lang="ts">
import 'vue-daily-scheduler/dist/vue-schedule.min.css'
import VueSchedule from 'vue-daily-scheduler'
const schedule = ref({0: [], 1: [], 2: [], 3: [], 4: [], 5: [], 6: [] });
</script>

<style scoped>



</style> -->
<template>
  <div class="schedule">
    <div v-for="hour in hours" :key="hour" class="hour-block">
      <div class="hour-label">{{ formatHour(hour) }}</div>
      <div
        class="schedule-item"
        v-for="(item, index) in schedule.value[hour] || []"
        :key="index"
        @click="removeItem(hour, index)"
      >
        {{ item.name }}
      </div>
      <button @click="addItem(hour)">Add</button>
    </div>
  </div>
</template>

<script setup lang="ts">
 

 
    const hours = Array.from({ length: 24 }, (_, i) => i);
    const schedule = ref<{ [key: number]: ScheduleItem[] }>({});

function addItem(hour: number) {
  const name = prompt("Enter event name:");
  if (name) {
    if (!schedule.value[hour]) {
      schedule.value[hour] = [];
    }
    schedule.value[hour].push({ name });
  }
}

    function removeItem(hour, index) {
      if (schedule.value[hour]) {
        schedule.value[hour].splice(index, 1);
        if (schedule.value[hour].length === 0) {
          delete schedule.value[hour];
        }
      }
    }

    function formatHour(hour) {
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

