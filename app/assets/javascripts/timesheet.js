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
            { title: "job name", data: "job_name" }
        ],
        order: [
            ["1", "desc"]
        ],
    });
});