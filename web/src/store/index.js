import { createStore } from 'vuex';
import GridStore from '@/store/GridStore';

export default createStore({
  state: {
    meta: {
      title: 'Rubydoku',
      description: 'Play Sudoku',
    },
  },
  getters: {
    getPageTitle: (state) => {
      return state.meta.title;
    },
    getMetaDescription: (state) => {
      return state.meta.description;
    },
  },
  mutations: {
  },
  actions: {
  },
  modules: {
    grid: GridStore,
  },
});
