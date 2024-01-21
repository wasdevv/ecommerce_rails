class HomeController < ApplicationController

    def about
        @products = Product.all
    end

    def history
        @user = current_user
        @orders = @user.orders
    end
end
