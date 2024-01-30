class CartsController < ApplicationController
    before_action :authenticate_user!, only: [:add_to_cart]

    # without payment logistic, ONLY BACK-END
    def new
        # if the user have one cart
        if current_user.cart.present?
            redirect_to cart_path(current_user.cart)
        else
            # make a new cart
            @cart = current_user.build_cart

            # if make correcly the cart
            if @cart.save
                create_activity_log(:created_Cart, @cart, details: { message: 'Created a cart' })
                redirect_to cart_path(current_user.cart)
            end
        end
    end

    def add_to_cart

        @product = Product.find_by(id: params[:product_id])
        if current_user.id == @product.user_id
            flash[:error] = "You can not buy your own product"
            redirect_to root_path
            return
        end

        if @product
            @cart = current_user.cart || current_user.build_cart
            cart_item = @cart.cart_items.find_or_initialize_by( product: @product )
            cart_item.quantity ||= 1
            cart_item.assign_attributes(price: @product.price)
            cart_item.save!

            ActionCable.server.broadcast("cart_channel_#{current_user.id}", { action: 'update_cart', cart: @cart })
            create_activity_log(:added_to_cart, cart_item, details: { message: 'Product added to cart' })
        end

        redirect_to cart_path, notice: 'Product added to your cart.'
        return
    end

    def update_quantity
        @cart = current_user.cart
        @product = Product.find_by(id: params[:product_id])
        @cart_item = @cart.cart_items.find_or_initialize_by(product: @product)
        new_quantity = @cart_item.quantity + 1

        ActionCable.server.broadcast("cart_channel_#{current_user.id}", { action: 'update_cart', cart: @cart })
        if @cart_item.update(quantity: new_quantity)
            redirect_to cart_path(@cart)#, notice: 'Quantidade do carrinho atualizada com sucesso.'
        else
            redirect_to cart_path(@cart)#, alert: 'Erro ao atualizar a quantidade do carrinho.'
        end
    end

    def downgrade_quantity
        @cart = current_user.cart
        @product = Product.find_by(id: params[:product_id])
        @cart_item = @cart.cart_items.find_or_initialize_by(product: @product)

        if @cart_item && @cart_item.quantity > 1
            new_quantity = @cart_item.quantity - 1
            puts "Old Quantity: #{@cart_item.quantity}, New Quantity: #{new_quantity}"
            
            if @cart_item && @cart_item.quantity > 1
                new_quantity = @cart_item.quantity - 1
            
                if @cart_item.update(quantity: new_quantity)
                    redirect_to cart_path(@cart)#, notice: 'Cart quantity updated successfully.'
                else
                    redirect_to cart_path(@cart)#, alert: 'Error updating cart quantity.'
                end
            elsif @cart_item && @cart_item.quantity == 1
                if @cart_item.destroy
                    redirect_to cart_path(@cart)#, notice: 'Cart quantity updated successfully.'
                else
                    redirect_to cart_path(@cart)#, alert: 'Error updating cart quantity.'
                end
            else
                puts "Cart item not found or quantity not set."
                redirect_to cart_path(@cart)#, alert: 'Error updating cart quantity.'
            end
        end
    end

    # render the _cart_table.html.erb
    def show
        @cart = current_user.cart || current_user.build_cart
        @product = Product.find_by(id: params[:product_id])
        @cart_items = @cart.cart_items

        if @cart.cart_items.empty?
            redirect_to root_path
        end
    end

    def remove_product_from_cart
        @cart = current_user.cart
        @product = Product.find_by(id: params[:product_id])
        @cart_item = @cart.cart_items.find_by(product: @product)

        if @cart_item
            @cart_item.destroy
            create_activity_log(:removed_from_cart, @cart_item, details: { message: 'Product has been removed from cart'})
            
            # action cable
            ActionCable.server.broadcast("cart_channel_#{current_user.id}", { action: 'product_removed', product_id: @product.id })
            Rails.logger.info("Broadcasted product_removed to CartChannel")
            
            if @cart.cart_items.empty?
                redirect_to products_path
            else
                redirect_to cart_path(current_user.cart), notice: 'Your product has benn removed from your cart'
            end
        else
            redirect_to @cart, notice: 'Not possible to remove your product, try again.'
        end
    end

    def destroy
        current_user.destroy
        create_activity_log(:deleted_cart, @cart, details: { message: 'Deleted a cart'})

        @order = current_user.orders.build

        @cart_items.each do |cart_item|
            @order.order_items.build(
                product: cart_item.product,
                quantity: cart_item.quantity,
                price: cart_item.price
            )
        end

        if @order.save
            create_activity_log(:created_order, @order, details: { message: 'Created a order'})
        end
    end

    def checkout
        @cart = current_user.cart
        @cart_items = @cart.cart_items

        @order = current_user.orders.build

        @cart_items.each do |cart_item|
            @order.order_items.build(
                product: cart_item.product,
                quantity: cart_item.quantity,
                price: cart_item.price
            )
        end

        if @order.save
            create_activity_log(:created_order, @order, details: { message: 'Order created '})
        end
    end

    def destroy_all_items
        @order = current_user.orders.build
        @order.save

        create_activity_log(:created_history, @order, details: { message: 'Order archived in user history'})

        current_user.cart.cart_items.each do |cart_item|
            @order.order_items.create(product: cart_item.product, quantity: cart_item.quantity, price: cart_item.price )
        end

        create_activity_log(:removed_all_items, current_user.cart, details: { message: 'Removing items from cart' })
        current_user.cart.cart_items.destroy_all
        redirect_to root_path, notice: 'Thank you for choosing our store'
    end

    private

    def create_activity_log(action, trackable, details: {})
        ActivityLog.create!(user: current_user, action: action, trackable: trackable, details: details)
    end
end