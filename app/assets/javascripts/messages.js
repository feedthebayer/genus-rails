$(document).ready(function() {
  $('.msg-new-submit').hide();
});

$(function() {
  $('.msg-new-textarea').focus(function() { 
    $('.msg-new-submit').fadeIn(100); 
  });
});
