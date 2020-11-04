import { createRouter, createWebHistory } from 'vue-router';
import Home from '../views/Home.vue';

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home,
    meta: {
      title: 'Rubydoku',
    },
  },
  {
    path: '/about',
    name: 'About',
    component: () => import(/* webpackChunkName: "about" */ '../views/About.vue'),
    meta: {
      title: 'About - Rubydoku',
    },
  },
  {
    path: '/play',
    name: 'Play',
    component: () => import(/* webpackChunkName: "play" */ '../views/Play.vue'),
    meta: {
      title: 'Play - Rubydoku',
    },
  },
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
});

export default router;
