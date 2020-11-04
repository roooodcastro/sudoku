<template>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
  <router-link
    class="navbar-brand"
    to="/"
  >
    Rubydoku
  </router-link>

  <BNavbarToggle
    target="navbarContent"
  />

  <div class="collapse navbar-collapse" id="navbarContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <router-link
          class="nav-link"
          active-class="active"
          to="/"
        >
          Home
        </router-link>
      </li>
      <li class="nav-item">
        <router-link
          class="nav-link"
          active-class="active"
          to="/play"
        >
          Play
        </router-link>
      </li>
      <li class="nav-item">
        <router-link
          class="nav-link"
          active-class="active"
          to="/about"
        >
          About
        </router-link>
      </li>
    </ul>
  </div>
</nav>
</template>

<script>
import BNavbarToggle from '@/components/bootstrap/BNavbarToggle.vue';

export default {
  components: { BNavbarToggle },
};
</script>
