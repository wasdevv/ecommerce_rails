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
            create_activity_log(:product_created, @product, details: { message: 'Product created'})
            flash[:success] = "Product created!"
            redirect_to root_path
        else
            render :new
        end
    end

    def show
        @product = Product.find(params[:id])
    end

    def edit
        @product = Product.find(params[:id])
    end

    def update
        @product = Product.find(params[:id])
        if @product.update(product_params)
            create_activity_log(:product_updated, @product, details: { message: 'Product updated' })
            redirect_to product_path(@product)
            flash[:success] = "Product updated!"
        else
            render :edit
        end
    end

    def destroy
        @product = Product.find(params[:id])
        @product.destroy
        create_activity_log(:product_deleted, @product, details: { message: 'Product removed '})
        flash[:danger] = "Product deleted."
        redirect_to root_path
    end
    
    private

    def product_params
        params.require(:product).permit(:name, :quantity, :price, :description, :image)
    end

    def create_activity_log(action, trackable, details: {} )
        ActivityLog.create!(user: current_user, action: action, trackable: trackable, details: details)
    end
end
