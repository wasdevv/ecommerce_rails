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

function scrollToProdutos() {
    const produtosSection = document.getElementById('produtos');
    
    produtosSection.scrollIntoView({ behavior: 'smooth' });
}