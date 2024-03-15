class HomeController < ApplicationController

    def about
        @products = Product.all
    end

    def favorite
        @user = current_user
    end

    def user
        @user = current_user

    end

    def history
        @user = current_user
        @orders = @user.orders
    end
end
