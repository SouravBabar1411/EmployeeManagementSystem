$(document).on('turbolinks:load', function() {
  // Timesheets Server Side Listing
  $('#leavetracker-listing').DataTable({
      serverSide: true,
      responsive: false,
      info: false,
      ajax: {
        "url": "/fetch_leaves",
        "dataSrc" :"leavetrackers",
      },
      "columns": 
          [ 
            { 
              title: "to date",
              data: "to_date" 
            },
            { 
              title: "from date",
              data: "from_date" 
            },
            { 
              title: "user",
              data: "emp_name" 
            },
            { 
              title: "Reason",
              data: "reason" 
            },
            { 
              title: "status",
              data: "is_approved" 
            },
          ],
    aLengthMenu: [[5, 10, 15, 20], [5, 10, 15, 20]],      
    order: [
        [0, "asc"]
    ],
    pageLength: 5
  });

  // Validations
  $("#leavtrackervalidate").validate({
      rules: {
          "leave_tracker[from_date]": {
              required: true
          },
          "leave_tracker[to_date]": {
              required: true
          },
          "leave_tracker[reason]": {
              required: true
          }
      },
      messages: {
          'timesheet[time]': {
              required: 'Select Time'
          },
          'timesheet[description]': {
              required: 'Enter description'
          },
          'timesheet[project_id]': {
              required: 'Select Project'
          },
          'timesheet[job_id]': {
              required: 'Select Job'
          },
      },
      errorPlacement: function(error, element) {
          var placement = $(element).data('error');
          if (placement) {
              $(placement).append(error)
          } else {
              error.insertAfter(element);
          }
      }

  });

});
