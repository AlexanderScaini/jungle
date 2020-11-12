class Admin::CategoriesController < ApplicationController

  http_basic_authenticate_with name: ENV['admin_name'], password: ENV['admin_password']

  def index
    @categories = Category.all
    # @products = @category.products.order(created_at: :desc)
  end

  def new
    @category = category.new
  end

  def create
    @category = category.new(category_params)

    if @category.save
      redirect_to [:admin, :products], notice: 'Product created!'
    else
      render :new
    end
  end

  # def product_params
  #   params.require(:product).permit(
  #     :name,
  #     :description,
  #     :category_id,
  #     :quantity,
  #     :image,
  #     :price
  #   )
  # end

end
