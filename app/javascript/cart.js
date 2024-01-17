document.addEventListener('DOMContentLoaded', function() {
    $('.text-custom-add').on('click', function(e) {
      e.preventDefault();
  
      var productId = $(this).data('product-id');
  
      $.ajax({
        type: 'PATCH',
        url: '/carts/update_quantity/' + productId,
        dataType: 'json',
        success: function(response) {
          // update and dont reload the page
          $('#' + productId + ' .quantity').text(response.new_quantity);
        },
        error: function(error) {
          console.error('Erro ao atualizar a quantidade do carrinho:', error);
        }
      });
    });
});

document.addEventListener('DOMContentLoaded', function() {
    $('.text-custom-add1').on('click', function(e) {
        e.preventDefault();
  
        var productId = $(this).data('product-id');
  
        $.ajax({
            type: 'PATCH',
            url: '/carts/downgrade_quantity/' + productId,
            dataType: 'json',
            success: function(response) {
                
                // Atualize a quantidade sem recarregar a página
                $('#' + productId + ' .quantity').text(response.new_quantity);
            },
            error: function(error) {
                console.error('Erro ao diminuir a quantidade do carrinho:', error);
            }
        });
    });
});