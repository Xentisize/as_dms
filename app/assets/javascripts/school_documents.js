$(function() {
  $("#new_category").click(function(evt) {
    evt.stopPropagation();
    // Find out the size of input fields for the name of new field
    var number_of_input_fields = $("input[name^='school_document[categories]']").length;
    var new_field = "<input class='string optional school_document_categories' name='school_document[categories]["+ (number_of_input_fields + 1) + "][name]' type='text'>";
    $(new_field).insertAfter(".school_document_categories:last");

  });
});