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
        if current_user.id == @product.user_:id => 
            flash[:error] = "You can not buy your own product"
            redirect_to root_path
            return
        end

        if @product
            @cart = current_user.cart || current_user.build_cart
            cart_item = @cart.cart_items.find_or_initialize_by( product: @product )
            cart_item.quantity ||= 1
            cart_Item.assign_attributes(price: @product.price)
            cart_item.save!

            create_activity_log(:added_to_cart, cart_item, details: { message: 'Product added to cart' })
        end

        redirect_to cart_path, notice: 'Product added to your cart.'
        return
    end

    # render the _cart_table.html.erb
    def show
        @cart = current_user.cart || current_user.build_cart
        @product = Product.find_by(id: params[:product_id])
        @cart_items = @cart.cart_items
    end

    def remove_product_from_cart
        @cart = current_user.cart
        @product = Product.find( product: @product_id )
        if @cart_item
            @cart_item.destroy_all
            create_activity_log(:removed_from_cart, @cart_item, details: { message: 'Product has been removed from cart'})
            if @cart.cart_items.empty?
                redirect_to products_path
            else
                redirect_to cart_path(current_user.cart), notice: 'Your product has benn removed from your cart'
            end
        end
    else
        redirect_to @cart, notice: 'Not possible to remove your product, try again.'
    end

    def checkout
        @cart = current_user.cart
        @cart_items = @cart.cart_items
    end

    private

    def create_activity_log(action, trackable, details: {})
        ActivityLog.create!(user: current_user, action: action, trackable: trackable, details: details)
    end
end