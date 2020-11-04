<template>
  <button
    class="navbar-toggler"
    type="button"
    data-toggle="collapse"
    aria-expanded="false"
    :data-target="`#${target}`"
    :aria-controls="target"
    :aria-label="label"
  >
    <span class="navbar-toggler-icon"></span>
  </button>
</template>

<script>
export default {
  name: 'BNavbarToggle',
  props: {
    target: {
      type: String,
      required: true,
    },
    label: {
      type: String,
      default: 'Toggle Navigation',
    },
  },
};
</script>
