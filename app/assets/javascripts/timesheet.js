$(document).on("turbolinks:load", function() {
    $("#timesheet-list-table").DataTable({
        lengthMenu: [10, 20, 30, 40, 50],
        ajax: {
            url: "/fetch_timesheets",
            dataSrc: "timesheets",
        },
        serverSide: true,
        pagination: true,
        info: false,
        columns: [
            { title: "name", data: "user_name" },
            { title: "start date", data: "startdate" },
            { title: "time", data: "workingtime" },
            { title: "description", data: "description" },
            { title: "project name", data: "project_name" },
            { title: "job name", data: "job_name" },
            {
                class: 'product-action a',
                title: 'Actions',
                data: null,
                searchable: false,
                orderable: false,
                render: function(data, type, row) {
                    let action_html = "<div class='input-group' data-timesheet-id ='" + data.id + "'>" +
                        "<span class='dropdown-toggle' data-toggle='dropdown' aria-haspopup='true' aria-expanded='true'></span>" +
                        "<div class='dropdown-menu more_action_bg' x-placement='bottom-end' style='position: absolute;z-index: 9999;'>"

                    // Edit Timesheet Button
                    action_html = action_html + "<a class='dropdown-item' href = /timesheets/" + data.id + "/edit'" +
                        "data-toggle='tooltip' data-placement='top' data-original-title='Edit timesheet'>" +
                        "<i class='bx bx-edit-2'></i> Edit</a>"

                    action_html = action_html + "</div></div>"

                    return action_html;
                }
            },
        ],
        order: [
            ["1", "desc"]
        ],
    });
});