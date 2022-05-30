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
                title: 'Is Approve',
                data: null,
                render: function(data, type, row) {
                    if (data.is_approved == 1)
                        return '<i class="bx bxs-check-circle" style="color:#43a430"></i>'
                    else
                        return '<i class="bx bxs-check-circle" style="color:#c5c9c4"></i>'
                }

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

                    if (data.is_approved == 0)
                    // Edit timesheet Button  
                        action_html = action_html + "<a class='dropdown-item btn-sm' href = '/timesheets/" + data.id + "/edit'" +
                        " data-toggle='tooltip' data-placement='top' data-original-title='Edit'>" +
                        "<i class='bx bx-edit-alt me-1'></i> Edit</a>"

                    // delete timesheet
                    action_html = action_html + "<a class='dropdown-item delete-user' href = '/timesheets/" + data.id +
                        "data-confirm='Are you sure?' data-method='delete' >" +
                        "<i class='bx bx-trash me-1'></i>Delete</a>"
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

    //Override the default confirm dialog by rails
    $.rails.allowAction = function(link) {
        if (link.data("confirm") == undefined) {
            return true;
        }
        $.rails.showConfirmationDialog(link);
        return false;
    }

    //User click confirm button
    $.rails.confirmed = function(link) {
        link.data("confirm", null);
        link.trigger("click.rails");
    }

    //Display the confirmation dialog
    $.rails.showConfirmationDialog = function(link) {
        var message = link.data("confirm");
        swal({
            title: message,
            type: 'warning',
            confirmButtonText: 'Sure',
            confirmButtonColor: '#2acbb3',
            showCancelButton: true
        }).then(function(e) {
            $.rails.confirmed(link);
        });
    };

    // filtes
    function generateFilterParams() {
        var filters = {
            timesheet: [$("#timesheets :selected").val()],
        }
        $("select[name='timesheets']:selected").each(function() {
            filters['timesheet'].push($(this).data('val'));
        });

        return filters;
    }

    function applyFilters(filters) {
        console.log("hello timesheet", filters);
        if (filters != '') {
            $('#timesheet-list-table').DataTable().ajax.url(
                    "/fetch_timesheets" + "?filters=" + JSON.stringify(filters)
                )
                .load() //checked
        } else {
            $('#timesheet-list-table').DataTable().ajax.reload();
        }
    }
<<<<<<< HEAD
=======
  }
>>>>>>> active-admin

    // timesheet filter
    $('.timesheet-filter').change(function() {
        console.log("timesheet  1")
        var b = [$("#timesheets :selected").val()];
        console.log(b);
        applyFilters(generateFilterParams());
    });
});