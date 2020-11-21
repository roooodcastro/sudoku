<template>
  <div>
    <h1>Available Sudoku Puzzles</h1>

    <div class="row row-cols-1 row-cols-sm-2 row-cols-lg-3 row-cols-xl-4">
      <div
        v-for="puzzle in puzzles"
        :key="puzzle.id"
        class="col mb-4"
      >
        <div class="card bg-light">
          <router-link
            class="p-4 Index__puzzle-link"
            :to="`/play/${puzzle.id}`"
          >
            <PuzzleThumbnail :puzzle="puzzle" />
          </router-link>

          <div class="card-body">
            <h5>{{ puzzle.name ?? 'Sudoku Puzzle' }}</h5>
            <strong>Author: </strong>{{ puzzle.author ?? 'Anonymous' }}
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import PuzzleThumbnail from '@/components/puzzles/PuzzleThumbnail.vue';
import PuzzleAPI from '@/api/PuzzleAPI.js';

export default {
  components: {
    PuzzleThumbnail,
  },
  data() {
    return {
      puzzles: null,
    };
  },
  mounted() {
    PuzzleAPI.getPuzzles().then((puzzles) => {
      this.puzzles = puzzles;
    });
  },
};
</script>

<style lang="scss" scoped>
.Index__puzzle-link {
  transition: 0.15s padding;
  &:hover {
    padding: 1rem !important;
  }
  &::after{
    background-color: transparent;
    bottom: 0;
    content: "";
    left: 0;
    position: absolute;
    opacity: 0;
    right: 0;
    top: 0;
    transition: 0.15s all;
  }
}

.Index__puzzle-link:hover:after {
  background-color: Gold;
  opacity: 0.15;
}
</style>
