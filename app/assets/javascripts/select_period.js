$(function() {

  $(".datepicker").datepicker({ dateFormat: "dd.mm.yy" });

  $("select#select_period").change(function() {
    var now = new Date();
    switch($(this).val()) {
      case "day":
        $("input.datepicker").attr("disabled", true);
        $("input.datepicker").val($.datepicker.formatDate('dd.mm.yy', new Date()));
        $("input#day2").val($.datepicker.formatDate('dd.mm.yy', new Date()));
        break;
      case "month":
        $("input.datepicker").attr("disabled", true);
        $("input.datepicker").val($.datepicker.formatDate('dd.mm.yy', new Date(now.getFullYear(), now.getMonth(), 1)));
        $("input#day2").val($.datepicker.formatDate('dd.mm.yy', new Date()));
        break;
      case "year":
        $("input.datepicker").attr("disabled", true);
        $("input.datepicker").val($.datepicker.formatDate('dd.mm.yy', new Date(now.getFullYear(), 0, 1)));
        $("input#day2").val($.datepicker.formatDate('dd.mm.yy', new Date()));
        break;
      case "other":
        $("input.datepicker").removeAttr("disabled");
        break;
    }
  });



});
