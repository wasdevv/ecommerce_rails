class CartChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "cart_channel_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
