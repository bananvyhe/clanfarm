import { createRouter, createWebHistory } from 'vue-router'
import hat from '../views/components/hat.vue'
import login_area from '../views/components/login_area.vue'
const router = createRouter({
	// history: createWebHistory(import.meta.env.BASE_URL),
	// history: createWebHistory('/'),
		history: createWebHistory(),
	routes: [
		{
			path: '/',
			name: 'hat',
			component: hat
		},
		{
			path: '/lobby',
			name: 'lobby',
			component: login_area
		}
	]
})

export default router