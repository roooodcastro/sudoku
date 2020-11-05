<template>
  <div class="play">
    <h1>Play a Sudoku game</h1>

    <Grid />

    <div class="row">
      <div class="col">
        <button
          class="btn btn-secondary"
          type="button"
          @click="validateSolution"
        >
          Verify
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import Grid from '@/components/sudoku/Grid.vue';
import { createNamespacedHelpers } from 'vuex';

const { mapGetters } = createNamespacedHelpers('grid');

export default {
  components: {
    Grid,
  },
  computed: {
    ...mapGetters({
      grid: 'getGrid',
    }),
  },
  methods: {
    validateSolution() {
      if (this.grid.hasEmptyCells) {
        alert('Sudoku is not yet completed. Cannot verify.');
      } else if (this.grid.isValid()) {
        alert('All good!');
      } else {
        alert('Your solution is not valid :(');
      }
    },
  },
};
</script>
