document.addEventListener('DOMContentLoaded', function() {
    $('.text-custom-add').on('click', function(e) {
      e.preventDefault();
  
      var productId = $(this).data('product-id');
  
      $.ajax({
        type: 'PATCH',
        url: '/carts/update_quantity/' + productId,
        dataType: 'json',
        success: function(response) {
          // Atualiza a quantidade na página sem recarregar
          $('#' + productId + ' .quantity').text(response.new_quantity);
        },
        error: function(error) {
          console.error('Erro ao atualizar a quantidade do carrinho:', error);
        }
      });
    });
});