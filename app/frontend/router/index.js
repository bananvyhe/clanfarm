import { createRouter, createWebHistory } from 'vue-router'
import welc from '../views/components/welcomepage.vue'
import login_area from '../views/components/login_area2.vue'
const router = createRouter({
	// history: createWebHistory(import.meta.env.BASE_URL),
	// history: createWebHistory('/'),
		history: createWebHistory(),
	routes: [
		{
			path: '/',
			name: 'welc',
			component: welc
		},
		{
			path: '/lobby',
			name: 'lobby',
			component: login_area
		}
	]
})

export default router