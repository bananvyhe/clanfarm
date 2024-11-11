<template>
  <div class="schedule">
    <v-item-group multiple>
      <v-container>
        <div v-for="n in hours" :key="n" cols="1" class="my-2">
          <v-item v-slot="{ isSelected, toggle }">
            <v-card
              :color="isSelected ? 'primary' : ''"
              class="d-flex align-center selectable-item"
              height="40"
              width="100"
              dark
              @mousedown="startSelection(toggle, n)"
              @mousemove="onMouseMove(toggle, isSelected, n)"
              @mouseup="endSelection"
            >
              <v-scroll-y-transition>
                <div class="flex-grow-1 text-center">
                  {{ formatHour(n) }}
                </div>
              </v-scroll-y-transition>
            </v-card>
          </v-item>
        </div>
      </v-container>
    </v-item-group>

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
            @contextmenu.prevent="handleRightClick"
          >
            {{ item.name }}
          </div>
        </template>
      </v-hover>
      <button @click="addItem(hour)">Add</button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from "vue";

interface ScheduleItem {
  name: string;
}

const isSelecting = ref(false);

const hours = Array.from({ length: 24 }, (_, i) => i);
const schedule = ref<{ [key: number]: ScheduleItem[] }>(
  Object.fromEntries(hours.map((hour) => [hour, []]))
);

const startSelection = (toggle, hour) => {
  isSelecting.value = true;
  toggle();
  updateSchedule(hour);
};

const onMouseMove = (toggle, isSelected, hour) => {
  if (isSelecting.value && !isSelected) {
    toggle();
    updateSchedule(hour);
  }
};

const endSelection = () => {
  isSelecting.value = false;
};

const updateSchedule = (hour) => {
  if (schedule.value[hour].length === 0) {
    schedule.value[hour].push({ name: "Scheduled Item" });
  } else {
    schedule.value[hour].splice(0, 1);
  }
};

const onGlobalMouseUp = () => {
  isSelecting.value = false;
};

onMounted(() => {
  window.addEventListener("mouseup", onGlobalMouseUp);
});

onUnmounted(() => {
  window.removeEventListener("mouseup", onGlobalMouseUp);
});

const addItem = (hour) => {
  const name = prompt("Enter event name:");
  if (name) {
    schedule.value[hour].push({ name });
  }
};

const removeItem = (hour, index) => {
  schedule.value[hour].splice(index, 1);
};

const formatHour = (hour) => {
  return hour < 10 ? `0${hour}:00` : `${hour}:00`;
};
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
