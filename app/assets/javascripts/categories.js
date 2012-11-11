MB.categories = {};

$(function() {
  $("a#add_spend_category").live("click", function(e) {
    $("form#spend_category_form").attr("action", "/categories");
    $("tr.spend_category_row").removeClass("hidden");
    e.preventDefault();
  });
  $("a.edit_spend_category").live("click", function(e) {
    var id = $(this).parents("tr").data("id"),
      name = $(this).parents("tr").children("td").first().text();
    $("form#spend_category_form").attr("action", "/categories/" + id);
    $("form#spend_category_form").append("<input name='_method' type='hidden' value='put' />");

    //$("form#spend_category_form").attr("method", "put");
    $("input#category_name").val(name);
    $("tr.spend_category_row").removeClass("hidden");
    e.preventDefault();
  });

});