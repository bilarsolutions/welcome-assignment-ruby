<template>
  <div class="home">
    <Chat :messages="messages"/>
  </div>
</template>

<script>
// @ is an alias to /src
import Chat from "@/components/Chat.vue";

export default {
  name: "Home",
  components: {
    Chat,
  },
};
</script>
