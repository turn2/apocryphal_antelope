function toggleCheckboxes(buttonObject, value) {
  $(buttonObject)
    .closest("form")
    .find("input[type='checkbox']")
    .each(function(index, element) {
      $(element)
        .attr('checked', value);
    });  
}

$(document).ready(function() {
  // Functions for checking all or none of the checkboxes in a given form
  $(".check_all")
    .click(function(){
      toggleCheckboxes(this, true);
    });


  $(".check_none")
    .click(function(){
      toggleCheckboxes(this, false);
    });

  // automatically fade out flash elements 3 seconds after they're displayed
  setTimeout( function() {
    $(".flash")
      .fadeOut(1200, function() {
        $(this).remove();
      });
  }, 1800);

});

