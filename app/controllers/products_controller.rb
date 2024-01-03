class ProductsController < ApplicationController
    def index
        @products = Product.all
    end

    def new
        @product = Product.new
    end

    def show
    end

    def edit
    end

    def update
    end

    def destroy
    end
    
    private

    def product_params
        params.require(:product).permit(:name, :quantity, :price, :description)
    end
end
