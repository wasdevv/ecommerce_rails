import consumer from "./consumer";

consumer.subscriptions.create({ channel: "CartChannel" }, {
  connected() {
    console.log("Connected to CartChannel");
  },

  disconnected() {
    // if disconnect
  },

  received(data) {
    console.log("Received", data);

    if (data.action === 'update_cart') {
      console.log(`Cart ID: ${data.cart.id}, Number of Products: ${data.cart.cart_items ? data.cart.cart_items.length : 0}`);
      TurboStreams.append("cart", { partial: "cart/cart", locals: { cart: data.cart } });
    } else if (data.action === 'product_removed') {
      console.log(`Product removed from cart - Product ID: ${data.product_id}`);
    }
  }
});