MB.invites = {
  create: function(link_tag) {
    var action_url = $(link_tag).data("url"),
      input_object = $(link_tag).parent().children("input"),
      field_name = input_object.attr("id"),
      user_data = input_object.val(),
      data_string = '{ "invite": { "' + field_name + '": "' + user_data + '"} }',
      invite_block;

    data_string = jQuery.parseJSON(data_string);

    $.ajax({
      type: 'POST',
      url: action_url,
      dataType: 'json',
      data: data_string
    }).done(function(message){

        if(message.status == 201) {
          if(field_name == "family_name") {
            invite_block = $("div#i_want_to_family");
          } else if(field_name == "user_data"){
            invite_block = $("div#invited_to_family")
          } else {
            throw Exception("Invalid field: " + field_name);
          }
          invite_block.children("span.no_invites").remove();
          invite_block.append(message.result);
          input_object.text("");

        }
      });

  },

  // both of "accept" and "reject"
  // action_url contains link to access or reject action
  process: function(link_tag) {
    var action_url = $(link_tag).data("url"),
        invite_block = $(link_tag).parents("div.block_half");

    $.ajax({
      type: 'PUT',
      url: action_url,
      dataType: 'json'
    }).done(function(message){

      if((message.status == 200) || (message.status == 404)) {
        $(link_tag).parents("div.invite").remove();
      }
      if(invite_block.children("div.invite").size() == 0) {
        invite_block.append('<span class="no_invites">Нет приглашений</span>');
      }
    });

  },

};

$(function() {
  $("a#invite_user").live("click", function(e) {
    MB.invites.create(this);
    e.preventDefault();
  });

  $("a#invite_to_family").live("click", function(e) {
    MB.invites.create(this);
    e.preventDefault();
  });

  $("a.accept_invite").live("click", function(e) {
    MB.invites.process(this);
    e.preventDefault();
  });

  $("a.reject_invite").live("click", function(e) {
    MB.invites.process(this);
    e.preventDefault();
  });

});