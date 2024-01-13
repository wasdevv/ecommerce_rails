import consumer from "./consumer";

consumer.subscriptions.create({ channel: "CartChannel" }, {
  connected() {
    console.log("Connected to CartChannel");
  },

  disconnected() {
    // if disconnected
  },

  received(data) {
    console.log("Received", data);

    if (data.action === 'update_tart') {
      TurboStreams.append("cart", { partial: "cart/cart", locals: { cart: data.cart } });
    }
  }
});