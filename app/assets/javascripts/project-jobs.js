$(document).on('turbolinks:load', function() {
  // server side listing 
  $("#projects-jobs-list").DataTable({
    processing: true,
    paging: true,
    serverSide: true,
    responsive: false,
    ajax: {
      "url": "/fetch_projects_jobs",
      "dataSrc": "projects",
      dataFilter: function (data) {
        var json = jQuery.parseJSON(data);
        return JSON.stringify(json);
      },
    },
    
      columns: [
        {
          title: 'Job Name',
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
          title: 'Assign To',
          data: null,
          searchable: true,
          render: function (data, type, row) {
            return data.user_name
          }
        }
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