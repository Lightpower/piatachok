MB.money_operations = {
  delete: function(link_tag) {
    var parent_row = $(link_tag).parents("tr").first(),
        action_url = $(link_tag).parents("td").first().data("show_delete_url");

    $.ajax({
      type: 'DELETE',
      url: action_url,
      dataType: 'json'
      //success: function(xhr) {
    }).done(function(message){

      if(message.status == 200) {
          $(parent_row).remove();
      }
    });

  }
};

$(function() {
  $("a.delete_operation").click(function(e) {
    MB.money_operations.delete(this);
    e.preventDefault();
  });

});
