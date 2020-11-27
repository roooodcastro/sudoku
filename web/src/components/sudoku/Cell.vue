<template>
  <div
    class="Cell"
    :class="cssClasses"
    :tabindex="cell.index"
    @click="setFocus(cell.index)"
    @keydown.exact.left="moveFocus('left')"
    @keydown.exact.right="moveFocus('right')"
    @keydown.exact.up="moveFocus('up')"
    @keydown.exact.down="moveFocus('down')"
    @keydown.exact="setCellValue"
    @keyup.shift="togglePencilMark"
  >
    <svg
      viewBox="0 0 100 100"
    >
      <text
        v-if="cell.value"
        x="50%"
        y="50%"
        class="Cell__svg-text-value"
      >
        {{ cell.value }}
      </text>

      <text
        v-else
        v-for="pencilMark in cell.pencilMarks"
        :key="pencilMark"
        class="Cell__svg-text-pencil-mark"
        :class="pencilMarksCssClass"
        :x="pencilMarkPosX(pencilMark)"
        :y="pencilMarkPosY(pencilMark)"
      >
        {{ pencilMark }}
      </text>
    </svg>
  </div>
</template>

<script>
import { createNamespacedHelpers } from 'vuex';

const { mapActions, mapGetters } = createNamespacedHelpers('grid');

export default {
  name: 'Cell',

  props: {
    cell: {
      type: Object,
      required: true,
    },
    gridSize: {
      type: Number,
      required: true,
    },
  },

  computed: {
    ...mapGetters([
      'isCellFocused',
    ]),
    isFocused() {
      return this.isCellFocused(this.cell.index);
    },
    cssClasses() {
      return {
        'Cell--focused': this.isFocused,
        'Cell--editable': !this.cell.locked,
      };
    },
    pencilMarksCssClass() {
      return {
        'Cell__pencil-marks--two-by-two': this.gridSize === 4,
        'Cell__pencil-marks--three-by-three': this.gridSize === 9,
      };
    },
  },

  mounted() {
    if (this.isFocused) {
      this.$el.focus();
    }
  },

  methods: {
    ...mapActions([
      'setFocus',
      'moveFocus',
      'setCellValue',
      'togglePencilMark',
    ]),

    pencilMarkPosX(pencilMark) {
      const pencilMarkIndex = pencilMark - 1;
      const subGridSize = Math.sqrt(this.gridSize);
      const usableArea = 60;
      const startPadding = (100 - usableArea) / 2;
      const posValue = startPadding + (pencilMarkIndex % subGridSize) * (usableArea / (subGridSize - 1));
      return `${posValue}%`;
    },

    pencilMarkPosY(pencilMark) {
      const pencilMarkIndex = pencilMark - 1;
      const subGridSize = Math.sqrt(this.gridSize);
      const usableArea = 60;
      const startPadding = (100 - usableArea) / 2;
      const posValue = startPadding + Math.floor(pencilMarkIndex / subGridSize) * (usableArea / (subGridSize - 1));
      return `${posValue}%`;
    },
  },
};
</script>

<style lang="scss" scoped>
@import '@/style/bootstrap_variables';

.Cell {
  background-color: white;
  border: 1px solid black;
  position: relative;
  margin-top: -1px;
  margin-left: -1px;
  user-select: none;
  cursor: default;

  svg {
    dominant-baseline: central;
    text-anchor: middle;
    width: 100%;
  }

  &:focus {
    background-color: Gold;
    outline: none;
  }
}

.Cell__svg-text-value {
  font: 75px sans-serif;
}

.Cell__svg-text-pencil-mark {
  fill: $gray-600;
  font: 25px sans-serif;
  font-weight: lighter;
}

.Cell.Cell--editable .Cell__svg-text-value {
  fill: theme-color('primary');
  font-weight: lighter;
}

.Cell__pencil-marks--two-by-two {
  grid-template-columns: repeat(2, auto);
}

.Cell__pencil-marks--three-by-three {
  grid-template-columns: repeat(3, auto);
}
</style>
