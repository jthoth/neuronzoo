<template>
  <v-app>
    <v-app-bar app>
      <v-toolbar-title class="headline text-uppercase">
        <span>CC7515</span>
        <span class="font-weight-light"> GPU COMPUTING</span>
      </v-toolbar-title>
    </v-app-bar>

    <v-content>
      <Neurons/>
    </v-content>
  </v-app>
</template>

<script>
import Neurons from './components/Neurons';

export default {
  name: 'App',
  components: {
    Neurons,
  },
  data: () => ({
    //
  }),
};
</script>
