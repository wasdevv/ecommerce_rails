// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "channels"

import "chartkick"
import "Chart.bundle"

document.addEventListener("DOMContentLoaded", function() {
    const header = document.querySelector("header");

    window.addEventListener("scroll", function() {
        header.classList.toggle("sticky", window.scrollY > 0);
    });
});

// $(document).on('turbolinks:load', function() {
    // $('#register-link').click(function(e) {
    //   e.preventDefault();
    //   $.ajax({
        // url: '<%= new_user_registration_path %>',
        // method: 'GET',
        // success: function(data) {
            // console.log(data);
        //   $('#registration-form-container').html(data);
        // }
    //   });
    // });
// });