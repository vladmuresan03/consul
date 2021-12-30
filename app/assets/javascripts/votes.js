(function() {
  "use strict";
  App.Votes = {
    hoverize: function(votes) {
      $(document).on({
        "mouseenter focus": function() {
          $("div.participation-not-allowed", this).show();
        },
        mouseleave: function() {
          $("div.participation-not-allowed", this).hide();
        }
      }, votes);
    },
    initialize: function() {
      App.Votes.hoverize("div.votes");
      App.Votes.hoverize("div.supports");
    }
  };
}).call(this);
