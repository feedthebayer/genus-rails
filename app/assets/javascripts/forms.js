$(function() {
  $(".msg-new-textarea").keydown(function(e){
    // Enter was pressed with shift key
    if (e.keyCode == 13 && e.shiftKey)
    {
      $('.msg-new-submit').click();
      e.preventDefault();
    }
  });

  //  the following simple make the textbox "Auto-Expand" as it is typed in
  $(document).on('keyup', 'textarea', function(e) {
    //Don't fire on shift-enter
    if (!(e.keyCode == 13 && e.shiftKey)) {
      //  this if statement checks to see if backspace or delete was pressed, 
      //  if so, it resets the height of the box so it can be resized properly
      if (e.which == 8 || e.which == 46) {
        $(this).height(parseFloat($(this).css("min-height")) != 0 ? 
          parseFloat($(this).css("min-height")) : parseFloat($(this).css("font-size")));
      }
      while($(this).outerHeight() < this.scrollHeight + parseFloat($(this).css("borderTopWidth")) + parseFloat($(this).css("borderBottomWidth"))) {
          $(this).height($(this).height()+1);
      };
    }
  });
});
