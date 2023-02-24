import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/news.vue'

const router = createRouter({
	// history: createWebHistory(import.meta.env.BASE_URL),
	history: createWebHistory('/'),
	routes: [
		{
			path: '/',
			name: 'home',
			component: HomeView
		}
	]
})

export default router