import Vue from "vue";
import Vuex from "vuex";

import api from "@/api";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    messages: []
  },
  mutations: {
    setMessages(state, messages) {
      state.messages = messages;
    },
  },
  actions: {
    getMessages({ commit }) {
      api.getMessages().then(response => {
        commit("setMessages", response.data);
      });
    },
  }
});
