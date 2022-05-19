$(document).on('turbolinks:load', function() {
  // select 2 for dropdown
  $('.js-example-basic-multiple').select2({
    placeholder: "Select an employee",
    allowClear: true
  });
});
console.log("test project")