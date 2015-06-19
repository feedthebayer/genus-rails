$(document).on("page:change page:receive", function() {
  $('.msg-reply-submit').hide();
});

$(document).on('focus', '.msg-reply-textarea', function() {
  $(this).next('.msg-reply-submit').fadeIn(150);
});


