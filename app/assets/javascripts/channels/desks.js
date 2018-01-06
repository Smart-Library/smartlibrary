// app/assets/javascripts/channels/desks.js

//= require cable
//= require_self
//= require_tree .

this.App = {};

App.cable = ActionCable.createConsumer();

App.messages = App.cable.subscriptions.create('DesksChannel', {
  received: function(data) {
      // Get desk state button
      var target = $("#desk_state_" + data.desk_info.id)[0];

      if(!target)
          return;

      // Remove any pre-existing occupied/not_occupied classes before setting new class
      target.classList.remove('btn-outline-success');
      target.classList.remove('btn-outline-danger');

      // Change button based on whether desk is occupied
      target.classList.add(data.desk_info.occupied ? 'btn-outline-danger' : 'btn-outline-success');
      target.innerText = data.desk_info.occupied ? 'Occupied' : 'Not Occupied';
  }
});
