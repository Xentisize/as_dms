$(function() {
  $("#new_question_type").click(function(evt) {
    evt.stopPropagation();
    // Find out the size of input fields for the name of new field
    var number_of_input_fields = $("input[name^='public_exam[question_types]']").length;
    var new_field = "<br><input class='string optional public_exam_question_types' name='public_exam[question_types]["+ (number_of_input_fields + 1) + "][name]' type='text' list='question_types-list'>";
    $(new_field).insertAfter(".public_exam_question_types:last");
  });
});

$(function() {
  $("#new_audio").click(function(evt) {
    evt.stopPropagation();
    var number_of_audio_files = $("input[name^='public_exam[audios]']").length;
    var new_file_field = "<br><input type='file' class='public_exam_audios' name='public_exam[audios][" + (number_of_audio_files + 1) + "][audio_file]''>";
    $(new_file_field).insertAfter(".public_exam_audios:last");
  });
});

