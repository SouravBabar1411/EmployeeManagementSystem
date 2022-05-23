$(document).on('turbolinks:load', function() {
  // select 2 for projects dropdown
  $('.select-projects').select2({
    placeholder: "Select a projects",
    allowClear: true
  });

  // select 2 for users dropdown
  $('.select-users').select2({
    placeholder: "Select an employees",
    allowClear: true
  });

  // front end validations 
  $('.job-form').validate({
    rules: {
      'job[name]': {
        required: true
      },
      'job[project_id]': {
        required: true
      },
      'job[user_ids][]': {
        required: true
      }
    },
    messages: {
      'job[name]': {
        required: 'Please enter job name.'
      },
      'job[project_id]':{
        required: 'Please select a project.'
      },
      'job[user_ids][]':{
        required: 'Please select an employees.'
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


  // server side listing
  $("#jobs-list").DataTable({
    processing: true,
    paging: true,
    serverSide: true,
    responsive: false,
    ajax: {
      "url": "/jobs/fetch_jobs",
      "dataSrc": "jobs",
      dataFilter: function (data) {
        var json = jQuery.parseJSON(data);
        return JSON.stringify(json);
      },
    },
      columns: [
        {
          title: 'Name',
          data: null,
          searchable: true,
          render: function (data, type, row) {
            return data.name
          }
        },
        {
          title: 'Status',
          data: null,
          searchable: true,
          render: function (data, type, row) {
            if(data.is_active == 1)
              return '<i class="bx bxs-check-circle" style="color:#43a430"></i>'
            else 
              return '<i class="bx bxs-check-circle" style="color:#c5c9c4"></i>'
          }
        },
        {
          title: 'Project Name',
          data: null,
          searchable: true,
          render: function (data, type, row) {
            return data.project_name
          }
        },
        {
          title: 'Employees',
          data: null,
          searchable: true,
          render: function (data, type, row) {
            return data.user_name
          }
        },
        {
          class: 'user-name',
          title: 'Actions', data: null, searchable: false, orderable: false,
          render: function (data, type, row) {
            let action_html = "<div class='input-group' data-user-id ='" + data.id + "'>" +
                  "<button type='button' class='btn p-0' data-bs-toggle='dropdown'>"+
                    "<i class='bx bx-dots-vertical-rounded'></i></button>"+
                    "<div class='dropdown-menu'>"
                // Edit Job Button  
                action_html = action_html + "<a class='dropdown-item' href = '/jobs/"  + data.id + "/edit'" +
                "'data-toggle='tooltip' data-placement='top' data-original-title='Edit'>" +
                "<i class='bx bx-edit-alt me-1'></i> Edit</a>"
                // Delete Job Button  
                action_html = action_html + "<a class='dropdown-item' href = '/jobs/"  + data.id +
                "data-confirm='Are you sure?' data-method='delete' data-toggle='tooltip' data-placement='top' data-original-title='Destroy Job'>" +
                "<i class='bx bx-trash'></i>Delete</a>"
  
              action_html = action_html + "</div></div>"
              
            return action_html;
          }
        },
      ],
      
    aLengthMenu: [[5, 10, 15, 20], [5, 10, 15, 20]],
    order: [[1, "asc"]],
    bInfo: false,
    pageLength: 5,
    // oLanguage: {
    //   sProcessing: "<div class='spinner-border' role='status'><span class='sr-only'></span></div>"
    // },
    aoColumnDefs: [
      {'bSortable': false, 'aTargets': [0]}
    ],
    initComplete: function (settings, json) {
      $(".dt-buttons .btn").removeClass("btn-secondary");
      // $('.dataTables_filter').addClass('search-icon-placement');
    },
      
    order: [['1', 'desc']]
  });
});