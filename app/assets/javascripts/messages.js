MB.messages = {
  new: function(css_class, text) {
    var section_main = $("section.main_content"),
        new_div = '<div class="' + css_class + '">' + text + '</div>',
        all_classes = ["warning", "notice", "error", "alert"],
        i;

    for(i=0; i<all_classes.length; ++i) {
      section_main.children("div." + all_classes[i]).remove();
    }
    section_main.prepend(new_div);
  }
};