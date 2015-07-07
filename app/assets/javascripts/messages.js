$(document).on("page:change page:receive", function() {
  $('.msg-new-submit').hide();
  $('.msg-reply-submit').hide();
});

$(document).on('focus', '.msg-new-textarea', function() {
  $(this).next('.msg-new-submit').fadeIn(150);
});

$(document).on('focus', '.msg-reply-textarea', function() {
  $(this).next('.msg-reply-submit').fadeIn(150);
});


