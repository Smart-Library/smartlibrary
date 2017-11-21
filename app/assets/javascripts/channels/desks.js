// app/assets/javascripts/channels/desks.js

//= require cable
//= require_self
//= require_tree .

this.App = {};

App.cable = ActionCable.createConsumer();

App.messages = App.cable.subscriptions.create('DesksChannel', {
  received: function(data) {
    $("#desk_state_" + data.id)[0].innerHTML = data.occupied;
  }
});
