// function read(data) {
//   $("#qr-value").text(data);
// }
//
// qrcode.callback = read;
//
//
// $(function() {
//   navigator.getUserMedia = navigator.webkitGetUserMedia;
//
//   var cam_video_id = "camsource";
//
//   window.addEventListener
// })

$(function() {
  $(".subjectPicker").selectpicker();
  // $(".subjectPicker").prop("selectedIndex", -1);
  $(".formatPicker").selectpicker();
});


$(function() {
  $("body").on("keydown", function(event) {
    if (event.which == "27") {
      // $("#reset-fields").click();
      location.reload();
    }
  });
});

$(function() {
  $("#school-document-result-table").DataTable();
});
