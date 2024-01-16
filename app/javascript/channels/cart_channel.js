import consumer from "channels/consumer"

consumer.subscriptions.create("CartChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to CartChannel");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log("Received", data);

    if (data.action === 'update_cart') {
      console.log(`Cart ID: ${data.cart.id}, Number of Products: ${data.cart.cart_items ? data.cart.cart_items.length : 0}`);
      TurboStreams.append("cart", { partial: "cart/cart", locals: { cart: data.cart } });
    } else if (data.action === 'product_removed') {
      console.log(`Product removed from cart - Product ID: ${data.product_id}`);
    }
  }
});
