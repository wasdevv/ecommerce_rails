// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "channels"

document.addEventListener("DOMContentLoaded", function() {
    const header = document.querySelector("header");

    window.addEventListener("scroll", function() {
        header.classList.toggle("sticky", window.scrollY > 0);
    });
});

$(document).ready(function() {
    // Adiciona um manipulador de eventos para o clique no link "Shop"
    $('ul.navbar li a[href="<%= about_home_path %>"]').on('click', function(e) {
      e.preventDefault(); // Impede o comportamento padrão de navegação
  
      // Use jQuery para animar o scroll até a seção com ID "product"
      $('html, body').animate({
        scrollTop: $('#product').offset().top
      }, 1000);
    });
});

document.addEventListener('turbolinks:load', function () {
    var searchIcon = document.getElementById('search-icon');
    var searchBox = document.getElementById('search-box');

    searchIcon.addEventListener('mouseover', function () {
        searchBox.classList.remove('hidden');
    });

    searchIcon.addEventListener('mouseout', function () {
        searchBox.classList.add('hidden');
    });
});
