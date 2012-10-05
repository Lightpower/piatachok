MB.invites = {
  create: function(link_tag) {

  },

  accept: function(link_tag) {
    var action_url = $(link_tag).data("url");

    $.ajax({
      type: 'PUT',
      url: action_url,
      dataType: 'json'
    }).done(function(message){

      if(message.status == 200) {
        $(link_tag).parents("div.invite").first.remove();
      }
    });

  },

  reject: function(link_tag) {
    var action_url = $(link_tag).data("url");

    $.ajax({
      type: 'PUT',
      url: action_url,
      dataType: 'json'
    }).done(function(message){

      if(message.status == 200) {
        $(link_tag).parents("div.invite").first.remove();
      }
    });
  }

};

$(function() {
  $("a.accept_invite").click(function(e) {
    MB.invites.accept(this);
    e.preventDefault();
  });

  $("a.reject_invite").click(function(e) {
    MB.invites.accept(this);
    e.preventDefault();
  });

});