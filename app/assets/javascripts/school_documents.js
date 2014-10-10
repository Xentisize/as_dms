function add_new_category() {
  var number_of_input_fields = $("input[name^='school_document[categories]']").length;
  var new_field = "<div class='input-group new_category_group'><input class='string optional school_document_categories form-control' placeholder='Document Category' name='school_document[categories]["+ (number_of_input_fields + 1) + "][name]' type='text' list='categories-list'><span class='input-group-btn'><button class='btn btn-default' onclick='add_new_category(); return false;'><a href='#' class='new_category'><span class='glyphicon glyphicon-plus'></span></a></button></div>";
  $(new_field).insertAfter(".new_category_group:last").focus();
}

$(function() {
  $(".new_category").click(function(evt) {
    evt.stopPropagation();
    // Find out the size of input fields for the name of new field
    var number_of_input_fields = $("input[name^='school_document[categories]']").length;
    var new_field = "<div class='input-group new_category_group'><input class='string optional school_document_categories form-control' placeholder='Document Category' name='school_document[categories]["+ (number_of_input_fields + 1) + "][name]' type='text' list='categories-list'><span class='input-group-btn'><button class='btn btn-default' onclick='add_new_category(); return false;'><a href='#' class='new_category'><span class='glyphicon glyphicon-plus'></span></a></button></div>";
    $(new_field).insertAfter(".new_category_group:last").focus();
  });
});

function add_new_question_type() {
    var number_of_input_fields = $("input[name^='school_document[question_types]']").length;
    var new_field = "<div class='input-group new_question_type_group'><input class='string optional school_document_question_types form-control' placeholder='Question Format' name='school_document[question_types]["+ (number_of_input_fields + 1) + "][name]' type='text' list='question_types-list'><span class='input-group-btn'><button class='btn btn-default' onclick='add_new_question_type(); return false;'><a href='#' class='new_question_type'><span class='glyphicon glyphicon-plus'></span></a></button></div>";
    $(new_field).insertAfter(".new_question_type_group:last").focus();
}

$(function() {
  $(".new_question_type").click(function(evt) {
    evt.stopPropagation();
    // Find out the size of input fields for the name of new field
    var number_of_input_fields = $("input[name^='school_document[question_types]']").length;
    var new_field = "<div class='input-group new_question_type_group'><input class='string optional school_document_question_types form-control' placeholder='Question Format' name='school_document[question_types]["+ (number_of_input_fields + 1) + "][name]' type='text' list='question_types-list'><span class='input-group-btn'><button class='btn btn-default' onclick='add_new_question_type(); return false;'><a href='#' class='new_question_type'><span class='glyphicon glyphicon-plus'></span></a></button></div>";
    $(new_field).insertAfter(".new_question_type_group:last").focus();
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

$(function() {
  $("#school-documents-table").DataTable();
});


// // Hide the solution input file fields
// $(function() {
//   // $("#solutions-upload-field").css("visibility", "hidden");
//   $("#solution-upload-button").click(function(evt) {
//     evt.preventDefault();
//     $("#solutions-upload-field").trigger("click");
//   });
// });

// // Show solution file name when there is change
// $(function() {
//   $("#solutions-upload-field").change(function() {
//     var files = document.getElementById("solutions-upload-field").files;
//     if (files.length > 0) {
//       $.each(files, function(idx, elm) {
//         var file = "<tr><td>" + elm.name + "</td></tr>";
//         $(file).insertAfter("table#solution-files-table tr:last");
//       });
//     }
//   });
// });

// $(function() {
//   $("#solution-reset-button").click(function(evt) {
//     evt.preventDefault();
//     var file_field = document.getElementById("solutions-upload-field");
//     file_field.value = "";
//     $("table#solution-files-table tr td").each(function() {
//       if ($(this).html() !== "") {
//         $(this).parent().fadeOut().remove();
//       }
//     });
//   });
// });

// $(function() {
//   $("#audio-upload-button").click(function(evt) {
//     evt.preventDefault();
//     $("#audios-upload-field").trigger("click");
//   });
// });

// $(function() {
//   $("#audios-upload-field").change(function() {
//     var audios = document.getElementById("audios-upload-field").files;
//     if (audios.length > 0) {
//       $.each(audios, function(idx, elm) {
//         var audio = "<tr><td>" + elm.name + "</td></tr>";
//         $(audio).insertAfter("table#audio-files-table tr:last");
//       });
//     }
//   });
// });

// $(function() {
//   $("#audio-reset-button").click(function(evt) {
//     evt.preventDefault();
//     var audio_field = document.getElementById("audios-upload-field");
//     audio_field.value = "";
//     $("table#audio-files-table tr td").each(function() {
//       if ($(this).html !== "") {
//         $(this).parent().fadeOut().remove();
//       }
//     });
//   });
// });