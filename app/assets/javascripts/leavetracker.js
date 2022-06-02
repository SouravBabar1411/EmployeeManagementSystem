$(document).on('turbolinks:load', function() {
  // LeaveTracker Server Side Listing
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
          title: "from date",
          data: "from_date" 
        },
        { 
          title: "to date",
          data: "to_date" 
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
            if($('#leavetracker-listing').data('userrole') == "employee"){
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
            action_html = "<div class='input-group' data-leavetracker-id ='" + data.id + "'>" +
                "<button type='button' class='btn p-0 ' data-bs-toggle='dropdown'>" +
                "<i class='bx bx-dots-vertical-rounded'></i></button>" +
                "<div class='dropdown-menu'>"

                // Edit laeavetracker Button  
            action_html = action_html + "<a class='dropdown-item btn-sm' href = '/leave_trackers/" + data.id + "/edit'" +
                " data-toggle='tooltip' data-placement='top' data-original-title='Edit'>" +
                "<i class='bx bx-edit-alt me-1'></i> Approve</a>"

            // delete leavetracker
            action_html = action_html + "<a class='dropdown-item delete-user' href = '/leave_trackers/" + data.id +
                "data-confirm='Are you sure?' data-method='delete' >" +
                "<i class='bx bx-trash me-1'></i>Reject</a>"
          }
          return action_html;
          }
        }
      ],
    aLengthMenu: [[5, 10, 15, 20], [5, 10, 15, 20]],
    order: [[1, "asc"]],
    bInfo: false,
    pageLength: 5,
    aoColumnDefs: [
      {'bSortable': false, 'aTargets': [0]}
    ],
    initComplete: function (settings, json) {
      $(".dt-buttons .btn").removeClass("btn-secondary");
      // $('.dataTables_filter').addClass('search-icon-placement');
    },
      
    order: [['1', 'desc']]
  });
  

  $('#leavetracker-listing').on('click', '.delete-user', function () {
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
      'leave_tracker[from_date]': {
          required: 'Select Date'
      },
      'leave_tracker[to_date]': {
          required: 'Select to date'
      },
      'leave_tracker[reason]': {
          required: 'Please enter reason'
      }
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