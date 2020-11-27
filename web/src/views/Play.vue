<template>
  <div class="Play">
    <h1>Play a Sudoku game</h1>

    <div class="row h-100">
      <div class="col-12 col-md-8 h-100 d-flex align-items-center justify-content-center">
        <Grid class="Play__grid" />
      </div>

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

const { mapGetters, mapActions } = createNamespacedHelpers('grid');

export default {
  components: {
    Grid,
  },
  computed: {
    ...mapGetters({
      grid: 'getGrid',
    }),
  },
  mounted() {
    const puzzleId = this.$route.params.puzzleId;
    this.loadGridFromAPI({ puzzleId });
  },
  methods: {
    ...mapActions([
      'loadGridFromAPI',
    ]),

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

<style lang="scss">

.App__container {
  height: 100%;
}

.Play {
  display: flex;
  flex-direction: column;
  height: 100%;
  position: relative;
}

.Play__grid {
  width: Min(60vh, 80vw) !important;
}
</style>
