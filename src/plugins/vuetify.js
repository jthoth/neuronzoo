import Vue from 'vue';
import Vuetify from 'vuetify/lib';
import vb from 'vue-babylonjs';

Vue.use(Vuetify);
Vue.use(vb);

export default new Vuetify({
  icons: {
    iconfont: 'mdi',
  },
});
