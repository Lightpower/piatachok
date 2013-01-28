$(function() {


  $("input.ccb_field").click(function() {
    var div = $("div.ccb_div").first(),
        input = $("input.ccb_field"),
        x = input.position().left + 3,
        y = input.position().top + input.height() + 5,
        width = input.width(),
        styleLine = "position: absolute; top: " + y + "px; left: " + x + "px; width: " + width + "px; z-index: 1; display: ";
    if(div.attr("style").indexOf("inline-block") == -1) {
      input.attr("value", "Кликните для закрытия");
      div.attr("style", styleLine + "inline-block;");
    } else {
      input.attr("value", "<Выберите категории>");
      div.attr("style", styleLine + "none;");
    }
  });

  $("input.ccb_check_box").change(function() {
    var id = $(this).data("id"),
        columns = $("[data-category_id=" + id + "]");
    if($(this).attr("checked") == "checked") {
      columns.removeClass("hidden");
    } else {
      columns.addClass("hidden");
    }

  });



});
