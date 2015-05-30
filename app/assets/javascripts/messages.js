$(document).on("page:change page:receive", function() {
  $('.msg-new-submit').hide();
});

$(document).on('focus', '.msg-new-textarea', function() { 
  $('.msg-new-submit').fadeIn(100); 
});

$(document).on('keydown', '.msg-new-textarea', function(e) {
  // Enter was pressed with shift key
  if (e.keyCode == 13 && e.shiftKey) {
    $('.msg-new-submit').click();
    e.preventDefault();
  }
});


