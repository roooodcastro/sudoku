<template>
  <StaticGrid :grid="grid" />
</template>

<script>
import StaticGrid from '@/components/sudoku/StaticGrid.vue';
import Grid from '@/lib/models/Grid';

export default {
  components: {
    StaticGrid,
  },
  props: {
    puzzle: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      grid: Grid.fromGridString(this.puzzle.definition),
    };
  },
};
</script>
