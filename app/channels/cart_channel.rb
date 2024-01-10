class CartChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "cart_channel_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def broadcast_update
    ActionCable.server.broadcast("cart_channel_#{current_user.id}", { action: 'update_cart' })
  end
end
