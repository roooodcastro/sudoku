<template>
  <div class="play">
    <h1>Play a Sudoku game</h1>

    <Grid />
  </div>
</template>

<script>
import Grid from '@/components/sudoku/Grid.vue';

export default {
  components: {
    Grid,
  },
};
</script>
