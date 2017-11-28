// app/assets/javascripts/channels/desks.js

//= require cable
//= require_self
//= require_tree .

this.App = {};

App.cable = ActionCable.createConsumer();

App.messages = App.cable.subscriptions.create('DesksChannel', {
  received: function(data) {
      // Get desk state button
      var target = $("#" + data.element_id)[0];

      if(!target)
          return;

      // Remove any pre-existing occupied/not_occupied classes before setting new class
      target.classList.remove('btn-outline-success');
      target.classList.remove('btn-outline-danger');

      // Change button based on whether desk is occupied
      target.classList.add("btn-outline-" + data.element_style);
      target.innerText = data.element_text;
  }
});
