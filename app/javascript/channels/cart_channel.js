import consumer from "channels/consumer"

consumer.subscriptions.create("CartChannel", {
  connected() {
    console.log("Connected to CartChannel");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log("Received", data);

    if (data.action === 'update_cart') {
      console.log(`Cart ID: ${data.cart.id}`);
      TurboStreams.replace("cart", { partial: "cart/cart", locals: { cart: data.cart } });
    } else if (data.action === 'product_removed') {
      console.log(`Product removed from cart - Product ID: ${data.product_id}`);
    }
  }
});
