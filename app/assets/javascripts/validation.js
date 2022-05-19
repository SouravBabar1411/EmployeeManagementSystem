$(document).on('turbolinks:load', function() {
    $("#signupform").validate({
        rules: {
            'user[email]': {
                required: true
            },
            'user[password]': {
                required: true,
                pwcheck: true,
                minlength: 6
            },
            'user[password_confirmation]': {
                required: true,
                equalTo: "#pass"
            }
        },
        messages: {
            'user[email]': {
                required: "Please enter your email address"
            },
            'user[password]': {
                required: "Please enter your password ",
                pwcheck: "Must include at least one lowercase letter, one uppercase letter, one digit and special character"
            },
            'user[password_confirmation]': {
                required: "Please enter Confirm Password",
                equalTo: "Confirm Password Not Matched"
            }
        }
    });
    $.validator.addMethod("pwcheck",
        function(value, element) {
            return /^[a-zA-Z0-9!@#$%^&*()_=\[\]{};':"\\|,.<>\/?+-]+$/.test(value) &&
                /[a-z]/.test(value) // has a lowercase letter
                &&
                /\d/.test(value) //has a digit
                &&
                /[!@#$%^&*()_=\[\]{};':"\\|,.<>\/?+-]/.test(value) //has one special character
        });
});
$(document).on('turbolinks:load', function() {
    $("#login").validate({
        rules: {
            'user[email]': {
                required: true
            },
            'user[password]': {
                required: true,
            }
        },
        messages: {
            'user[email]': {
                required: "Please enter email address",
            },
            'user[password]': {
                required: "Please enter password"
            }
        }
    });
});
$(document).on('turbolinks:load', function() {
    $("#edit").validate({
        rules: {
            'user[current_password]': {
                required: true
            }
        }
    });
});