// app/assets/javascripts/channels/desks.js

//= require cable
//= require_self
//= require_tree .

this.App = {};

App.cable = ActionCable.createConsumer();

App.messages = App.cable.subscriptions.create('DesksChannel', {
  received: function(data) {

      OCCUPIED_CLASS = 'btn-outline-danger';
      NOT_OCCUPIED_CLASS = 'btn-outline-success';

      // Get desk state button
      var target = $("#desk_state_" + data.id)[0];

      if(!target)
          return;

      // Remove any pre-existing occupied/not_occupied classes before setting new class
      if (target.classList.contains(OCCUPIED_CLASS))
          target.classList.remove(OCCUPIED_CLASS);

      if (target.classList.contains(NOT_OCCUPIED_CLASS))
          target.classList.remove(NOT_OCCUPIED_CLASS);

      // Change button based on whether desk is occupied
      if(data.occupied)
      {
          target.classList.add(OCCUPIED_CLASS);
          target.innerText = "Occupied";
      }
      else
      {
          target.classList.add(NOT_OCCUPIED_CLASS);
          target.innerText = "Not Occupied";
      }

  }
});
