<template>
<div
  class="Cell"
  :class="cssClasses"
  :tabindex="cell.index"
  @click="setFocus(cell.index)"
  @keydown.left="moveFocus('left')"
  @keydown.right="moveFocus('right')"
  @keydown.up="moveFocus('up')"
  @keydown.down="moveFocus('down')"
  @keydown="setCellValue"
>
  <div
    v-if="cell.value"
    class="Cell__value"
  >
    {{ cell.value }}
  </div>
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
        'font-weight-light': !this.cell.locked,
        'text-primary': !this.cell.locked,
      };
    },
  },

  mounted() {
    if (this.isFocused) {
      console.log('focused');
      this.$el.focus();
    }
  },

  methods: {
    ...mapActions([
      'setFocus',
      'moveFocus',
      'setCellValue',
    ]),
  },
};
</script>

<style lang="scss" scoped>
.Cell {
  border: 1px solid black;
  border-left: none;
  cursor: default;
  height: 7.5vmin;
  width: 7.5vmin;
  user-select: none;

  &:focus {
    background-color: Gold;
    outline: none;
  }

  &:nth-child(9n - 8) {
    border-left: 1px solid black;
  }

  &:nth-child(n + 10) {
    border-top: none;
  }

  &:nth-child(3n - 2) {
    border-left: 3px solid black;
  }

  &:nth-child(9n) {
    border-right: 3px solid black;
  }

  &:nth-child(n):nth-child(-n+9) {
    border-top: 3px solid black;
  }

  &:nth-child(n+19):nth-child(-n+27) {
    border-bottom: 3px solid black;
  }

  &:nth-child(n+46):nth-child(-n+54) {
    border-bottom: 3px solid black;
  }

  &:nth-child(n+73):nth-child(-n+81) {
    border-bottom: 3px solid black;
  }
}

.Cell__value {
  font-size: 5vmin;
  line-height: 7.5vmin;
  text-align: center;
}
</style>
