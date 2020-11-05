import Grid from '@/lib/models/Grid.js';
import Cell from '@/lib/models/Cell.js';

export const SET_FOCUS = 'SET_FOCUS';
export const SET_CELLS = 'SET_CELLS';
export const SET_VALUE = 'SET_VALUE';
export const CLEAR_VALUE = 'CLEAR_VALUE';
export const TOGGLE_PENCIL_MARK = 'TOGGLE_PENCIL_MARK';

export const VALID = '530070000600195000098000060800060003400803001700020006060000280000419005000080079';

export default {
  namespaced: true,
  state: {
    focusedCellIndex: null,
    gridSize: null,
    grid: new Grid(0, []),
  },
  getters: {
    isCellFocused: (state) => (cellIndex) => {
      return cellIndex === state.focusedCellIndex;
    },
    getFocusedCell: (state) => {
      return state.grid.cellAt(state.focusedCellIndex);
    },
    getFocusedCellRow: (state) => {
      return Math.floor(state.focusedCellIndex / 9);
    },
    getFocusedCellCol: (state) => {
      return Math.floor(state.focusedCellIndex % 9);
    },
    getCells: (state) => {
      return state.grid.cells;
    },
  },
  mutations: {
    [SET_FOCUS](state, { cellIndex }) {
      console.log('FocusedCellIndex: ' + cellIndex);
      state.focusedCellIndex = cellIndex;
    },
    [SET_CELLS](state, { grid }) {
      state.grid = grid;
    },
    [SET_VALUE](state, { value }) {
      state.grid.cellAt(state.focusedCellIndex).value = parseInt(value);
    },
    [CLEAR_VALUE](state) {
      state.grid.cellAt(state.focusedCellIndex).clearCell();
    },
    [TOGGLE_PENCIL_MARK](state, { value }) {
      state.grid.cellAt(state.focusedCellIndex).togglePencilMark(value);
    },
  },
  actions: {
    setFocus({ commit }, cellIndex) {
      commit({
        type: SET_FOCUS,
        cellIndex,
      });
    },

    moveFocus({ commit, getters }, direction) {
      let newRow = getters.getFocusedCellRow;
      let newCol = getters.getFocusedCellCol;
      switch (direction) {
        case 'left':
          newCol = (newCol + 8) % 9;
          break;
        case 'right':
          newCol = (newCol + 1) % 9;
          break;
        case 'up':
          newRow = (newRow + 8) % 9;
          break;
        case 'down':
          newRow = (newRow + 1) % 9;
      }

      const cellIndex = (newRow * 9) + newCol;

      commit({
        type: SET_FOCUS,
        cellIndex,
      });
    },

    setCellValue({ commit, getters }, event) {
      if (getters.getFocusedCell.locked) {
        return;
      }

      if (event.keyCode >= 48 && event.keyCode <= 57) {
        commit({
          type: SET_VALUE,
          value: event.key,
        });
      }
      if (event.key === 'Delete' || event.key === 'Backspace') {
        commit({ type: CLEAR_VALUE });
      }
      if (event.key === 'a') {
        console.log(this.grid.blocks);
      }
    },

    togglePencilMark({ commit, getters }, event) {
      if (event.keyCode >= 49 && event.keyCode <= 57) {
        commit({
          type: TOGGLE_PENCIL_MARK,
          value: parseInt(String.fromCharCode(event.keyCode)),
        });
      }
    },

    loadInitialGrid({ commit }, { gridSize, gridString }) {
      let grid = null;

      if (gridString) {
        grid = Grid.fromGridString(gridString);
      } else {
        grid = Grid.generateRandomGrid(gridSize);
      }

      commit({
        type: SET_CELLS,
        grid,
      });
    },
  },
};
