$(document).on('turbolinks:load', function() {
    // Select2
    $('.js-example-basic-multiple').select2();
    // DatePicker
    $('.datepicker').datepicker();
    // TimePicker
    $('.timepicker').timepicker();
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
                title: 'Date',
                data: "startdate"
            },
            {
                title: 'Time',
                data: "workingtime"
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
                        // Delete Employee Button  
                    action_html = action_html + "<a class='dropdown-item' href = '/timesheets/" + data.id +
                        "data-method='delete'" + "'data-confirm='Are you sure?' data-toggle='tooltip' data-placement='top' data-original-title='Delete'>" +
                        "<i class='bx bx-edit-alt me-1'></i> Delete</a>"
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
            "timesheet[current_date]": {
                required: true
            },
            "timesheet[time]": {
                required: true
            }
        },
        messages: {
            'timesheet[current_date]': {
                required: 'Select date'
            },
            'timesheet[time]': {
                required: 'Select Time'
            },
            'timesheet[description]': {
                required: 'Enter description'
            },
        },
    });
});