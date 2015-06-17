$(document).on("page:change page:receive", function() {
  $('.msg-reply-submit').hide();
});

$(document).on('focus', '.msg-reply-textarea', function() { 
  $('.msg-reply-submit').fadeIn(150); 
});

$(document).on('keydown', '.uTextarea', function(e) {
  // Enter was pressed with shift key
  if (e.keyCode == 13 && e.shiftKey) {
    $('.msg-new-submit').click();
    e.preventDefault();
  }
});


