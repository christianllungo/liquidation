class ProductsController < ApplicationController

    def index
        @products = Product.all
        render :index
    end
    
    # NEEDS WORK
    def show
        @product = Product.find_by(id: params[:id])
        if @product
            render :show
        else 
            redirect_to products_url
        end
    end

    def new
        render :new
    end

    def create
        @product = current_user.products.new(product_params)
        if @product.save
            redirect_to user_url(current_user)
        else
            flash.now[:errors] = @product.errors.full_messages
            render :new
        end
    end

    # NEEDS WORK
    def edit
        @cat = Cat.find_by(id: params[:id])
        render :edit
    end

    # NEEDS WORK
    def update
        @cat = Cat.find_by(id: params[:id])
        if @cat.update_attributes(cat_params)
            redirect_to cat_url(@cat)
        else
            render :edit
        end
    end

    def destroy
        @product = Product.find_by(id: params[:id])
        @product.destroy
        redirect_to user_url(current_user)
    end

    private
    def product_params
        params.require(:product).permit(:name, :category, :price, :description)
    end
end
