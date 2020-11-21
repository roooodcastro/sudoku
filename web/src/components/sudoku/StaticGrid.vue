<template>
  <div class="StaticGrid__container">
    <div
      class="StaticGrid"
      :class="gridCssClass"
    >
      <StaticCell
        v-for="(cell) in cells"
        :key="cell.index"
        :cell-value="cell.value"
      />

      <span
        v-for="division in numDivisions"
        :key="division"
        class="StaticGrid__vertical-division"
        :style="{ left: `calc(${division * (100 / grid.subGridSize)}% - 1.5px)` }"
      />

      <span
        v-for="division in numDivisions"
        :key="division"
        class="StaticGrid__horizontal-division"
        :style="{ top: `calc(${division * (100 / grid.subGridSize)}% - 1.5px)` }"
      />
    </div>
  </div>
</template>

<script>
import StaticCell from '@/components/sudoku/StaticCell.vue';

import { createNamespacedHelpers } from 'vuex';

const { mapGetters } = createNamespacedHelpers('grid');

export default {
  name: 'StaticGrid',
  components: {
    StaticCell,
  },

  computed: {
    ...mapGetters({
      cells: 'getCells',
      grid: 'getGrid',
    }),
    gridCssClass() {
      return {
        'StaticGrid--two-by-two': this.grid.gridSize === 4,
        'StaticGrid--three-by-three': this.grid.gridSize === 9,
      };
    },
    numDivisions() {
      return this.grid.subGridSize - 1;
    },
  },
};
</script>

<style lang="scss" scoped>
.StaticGrid__container {
  display: inline-block;
  width: 100%;
}

.StaticGrid {
  border: 3px solid black;
  border-bottom: 2px solid black;
  border-right: 2px solid black;
  display: grid;
  justify-items: stretch;
  position: relative;
}

.StaticGrid--two-by-two {
  grid-template-columns: repeat(4, auto);
}

.StaticGrid--three-by-three {
  grid-template-columns: repeat(9, auto);
}

.StaticGrid__vertical-division {
  background-color: black;
  bottom: 0;
  position: absolute;
  top: 0;
  width: 3px;
}
.StaticGrid__horizontal-division {
  background-color: black;
  left: 0;
  position: absolute;
  right: 0;
  height: 3px;
}
</style>
