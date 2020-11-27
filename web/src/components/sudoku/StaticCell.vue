<template>
  <div class="StaticCell">
    <svg viewBox="0 0 100 100">
      <text
        v-if="cellValue"
        x="50%"
        y="50%"
      >
        {{ cellValue }}
      </text>
    </svg>
  </div>
</template>

<script>
export default {
  name: 'StaticCell',

  props: {
    cellValue: {
      type: Number,
      required: true,
    },
  },
};
</script>

<style lang="scss" scoped>
.StaticCell {
  background-color: white;
  border: 1px solid black;
  position: relative;
  margin-top: -1px;
  margin-left: -1px;
  user-select: none;

  svg {
    dominant-baseline: central;
    text-anchor: middle;
    width: 100%;

    text {
      font: 75px sans-serif;
    }
  }
}
</style>
