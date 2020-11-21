import { createRouter, createWebHistory } from 'vue-router';
import Home from '../views/Home.vue';
import About from '../views/About.vue';
import PuzzlesIndex from '../views/puzzles/Index.vue';

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
    path: '/puzzles/',
    name: 'Sudoku Puzzles',
    component: PuzzlesIndex,
    meta: {
      title: 'Sudoku Puzzles - Rubydoku',
    },
  },
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
});

export default router;
