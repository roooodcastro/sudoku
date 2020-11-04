import { createStore } from 'vuex';

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
  },
});
