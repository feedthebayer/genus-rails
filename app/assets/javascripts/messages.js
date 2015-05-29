$(document).on("page:change page:receive", function() {
  $('.msg-new-submit').hide();

  $('.msg-new-textarea').focus(function() { 
    $('.msg-new-submit').fadeIn(100); 
  });
});

