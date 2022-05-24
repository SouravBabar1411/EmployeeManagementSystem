$(document).on('turbolinks:load', function() {
    $('#employee-table').DataTable({
        processing: true,
        paging: true,
        serverSide: true,
        responsive: false,
        ajax: {
            url: "/fetch_employees",
            dataSrc: "users",
            dataFilter: function(data) {
                var json = jQuery.parseJSON(data);
                return JSON.stringify(json);
            },
        },
        columns: [{
                title: 'Image',
                data: "image",
                searchable: false,
                sortable: false
            },
            {
                class: 'user-name',
                title: 'First name',
                data: null,
                searchable: true,
                render: function(data, type, row) {
                    return '<span data-user-id="' + data.id + '"> <strong>' +
                        data.first_name + '</strong></span>'
                }
            },
            {
                class: 'user-name',
                title: 'Last name',
                data: null,
                searchable: true,
                render: function(data, type, row) {
                    return '<span data-user-id="' + data.id + '"> ' +
                        data.last_name + '</span>'
                }
            },
            {
                class: 'user-name',
                title: 'Email',
                data: null,
                searchable: true,
                render: function(data, type, row) {
                    return '<span data-user-id="' + data.id + '">' +
                        data.email + '</span>'
                }
            },
            {
                class: 'user-name',
                title: 'Status',
                data: null,
                searchable: false,
                render: function(data, type, row) {
                    actionText = data.is_active ? ' Yes' : ' No'
                    return '<span class="badge bg-label-primary me-1" data-user-id="' + data.id + '"> ' +
                        actionText + '</span>'
                }
            },
            {
                class: 'user-name',
                title: 'Actions',
                data: null,
                searchable: false,
                orderable: false,
                render: function(data, type, row) {
                    let action_html = "<div class='input-group' data-user-id ='" + data.id + "'>" +
                        "<button type='button' class='btn p-0 dropdown-toggle' data-bs-toggle='dropdown'>" +
                        "<i class='bx bx-dots-vertical-rounded'></i></button>" +
                        "<div class='dropdown-menu'>"
                        // Edit Employee Button  
                    action_html = action_html + "<a class='dropdown-item' href = '/users/" + data.id + "/edit'" +
                        "'data-toggle='tooltip' data-placement='top' data-original-title='Edit'>" +
                        "<i class='bx bx-edit-alt me-1'></i> Edit</a>"
                        // Delete Employee Button  
                    action_html = action_html + "<a class='dropdown-item' href = '/users/" + data.id +
                        "'data-toggle='tooltip' data-placement='top' data-original-title='Delete'>" +
                        "<i class='bx bx-edit-alt me-1'></i> Delete</a>"

                    action_html = action_html + "</div></div>"

                    return action_html;
                }
            },
        ],
        dom: '<"top"<"actions action-btns"B><"action-filters"lf>><"clear">rt<"bottom"<"actions">p>',
        oLanguage: {
            sLengthMenu: "_MENU_",
            sSearch: ""
        },
        aLengthMenu: [
            [5, 10, 15, 20],
            [5, 10, 15, 20]
        ],
        order: [
            [1, "asc"]
        ],
        bInfo: false,
        pageLength: 5,
        aoColumnDefs: [
            { 'bSortable': false, 'aTargets': [0] }
        ],
        buttons: [{
            text: "<i class='feather icon-plus'></i>",
            className: "btn btn-primary mr-sm-1 mb-1 mb-sm-0 waves-effect waves-light"
        }],
        initComplete: function(settings, json) {
            $(".dt-buttons .btn").removeClass("btn-secondary");
        }
    });
});