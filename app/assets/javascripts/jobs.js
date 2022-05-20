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
          title: 'Active',
          data: null,
          searchable: true,
          render: function (data, type, row) {
            return data.is_active
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
                // Edit Project Button  
                action_html = action_html + "<a class='dropdown-item' href = '/users/"  + data.id + "/edit'" +
                "'data-toggle='tooltip' data-placement='top' data-original-title='Edit'>" +
                "<i class='bx bx-edit-alt me-1'></i> Edit</a>"
                // Delete Project Button  
                action_html = action_html + "<a class='dropdown-item' href = '/projects/"  + data.id +
                "'data-toggle='tooltip' data-placement='top' data-original-title='Delete'>" +
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