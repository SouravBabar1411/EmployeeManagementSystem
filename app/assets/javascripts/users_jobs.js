$(document).on('turbolinks:load', function() {
  // server side listing
  $("#users-jobs-list").DataTable({
    processing: true,
    paging: true,
    serverSide: true,
    responsive: false,
    ajax: {
        "url": $('#users-jobs-list').data('source'),
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
    },
      
    order: [['1', 'desc']]
  });
});