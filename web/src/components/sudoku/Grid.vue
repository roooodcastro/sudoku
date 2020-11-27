<template>
  <div class="Grid__container">
    <div
      class="Grid"
      :class="gridCssClass"
      @keydown="setFocus()"
    >
      <Cell
        v-for="(cell) in cells"
        :key="cell.index"
        :ref="el => { cellsDivs[cell.index] = el }"
        :cell="cell"
        :grid-size="grid.gridSize"
      />

      <span
        v-for="division in numDivisions"
        :key="division"
        class="Grid__vertical-division"
        :style="{ left: `calc(${division * (100 / grid.subGridSize)}% - 1.5px)` }"
      />

      <span
        v-for="division in numDivisions"
        :key="division"
        class="Grid__horizontal-division"
        :style="{ top: `calc(${division * (100 / grid.subGridSize)}% - 1.5px)` }"
      />
    </div>
  </div>
</template>

<script>
import Cell from '@/components/sudoku/Cell.vue';

import { ref, onBeforeUpdate } from 'vue';
import { createNamespacedHelpers } from 'vuex';

const { mapGetters } = createNamespacedHelpers('grid');

export default {
  name: 'Grid',
  components: {
    Cell,
  },

  setup() {
    const cellsDivs = ref([]);

    // make sure to reset the refs before each update
    onBeforeUpdate(() => {
      cellsDivs.value = [];
    });

    return {
      cellsDivs,
    };
  },

  computed: {
    ...mapGetters({
      focusedCell: 'getFocusedCell',
      cells: 'getCells',
      grid: 'getGrid',
    }),
    gridCssClass() {
      return {
        'Grid--two-by-two': this.grid.gridSize === 4,
        'Grid--three-by-three': this.grid.gridSize === 9,
      };
    },
    numDivisions() {
      return this.grid.subGridSize - 1;
    },
  },

  methods: {
    setFocus() {
      this.cellsDivs[this.focusedCell.index].$el.focus();
    },
  },
};
</script>

<style lang="scss" scoped>
.Grid__container {
  display: inline-block;
  width: 100%;
}

.Grid {
  border: 3px solid black;
  border-bottom: 2px solid black;
  border-right: 2px solid black;
  display: grid;
  justify-items: stretch;
  position: relative;
}

.Grid--two-by-two {
  grid-template-columns: repeat(4, auto);
}

.Grid--three-by-three {
  grid-template-columns: repeat(9, auto);
}

.Grid__vertical-division {
  background-color: black;
  bottom: 0;
  position: absolute;
  top: 0;
  width: 3px;
}
.Grid__horizontal-division {
  background-color: black;
  left: 0;
  position: absolute;
  right: 0;
  height: 3px;
}
</style>
