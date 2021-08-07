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
import ActionCable from "actioncable";
const cable = ActionCable.createConsumer("ws://localhost:3001/cable");

export default {
  filters: {
    formatDate(date) {
      return dateFns.format(date, "MM/DD [at] h:mm a");
    }
  },
  created() {
    this.$store.dispatch("getMessages");

    cable.subscriptions.create({
        channel: "MessagesChannel"
      }, {
        connected: function() {
          console.log("connected");
        },
        disconnected: function() {
          console.log("disconnected");
        },
        received: (data) => {
          this.messages.unshift(data.message);
        }
    })

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

