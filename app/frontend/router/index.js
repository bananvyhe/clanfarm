import { createRouter, createWebHistory } from 'vue-router'
import hat from '../views/components/hat.vue'

const router = createRouter({
	// history: createWebHistory(import.meta.env.BASE_URL),
	history: createWebHistory('/'),
	routes: [
		{
			path: '/',
			name: 'hat',
			component: hat
		}
	]
})

export default router