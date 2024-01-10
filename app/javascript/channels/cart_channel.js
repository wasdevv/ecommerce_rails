import consumer from '../channels/consumer';

document.addEventListener("DOMContentLoaded", function() {
  // Espera o DOM estar completamente carregado

  const currentUserIdElement = document.getElementById('current-user');

  if (currentUserIdElement) {
    const currentUserId = currentUserIdElement.getAttribute('data-user-id');
  
    // Verifica se está na página do carrinho (por exemplo, usando a URL)
    const isCartPage = window.location.pathname.includes('carrinho');

    if (isCartPage) {
      console.log("Before consumer.subscriptions.create");
      console.log("currentUserId:", currentUserId);

      consumer.subscriptions.create({ channel: "CartChannel", user_id: currentUserId }, {
        connected() {
          // Called when the subscription is ready for use on the server
          console.log("Connected to CartChannel");
        },

        disconnected() {
          // Called when the subscription has been terminated by the server
          console.log("Disconnected to CartChannel");
        },
      
        received(data) {
          // Called when there's incoming data on the websocket for this channel  
          console.log("Received", data);

          if (data.action === 'update_cart' ) {
            updateCartItem(data.cart);
            updateTotalOrder(data.order.total_amount);
          }
        }
      });
    }
  }
});

function updateCartItem(cart) {
  // Verify ir present
  if (cart && cart.cart_item) {
    const cartItemId = `cart-item-${cart.cart_item.id}`;
    const cartItemElement = document.getElementById(cartItemId);

    if (cartItemElement) {
      // Update the propriety of cart item in DOM
      cartItemElement.querySelector('.quantity').innerText = cart.cart_item.quantity;
      cartItemElement.querySelector('.price').innerText = number_to_currency(cart.cart_item.price);

      productRemoved(cart.cart_item.id)
    }
  }
}

function updateTotalOrder(totalAmount) {
  // Update the total of order in DOM
  const totalOrderElement = document.getElementById('total-order');
  if (totalOrderElement && totalAmount !== undefined) {
    totalOrderElement.querySelector('span').innerText = `Total order: ${number_to_currency(totalAmount)}`;
  }
}

function productRemoved(productId) {
  console.log(`Product removed from cart - Product ID: ${productId}`);

  // remove the element of DOM
  const cartItemElement = document.getElementById(`cart-item-${productId}`);
  if (cartItemElement) {
    cartItemElement.remove();
  }
  // Update the total of order, if necessary
  updateTotalOrder();
}