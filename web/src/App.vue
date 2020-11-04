<template>
  <teleport to="head">
    <title>{{ getPageTitle }}</title>
    <meta name="description" content="{{ getMetaDescription }}" />
  </teleport>

  <Header />

  <div class="container-fluid App__container">
    <router-view/>
  </div>

  <Footer />
</template>

<script>
import Header from '@/views/layouts/Header.vue';
import Footer from '@/views/layouts/Footer.vue';

import { mapGetters } from 'vuex';

export default {
  name: 'App',
  components: {
    Footer,
    Header,
  },
  computed: {
    ...mapGetters([
      'getPageTitle',
      'getMetaDescription',
    ]),
  },
};
</script>

<style lang="scss">
@import '~bootstrap';

html {
  position: relative;
  min-height: 100%;
}

body {
  margin-bottom: 4rem;
}

#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
}

.App__container {
  padding-top: 3.5rem;
}
</style>
