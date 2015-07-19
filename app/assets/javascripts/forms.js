$(document).on('keydown', '.uTextarea', function(e) {
  // Enter was pressed with shift key
  if (e.keyCode == 13 && e.shiftKey) {
    $(this).next('#new-message').click();
    e.preventDefault();
  }
});



function UpdateTextAreaSize() {
  //Attempt to set to min rows to shrink area to fit content
  this.rows = this.minRows;
  //Calculate extra rows
  var extraRows = Math.round((this.scrollHeight - this.baseScrollHeight) / this.scrollInc);
  console.log('CALC. scroll-base:', (this.scrollHeight - this.baseScrollHeight));
  this.rows = this.minRows + extraRows;
  // console.log('current:', this.rows, '= min:', this.minRows, '+ extra:', extraRows, '| scroll:', this.scrollHeight, 'base:', this.baseScrollHeight);
}


$(document)
  .on('focus.textarea', '.uTextarea', function(){
    //Only calculate if not already calculated.
    //Can't use .one to call this code because we need it to call when we focus
    //on every textarea, not just the first focus
    if (!this.baseScrollHeight) {
      //Save current text and clear textarea
      var savedValue = this.value;
      this.minRows = parseInt(this.getAttribute('data-min-rows'));
      this.value = '';
      //Get height with no content
      this.baseScrollHeight = this.scrollHeight;

      //Calculate height on an incremental row
      //To do this, add new lines until height is min + 1
      for (i=0; i < this.minRows; i++) {
        this.value += '\r\n';
      }
      //Save line increment
      this.scrollInc = this.scrollHeight - this.baseScrollHeight - 1;

      //Restore text
      this.value = savedValue;
      // console.log('BASE:', this.baseScrollHeight, 'inc:', this.scrollInc, 'current:', this.scrollHeight);
      UpdateTextAreaSize.call(this);
    }
  })
  .on('input.textarea', '.uTextarea', UpdateTextAreaSize);
