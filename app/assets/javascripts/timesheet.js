$(document).on('turbolinks:load', function() {
  // Timesheets Server Side Listing
$('#timesheet-list-table').DataTable({
	processing: true,
	paging: true,
	serverSide: true,
	responsive: false,
		ajax: {
				"url": "/fetch_timesheets",
				"dataSrc": "timesheets"
		},
		"columns": [{
					title: 'Project Name',
					data: "project_name"
				},
				{
					title: 'Job Name',
					data: "job_name"
				},
        // {
        //   title: 'employee',
        //   data: "user_name"
        // },
				{
					title: 'Description',
					data: "description"
				},
				{
					title: 'Time',
					data: "time"
				},
				{
					title: 'Date',
					data: "startdate"
				},
				{
					title: 'Is Approve',
					data: null,
					render: function(data, type, row) {
						if (data.is_approved == 1)
								return '<i class="bx bxs-check-circle" style="color:#43a430"></i>'
						else
								return '<i class="bx bxs-check-circle" style="color:#c5c9c4"></i>'
					}

				},
				{
          title: 'Actions',
          data: null,
          searchable: false,
          orderable: false,
          render: function(data, type, row) {
            let action_html = ""
            if($('#timesheet-list-table').data('userrole') == "employee"){
            action_html = "<div class='input-group' data-leavetracker-id ='" + data.id + "'>" +
                "<button type='button' class='btn p-0 ' data-bs-toggle='dropdown'>" +
                "<i class='bx bx-dots-vertical-rounded'></i></button>" +
                "<div class='dropdown-menu'>"

                // Edit laeavetracker Button  
            action_html = action_html + "<a class='dropdown-item btn-sm' href = '/leave_trackers/" + data.id + "/edit'" +
                " data-toggle='tooltip' data-placement='top' data-original-title='Edit'>" +
                "<i class='bx bx-edit-alt me-1'></i> Edit</a>"

            // delete leavetracker
            action_html = action_html + "<a class='dropdown-item delete-user' href = '/leave_trackers/" + data.id +
                "data-confirm='Are you sure?' data-method='delete' >" +
                "<i class='bx bx-trash me-1'></i>Delete</a>"
            }
          else{
            action_html = ""
            actionText = data.is_approved ? 'Reject' : 'Approve'
            action_html = "<div class='input-group' data-user-id ='" + data.id + "'>" +
                  "<button type='button' class='btn p-0 ' data-bs-toggle='dropdown'>"+
                    "<i class='bx bx-dots-vertical-rounded'></i></button>"+
                    "<div class='dropdown-menu'>"

            action_html = action_html + "<a class='dropdown-item reject-leave' href = 'javascript:void(0);' data-toggle='tooltip' data-placement='top' data-user-id = '"
                + data.id + "'>" + "<i class='bx bxs-exit me-1'></i>"+actionText+"</a>"

          }
          return action_html;
          }
        }
		],
		aLengthMenu: [
				[5, 10, 15, 20],
				[5, 10, 15, 20]
		],
		order: [
				[1, "asc"]
		],
		bInfo: false,
		pageLength: 5,
});

  $('#timesheet-list-table').on('click', '.reject-leave', function () {

    // var challengeId = $(this).parent().parent().data('challenge-id');
    var timeId = $(this).data('user-id');

    if ($(this).html().includes('Reject')) {
      swalTitle = 'Reject'
      swalText = 'Do you want to Reject the timesheet?'
    } else {
      swalTitle = 'Approve'
      swalText = 'Do you want to approve the timesheet?'
    }
    
    Swal.fire({
      title: 'Are you sure?',
      text: swalText,
      type: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Yes, ' + swalTitle + ' it!',
      confirmButtonClass: 'btn btn-primary',
      cancelButtonClass: 'btn btn-danger ml-1',
      buttonsStyling: false,
    }).then(function (result) {
      if (result.value) {
        $('.loader').fadeIn();
        $.ajax({
          type: 'PATCH',
          url: "/timesheet/" + timeId,
          success: function (data) {
            $('.loader').fadeOut();
            swalNotify(data.title, data.message);
            if (data.success) {
              $('#timesheet-list-table').DataTable().ajax.reload(null, false);
            }
          }
        });
      }
    });
  });

  // sweet alert 
  $('#timesheet-list-table').on('click', '.delete-user', function () {
    event.preventDefault(); // don't forget to prevent the default event
    Swal.fire({
      title: 'Are you sure?',
      text: "You won't be able to revert this!",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Yes, delete it!'
    }).then((result) => {
      if (result.isConfirmed) {
        Swal.fire(
          'Deleted!',
          'Your file has been deleted.',
          'success'
        )
      }
    });
  });

  // Trigger SWAL Notification
  function swalNotify(title, message) {
    Swal.fire({
      title: title,
      text: message,
      confirmButtonClass: 'btn btn-primary',
      buttonsStyling: false,
    });
  }
     
  // Validations
  $("#timesheetValidate").validate({
      rules: {
          "timesheet[time]": {
              required: true
          },
          "timesheet[description]": {
              required: true
          },
          "timesheet[project_id]": {
              required: true
          },
          "timesheet[job_id]": {
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


  // filtes
  function generateFilterParams() {
      var filters = {
          timesheet: [$("#timesheets :selected").val()],
      }
      $("select[name='timesheets']:selected").each(function() {
          filters['timesheet'].push($(this).data('val'));
      });

      return filters;
  }

  function applyFilters(filters) {
      console.log("hello timesheet", filters);
      if (filters != '') {
          $('#timesheet-list-table').DataTable().ajax.url(
                  "/fetch_timesheets" + "?filters=" + JSON.stringify(filters)
              )
              .load() //checked
      } else {
          $('#timesheet-list-table').DataTable().ajax.reload();
      }
  }

  // timesheet filter
  $('.timesheet-filter').change(function() {
      console.log("timesheet  1")
      var b = [$("#timesheets :selected").val()];
      console.log(b);
      applyFilters(generateFilterParams());
  });
});
