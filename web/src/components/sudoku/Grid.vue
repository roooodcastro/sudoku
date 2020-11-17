<template>
  <div class="Grid__container">
    <div
      class="Grid"
      @keydown="setFocus()"
    >
      <Cell
        v-for="(cell) in cells"
        :key="cell.index"
        :ref="el => { cellsDivs[cell.index] = el }"
        :cell="cell"
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
    }),
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
}

.Grid {
  display: grid;
  grid-template-columns: auto auto auto auto auto auto auto auto auto;
  justify-items: stretch;
}
</style>
