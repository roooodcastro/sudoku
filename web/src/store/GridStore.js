import Grid from '@/lib/models/Grid.js';
import PuzzleAPI from '@/api/PuzzleAPI.js';

export const SET_FOCUS = 'SET_FOCUS';
export const SET_PUZZLE = 'SET_PUZZLE';
export const SET_VALUE = 'SET_VALUE';
export const CLEAR_VALUE = 'CLEAR_VALUE';
export const TOGGLE_PENCIL_MARK = 'TOGGLE_PENCIL_MARK';

export default {
  namespaced: true,
  state: {
    focusedCellIndex: null,
    gridSize: null,
    grid: new Grid(0, []),
    name: '',
    author: '',
  },
  getters: {
    isCellFocused: (state) => (cellIndex) => {
      return cellIndex === state.focusedCellIndex;
    },
    getFocusedCell: (state) => {
      return state.grid.cellAt(state.focusedCellIndex);
    },
    getFocusedCellRow: (state) => {
      return Math.floor(state.focusedCellIndex / state.grid.gridSize);
    },
    getFocusedCellCol: (state) => {
      return Math.floor(state.focusedCellIndex % state.grid.gridSize);
    },
    getCells: (state) => {
      return state.grid.cells;
    },
    getGrid: (state) => {
      return state.grid;
    },
  },
  mutations: {
    [SET_FOCUS](state, { cellIndex }) {
      state.focusedCellIndex = cellIndex;
    },
    [SET_PUZZLE](state, { puzzle }) {
      state.grid = Grid.fromGridString(puzzle.definition);
      state.name = puzzle.name;
      state.author = puzzle.author;
    },
    [SET_VALUE](state, { value }) {
      if (parseInt(value) <= state.grid.gridSize) {
        state.grid.cellAt(state.focusedCellIndex).value = parseInt(value);
      }
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
      const gridSize = getters.getGrid.gridSize;
      let newRow = getters.getFocusedCellRow;
      let newCol = getters.getFocusedCellCol;
      switch (direction) {
        case 'left':
          newCol = (newCol + (gridSize - 1)) % gridSize;
          break;
        case 'right':
          newCol = (newCol + 1) % gridSize;
          break;
        case 'up':
          newRow = (newRow + (gridSize - 1)) % gridSize;
          break;
        case 'down':
          newRow = (newRow + 1) % gridSize;
      }

      const cellIndex = (newRow * gridSize) + newCol;

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
    },

    togglePencilMark({ commit, getters }, event) {
      if (event.keyCode >= 49 && event.keyCode <= 57) {
        commit({
          type: TOGGLE_PENCIL_MARK,
          value: parseInt(String.fromCharCode(event.keyCode)),
        });
      }
    },

    loadGridFromAPI({ commit }, { puzzleId }) {
      PuzzleAPI.getPuzzle(puzzleId)
        .then((puzzle) => {
          commit({
            type: SET_PUZZLE,
            puzzle,
          });
        })
        .catch((error) => alert(error));
    },
  },
};
