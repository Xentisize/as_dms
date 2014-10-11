// $(function() {
//   $("#new_question_type").click(function(evt) {
//     evt.stopPropagation();
//     // Find out the size of input fields for the name of new field
//     var number_of_input_fields = $("input[name^='public_exam[question_types]']").length;
//     var new_field = "<br><input class='string optional public_exam_question_types' name='public_exam[question_types]["+ (number_of_input_fields + 1) + "][name]' type='text' list='question_types-list'>";
//     $(new_field).insertAfter(".public_exam_question_types:last");
//   });
// });

// $(function() {
//   $("#new_audio").click(function(evt) {
//     evt.stopPropagation();
//     var number_of_audio_files = $("input[name^='public_exam[audios]']").length;
//     var new_file_field = "<br><input type='file' class='public_exam_audios' name='public_exam[audios][" + (number_of_audio_files + 1) + "][audio_file]''>";
//     $(new_file_field).insertAfter(".public_exam_audios:last");
//   });
// });


function add_new_question_type() {
    var number_of_input_fields = $("input[name^='public_exam[question_types]']").length;
    var new_field = "<div class='input-group public_exam_type_group'><input class='string optional public_exam_question_types form-control' placeholder='Question Format' name='public_exam[question_types]["+ (number_of_input_fields + 1) + "][name]' type='text' list='question_types-list'><span class='input-group-btn'><button class='btn btn-default' onclick='add_new_question_type(); return false;'><a href='#' class='new_question_type'><span class='glyphicon glyphicon-plus'></span></a></button></div>";
    $(new_field).insertAfter(".new_question_type_group:last").focus();
}

$(function() {
  $(".new_question_type").click(function(evt) {
    evt.stopPropagation();
    // Find out the size of input fields for the name of new field
    var number_of_input_fields = $("input[name^='public_exam[question_types]']").length;
    var new_field = "<div class='input-group new_question_type_group'><input class='string optional public_exam_question_types form-control' placeholder='Question Format' name='public[question_types]["+ (number_of_input_fields + 1) + "][name]' type='text' list='question_types-list'><span class='input-group-btn'><button class='btn btn-default' onclick='add_new_question_type(); return false;'><a href='#' class='new_question_type'><span class='glyphicon glyphicon-plus'></span></a></button></div>";
    $(new_field).insertAfter(".new_question_type_group:last").focus();
  });
});

$(function() {
  $("#public-exams-table").DataTable();
});

$(function() {
  $("div#document-details a").each(function() {
    if ($(this).attr("href").indexOf("pdf") !== -1) {
      var url = $(this).attr("href");
      $(this).click(function(evt) {
        evt.preventDefault();
        var pdf = "<iframe id='document-preview' src='" + url + "#zoom=50' width='700px' height='600px' type='application/pdf'>"
        console.log(pdf);
        $("#document-preview").replaceWith($(pdf));
      });
    }
  });
});