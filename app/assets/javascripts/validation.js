$(document).on('turbolinks:load', function() {
    $("#signupform").validate({
        rules: {
            'user[email]': {
                required: true
            },
            'user[password]': {
                required: true,
            },
            'user[password_confirmation]': {
                required: true,
            }
        },
        messages: {
            'user[email]': {
                required: "Please enter email address",
            },
            'user[password]': {
                required: "Please enter password"
            },
            'user[password_confirmation]': {
                required: "Please enter confirm password"
            }
        }
    });
});