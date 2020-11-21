import { createRouter, createWebHistory } from 'vue-router';
import Home from '../views/Home.vue';
import About from '../views/About.vue';
import View from '../views/View.vue';

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
    component: About,
    meta: {
      title: 'About - Rubydoku',
    },
  },
  {
    path: '/play/:puzzleId',
    name: 'Play',
    component: () => import(/* webpackChunkName: "play" */ '../views/Play.vue'),
    meta: {
      title: 'Play - Rubydoku',
    },
  },
  {
    path: '/view/:puzzleId',
    name: 'View',
    component: View,
    meta: {
      title: 'View Sudoku - Rubydoku',
    },
  },
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
});

export default router;
