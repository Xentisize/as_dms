$(function() {
  $("#new_category").click(function(evt) {
    evt.stopPropagation();
    // Find out the size of input fields for the name of new field
    var number_of_input_fields = $("input[name^='school_document[categories]']").length;
    var new_field = "<br><input class='string optional school_document_categories' name='school_document[categories]["+ (number_of_input_fields + 1) + "][name]' type='text'>";
    $(new_field).insertAfter(".school_document_categories:last");
  });
});

// Match the english / chinese school name when blurred
$(function() {
  $("#school_document_school_english_name").blur(function() {
    // The english school name is not empty while there is no input in chinese school name
    if($(this).val() !== "" && $("#school_document_school_chinese_name").val() === "") {
      var request_url = "/queries/schools/" + $(this).val() + ".json";
      $.getJSON(request_url, function(data) {
        $("#school_document_school_chinese_name").val(data["chinese_name"]);
      });
    }
  });
});

$(function() {
  $("#school_document_school_chinese_name").blur(function() {
    // The english school name is not empty while there is no input in chinese school name
    if($(this).val() !== "" && $("#school_document_school_english_name").val() === "") {
      var request_url = "/queries/schools/" + $(this).val() + ".json";
      $.getJSON(request_url, function(data) {
        $("#school_document_school_english_name").val(data["english_name"]);
      });
    }
  });
});