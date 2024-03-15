class ProductsController < ApplicationController
    before_action :authenticate_user!, only: [:favorite]
    
    def index
        @products = Product.all
    end

    def new
        @product = Product.new
    end

    def favorite
        @product = Product.find(params[:id])
        
        if current_user.present? && current_user.favorites.exists?(product_id: @product.id)
            current_user.favorites.find_by(product_id: @product.id).destroy
            create_activity_log(:favorite_removed, @product, details: { message: 'Favorite removed'})
            redirect_to @product, notice: 'Product removed from favorites'
        else
            current_user.favorites.create(product: @product)
            create_activity_log(:favorite_product, @product, details: { message: 'Product favorited'})
            redirect_to @product, notice: 'Product added to favorites'
        end
    end

    def create
        @product = current_user.products.build(product_params)
        @product.image.attach(params[:product][:image]) if params[:product][:image]
        
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
