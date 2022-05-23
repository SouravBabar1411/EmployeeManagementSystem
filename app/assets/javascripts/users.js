$(document).on('turbolinks:load', function() {
  $('#employee-table').DataTable({
      processing: true,
      paging: true,
      serverSide: true,
      responsive: false,
      ajax: {
        url: "/fetch_employees",
        dataSrc: "users",
        dataFilter: function (data) {
          var json = jQuery.parseJSON(data);
          return JSON.stringify(json);
        },
      },
      columns: [ 
        {
          title: 'Image', 
          data: null, 
          searchable: false, 
          sortable: false,
          render: function (data, type, row) {
            return '<img src="' + data['image']['url'] + '" style="margin-left:10px;" class="user_table_image_thumb_size" />'
          }
        },
        {
          class: 'user-name',
          title: 'First name', 
          data: null,
          searchable: true,
          render: function (data, type, row) {
            return '<span data-user-id="' + data.id + '"> <strong>' +
              data.first_name + '</strong></span>'
          }
        },
        {
          class: 'user-name',
          title: 'Last name', 
          data: null,
          searchable: true,
          render: function (data, type, row) {
            return '<span data-user-id="' + data.id + '"> ' +
              data.last_name + '</span>'
          }
        },
        {
          class: 'user-name',
          title: 'Email',
          data: null,
          searchable: true,
          render: function (data, type, row) {
            return '<span data-user-id="' + data.id + '">' +
              data.email + '</span>'
          }
        },
        {
          class: 'user-name',
          title: 'Gender',
          data: null,
          searchable: true,
          render: function (data, type, row) {
            return '<span data-user-id="' + data.id + '">' +
              data.gender + '</span>'
          }
        },
        {
          class: 'user-name',
          title: 'Date of Birth',
          data: null,
          searchable: true,
          render: function (data, type, row) {
            return '<span data-user-id="' + data.id + '">' +
              data.date_of_birth + '</span>'
          }
        },
        {
          class: 'user-name',
          title: 'Status',
          data: null,
          searchable: false,
          render: function (data, type, row) {
            actionText = data.is_active ? 'Active' : 'Inactive'
            return '<span class="badge bg-label-primary me-1" data-user-id="' + data.id + '"> ' +
            actionText + '</span>'
          }
        },
        {
          class: 'user-name',
          title: 'Actions', data: null, searchable: false, orderable: false,
          render: function (data, type, row) {
            let action_html = "<div class='input-group' data-user-id ='" + data.id + "'>" +
                  "<button type='button' class='btn p-0 ' data-bs-toggle='dropdown'>"+
                    "<i class='bx bx-dots-vertical-rounded'></i></button>"+
                    "<div class='dropdown-menu'>"
                // Edit Employee Button  
                action_html = action_html + "<a class='dropdown-item' href = '/users/"  + data.id + "/edit'" +
                "'data-toggle='tooltip' data-placement='top' data-original-title='Edit'>" +
                "<i class='bx bx-edit-alt me-1'></i> Edit</a>"
                // Delete Employee Button  
                action_html = action_html + "<a class='dropdown-item' href = '/users/"  + data.id +
                "'data-toggle='tooltip' data-placement='top' data-original-title='Delete'>" +
                "<i class='bx bxs-exit me-1'></i> Delete</a>"
  
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
      aLengthMenu: [[5, 10, 15, 20], [5, 10, 15, 20]],
      order: [[1, "desc"]],
      bInfo: false,
      pageLength: 5,
      aoColumnDefs: [
        {'bSortable': false, 'aTargets': [0]}
      ],
      buttons: [
        {
          text: "<i class='feather icon-plus'></i>",
          className: "btn btn-primary mr-sm-1 mb-1 mb-sm-0 waves-effect waves-light"
        }
      ],
      initComplete: function (settings, json) {
        $(".dt-buttons .btn").removeClass("btn-secondary");
      }
    });
    // Email Validaton Added
    $.validator.addMethod('isEmail', function (value) {
      var EmailRegex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
      return EmailRegex.test(value);
    });
    $('.user_registration_form').validate({
      rules: {
        'user[first_name]': {
          required: true,
          maxlength: 20
        },
        'user[last_name]': {
          required: true,
          maxlength: 20
        },
        'user[email]': {
          required: true,
          isEmail : true
        },
        'user[password]': {
          required: true,
          minlength: 6
        },
        'user[password_confirmation]': {
          required: true,
          equalTo: "#user_password",
          minlength: 6
        },
        'user[gender]': {
          required: true
        },
        'user[date_of_birth]': {
          required: true
        },
        'user[address_line_1]': {
          required: true
        },
        'user[city]': {
          required: true
        },
        'user[state]': {
          required: true
        },
        'user[country]': {
          required: true
        },
        'user[zipcode]': {
          required: true
        }
      },
      messages: {
        'user[first_name]': {
          required: 'Please enter First Name'
        },
        'user[last_name]': {
          required: 'Please enter Last Name'
        },
        'user[email]': {
          required: 'Please enter user email',
          email: 'Please enter valid user email'
        },
        'user[password]': {
          required: 'Please enter user password',
          minlength: 'Password is too short (minimum is 6 characters)'
        },
        'user[password_confirmation]': {
          required: 'Please enter Confirm Password',
          equalTo: 'Confirm password do not match',
          minlength: 'Password is too short (minimum is 6 characters)'
        },
        'user[gender]': {
          required: 'Please enter Gender'
        },
        'user[date_of_birth]': {
          required: 'Please enter Date of Birth'
        },
        'user[address_line_1]': {
          required: 'Please enter Address Line 1'
        },
        'user[city]': {
          required: 'Please enter City'
        },
        'user[state]': {
          required: 'Please enter State'
        },
        'user[country]': {
          required: 'Please enter Country'
        },
        'user[zipcode]': {
          required: 'Please enter Zipcode'
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
} );
