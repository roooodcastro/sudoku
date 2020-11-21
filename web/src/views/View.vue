<template>
  <div>
    <h1>View a Sudoku game</h1>

    <StaticGrid class="View__grid" />
  </div>
</template>

<script>
import StaticGrid from '@/components/sudoku/StaticGrid.vue';
import { createNamespacedHelpers } from 'vuex';

const { mapGetters, mapActions } = createNamespacedHelpers('grid');

export default {
  components: {
    StaticGrid,
  },
  computed: mapGetters({
    grid: 'getGrid',
  }),
  mounted() {
    const puzzleId = this.$route.params.puzzleId;
    this.loadGridFromAPI({ puzzleId });
  },
  methods: mapActions([
    'loadGridFromAPI',
  ]),
};
</script>

<style lang="scss" scoped>
.View__grid {
  height: 50vh;
  width: 50vh;
}
</style>
