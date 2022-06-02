$(document).on('turbolinks:load', function() {
  // select 2 for dropdown
  $('.js-example-basic-multiple').select2({
    placeholder: "Select an employee",
    allowClear: true
  });

  // validations for projects
  $('.project-form').validate({
    rules: {
      'project[name]': {
        required: true
      },
      'project[start_date]': {
        required: true
      },
      'project[user_ids][]': {
        required: true
      }
    },
    messages: {
      'project[name]': {
        required: 'Please enter project name.'
      },
      'project[start_date]':{
        required: 'Please enter project start date.'
      },
      'project[user_ids][]':{
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
  $("#projects-list").DataTable({
    processing: true,
    paging: true,
    serverSide: true,
    responsive: false,
    ajax: {
      "url": "/projects/fetch_projects",
      "dataSrc": "projects",
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
          title: 'Start Date',
          data: null,
          searchable: true,
          render: function (data, type, row) {
            return data.start_date
          }
        },
        {
          title: 'End Date',
          data: null,
          searchable: true,
          render: function (data, type, row) {
            return data.end_date
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
          title: 'Users',
          data: null,
          searchable: true,
          render: function (data, type, row) {
            var action_html = "<a class='dropdown-item' href = '/projects_users/"  + data.id +
            "'data-toggle='tooltip' data-placement='top' data-original-title='show'>" +
            "<i class='bx bxs-user' style='color:rgba(77,77,80,0.95)'></i>"+
            "<span class='badge badge-light'>"+ data.users_count +'</span>'+"</i></a>"; 
            return action_html;
          }
        },
        {
          title: 'Jobs',
          data: null,
          searchable: false,
          render: function (data, type, row) {
            var action_html = "<a class='dropdown-item' href = '/projects_jobs/"+ data.id +
            "' data-toggle='tooltip' data-placement='top' data-original-title='Jobs' >" +
            "<i class='bx bxs-briefcase' style='color:#696cff'>"+
            "<span class='badge badge-light job-badge'>"+ data.jobs_count +'</span>'+"</i></a>"; 
            return action_html;
          }
        },
        {
          
            class: 'user-name',
            title: 'Actions', data: null, searchable: false, orderable: false,
            render: function (data, type, row) {
              let action_html = ""
              if($('#projects-list').data('userrole') == "emp_admin"){
                  action_html = "<div class='input-group' data-user-id ='" + data.id + "'>" +
                    "<button type='button' class='btn p-0' data-bs-toggle='dropdown'>"+
                      "<i class='bx bx-dots-vertical-rounded'></i></button>"+
                      "<div class='dropdown-menu'>"
                  // Edit Project Button  
                  action_html = action_html + "<a class='dropdown-item' href = '/projects/"  + data.id + "/edit'" +
                  "'data-toggle='tooltip' data-placement='top' data-original-title='Edit'>" +
                  "<i class='bx bx-edit-alt me-1'></i> Edit</a>"
                  // Delete Project Button  
                  
                  action_html = action_html + "<a class='dropdown-item' href = '/projects/" + data.id +
                          "data-confirm='Are you sure?' data-method='delete' >" +
                          '<i class="bx bx-trash me-1"></i>Delete' + '</a>'
    
                action_html = action_html + "</div></div>"
              }
              else{
                action_html = ""
              }
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
console.log("test project")