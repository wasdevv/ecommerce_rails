document.addEventListener('DOMContentLoaded', function() {
    $('.text-custom-add').on('click', function(e) {
      e.preventDefault();
  
      var productId = $(this).data('product-id');
  
      $.ajax({
        type: 'PATCH',
        url: '/carts/update_quantity/' + productId,
        dataType: 'json',
        success: function(response) {
          // update the quantity without update the site
          $('#' + productId + ' .quantity').text(response.new_quantity);
        },
        error: function(error) {
          console.error('Error with update the cart:', error);
        }
      });
    });
});