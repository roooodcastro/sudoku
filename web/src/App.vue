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
  height: 100%;
  min-height: 100%;
}

body {
  height: 100%;
  margin-bottom: 4rem;
}

#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  height: 100%;
}

.App__container {
  min-height: 100%;
  padding-top: 3.5rem;
  padding-bottom: 4rem;
  margin-bottom: -4rem;
}
</style>
