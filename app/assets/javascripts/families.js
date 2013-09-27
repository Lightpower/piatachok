MB.families = {
  update: function(link_tag) {
    var action_url = $(link_tag).data("url"),
      input_object = $(link_tag).parent().children("input"),
      field_name = "name",
      user_data = input_object.val(),
      data_string = '{ "family": { "' + field_name + '": "' + user_data + '"} }',
      message_class;

    data_string = jQuery.parseJSON(data_string);

    $.ajax({
      type: 'PUT',
      url: action_url,
      dataType: 'json',
      data: data_string
    }).done(function(message){

        if(message.status == 200) {
          message_class = "notice";
          $("h1#family_name_header").text(user_data);
        }else{ message_class = "error" }

        MB.messages.new(message_class, message.result);
      });

  }
};

$(function() {
  $("a#change_family_name").bind("click", function(e) {
    MB.families.update(this);
    e.preventDefault();
  });

});