<template>
  <div class="chat">
    <table class="table table-striped">
      <transition-group tag="tbody" name="fade">
        <tr v-for="message in messages" :key="message.id">
          <td class="date">{{ message.created_at | formatDate }}</td>
          <td class="name">{{ message.name }}</td>
          <td class="body">{{ message.body }}</td>
        </tr>
      </transition-group>
    </table>
  </div>
</template>

<script>
import dateFns from "date-fns";

export default {
  filters: {
    formatDate(date) {
      return dateFns.format(date, "MM/DD [at] h:mm a");
    }
  },
  created() {
    this.$store.dispatch("getMessages");
  },
  computed: {
    messages() {
      return this.$store.state.messages;
    }
  }
};
</script>

<style scoped>
  .date { color: #bbb; }
  .name { font-weight: bold; }
</style>

