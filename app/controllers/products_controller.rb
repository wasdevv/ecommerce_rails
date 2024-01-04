class ProductsController < ApplicationController
    def index
        @products = Product.all
    end

    def new
        @product = Product.new
    end

    def create
        @product = current_user.products.build(product_params)
        if @product.save
            flash[:success] = "Product created!"
            redirect_to products_path
        else
            render :new
        end
    end

    def show
        @product = Product.find(params[:id])
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
