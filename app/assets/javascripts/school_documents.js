$(function() {
  $("#new_category").click(function(evt) {
    evt.stopPropagation();
    // Find out the size of input fields for the name of new field
    var number_of_input_fields = $("input[name^='school_document[categories]']").length;
    var new_field = "<br><input class='string optional school_document_categories' name='school_document[categories]["+ (number_of_input_fields + 1) + "][name]' type='text' list='categories-list'>";
    $(new_field).insertAfter(".school_document_categories:last");
  });
});

$(function() {
  $("#new_question_type").click(function(evt) {
    evt.stopPropagation();
    // Find out the size of input fields for the name of new field
    var number_of_input_fields = $("input[name^='school_document[question_types]']").length;
    var new_field = "<br><input class='string optional school_document_question_types' name='school_document[question_types]["+ (number_of_input_fields + 1) + "][name]' type='text' list='question_types-list'>";
    $(new_field).insertAfter(".school_document_question_types:last");
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


// Hide the solution input file fields
$(function() {
  // $("#solutions-upload-field").css("visibility", "hidden");
  $("#solution-upload-button").click(function(evt) {
    evt.preventDefault();
    $("#solutions-upload-field").trigger("click");
  });
});

// Show solution file name when there is change
$(function() {
  $("#solutions-upload-field").change(function() {
    var files = document.getElementById("solutions-upload-field").files;
    if (files.length > 0) {
      $.each(files, function(idx, elm) {
        var file = "<tr><td>" + elm.name + "</td><td><span class='" + idx + " solution-files glyphicon glyphicon-remove'></span></td></tr>";
        $(file).insertAfter("table#solution-files-table tr:last");
      });
    }
  });
});

$(function() {
  $("#solution-reset-button").click(function(evt) {
    console.log("Reset");
    evt.preventDefault();
    var solution_upload_template = $("#solutions-upload-field");
    console.log(solution_upload_template);
    $("#solutions-upload-field").replaceWith($(solution_upload_template).clone(true));
    $("#solution-upload-button").click(function(evt) {
      evt.preventDefault();
      $("#solutions-upload-field").trigger("click");
    });
  });
});
// $(function() {
//   $("table#solution-files-table").change(function() {
//     console.log("Xxx");
//     $(".solution-files").click(function() {
//       console.log(this);
//     });
//   });
// });
//     // console.log(this);

// $(function() {
//   $("#solution-files-upload").change(function() {
//     console.log("File selected");
//     var solution_files = document.getElementById("solution-files-upload");
//     if (solution_files.files.length > 0) {
//       // $.each(solution_files.files, function(idx, elm) {
//       //   // var solution_file ="<tr><td>" + elm.name + "</td></tr>";
//       //   // $(solution_file).insertAfter(".solution-files-table:last");
//       //   console.log(idx + ":" + elm.name);
//       // });
//       console.log("There are " + solution_files.files.length + " files");
//     }
//   });
// });