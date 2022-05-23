$(document).on('turbolinks:load', function() {
    // Timesheets Server Side Listing
    $('#timesheet-list-table').DataTable({
        paging: true,
        serverSide: true,
        responsive: false,
        info: false,
        ajax: {
            "url": "/fetch_timesheets",
            "dataSrc": 'timesheets'
        },
        columns: [{
                title: 'Project Name',
                data: "project_name"
            },
            {
                title: 'Job Name',
                data: "job_name"
            },
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
                title: 'Status',
                data: "is_approved"
            },
            {
                title: 'Actions',
                data: null,
                searchable: false,
                orderable: false,
                render: function(data, type, row) {
                    let action_html = "<div class='input-group' data-timesheet-id ='" + data.id + "'>" +
                        "<button type='button' class='btn p-0 ' data-bs-toggle='dropdown'>" +
                        "<i class='bx bx-dots-vertical-rounded'></i></button>" +
                        "<div class='dropdown-menu'>"
                        // Edit Employee Button  
                    action_html = action_html + "<a class='dropdown-item' href = '/timesheets/" + data.id + "/edit'" +
                        " data-toggle='tooltip' data-placement='top' data-original-title='Edit'>" +
                        "<i class='bx bx-edit-alt me-1'></i> Edit</a>"
                    action_html = action_html + "</div></div>"

                    return action_html;
                }
            }
        ],
        order: [
            [1, "asc"]
        ]
    });
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
});