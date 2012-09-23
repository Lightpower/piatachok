$(function() {

  $(".datepicker").datepicker({ dateFormat: "dd.mm.yy" });

  $("select#select_period").change(function() {
    switch($(this).val()) {
      case "day":
        $("input#day[type=text]").attr("disabled", true);
        $("input#day[type=text]").val($.datepicker.formatDate('dd.mm.yy', new Date()));
        break;
      case "month":
        $("input#day[type=text]").attr("disabled", true);
        var now = new Date();
        $("input#day[type=text]").val($.datepicker.formatDate('dd.mm.yy', new Date(now.getFullYear(), now.getMonth(), 1)));
        break;
      case "year":
        $("input#day[type=text]").attr("disabled", true);
        var now = new Date();
        $("input#day[type=text]").val($.datepicker.formatDate('dd.mm.yy', new Date(now.getFullYear(), 0, 1)));
        break;
      case "other":
        $("input#day[type=text]").removeAttr("disabled");
        break;
    }
  });



});
