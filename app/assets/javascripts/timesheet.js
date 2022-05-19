$(document).on('turbolinks:load', function() {
    // Timesheets Server Side Listing
    $('#timesheet-list-table').DataTable({
        paging: true,
        serverSide: true,
        responsive: false,
        ajax: {
            "url": "/fetch_timesheets",
            "dataSrc": "timesheets"
        },
        columns: [{
                title: 'Name',
                data: null,
                searchable: false,
                render: function(data, type, row) {
                    return data.user_name
                }
            }, {
                title: 'Date',
                data: null,
                searchable: false,
                render: function(data, type, row) {
                    return formatDate(data.startdate)
                }
            },
            {
                title: 'Time',
                data: null,
                searchable: false,
                render: function(data, type, row) {
                    return formatTime(data.workingtime)
                }
            },
            {
                title: 'Project Name',
                data: null,
                searchable: false,
                render: function(data, type, row) {
                    return data.project_name
                }
            },
            {
                title: 'Job Name',
                data: null,
                searchable: false,
                render: function(data, type, row) {
                    return data.job_name
                }
            },
            {
                title: 'Description',
                data: null,
                searchable: false,
                render: function(data, type, row) {
                    return data.description
                }
            },
            {
                class: 'product-action a',
                title: 'Actions',
                data: null,
                searchable: false,
                orderable: false,
                render: function(data, type, row) {

                    let action_html = "<div class='input-group' data-timesheet-id ='" + data.id + "' >" +
                        "<span class='dropdown-toggle' data-toggle='dropdown' aria-haspopup='true' aria-expanded='true'><i class='feather icon-more-horizontal'></i></span>" +
                        "<div class='dropdown-menu more_action_bg' x-placement='bottom-end' style='position: absolute;z-index: 9999;'>"

                    // // Stats Button
                    // action_html = action_html + "<a class='dropdown-item' href='javascript:void(0);'><i class='feather icon-trending-up'></i> Stats</a>"

                    // Edit timesheet Button
                    action_html = action_html + "<a class='dropdown-item' href = /timesheets/" + data.id + "/edit'" +
                        "data-toggle='tooltip' data-placement='top' data-original-title='Edit timesheet'>" +
                        "<i class='feather icon-edit-2'></i> Edit</a>"

                    // Download CSV Button
                    action_html = action_html + "<a class='dropdown-item display-timesheet-participants' href='javascript:void(0);'" +
                        "data-toggle='tooltip' data-placement='top' data-original-title='Download CSV file of timesheet participants'>" +
                        "<i class='feather icon-download'></i> Download CSV</a>"

                    // Approve/Disable a timesheet
                    action_html = action_html + "<a class='dropdown-item toggle-timesheet-status' href='javascript:void(0);'><i class='feather icon-check-square'></i> " + actionText + "</a>"

                    action_html = action_html + "</div></div>"

                    return action_html;
                }
            },
        ],
        aLengthMenu: [
            [5, 10, 15, 20],
            [5, 10, 15, 20]
        ],
        order: [
            [1, "asc"]
        ],
        bInfo: false,
        pageLength: 10
    });
});