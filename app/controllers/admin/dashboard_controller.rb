class Admin::DashboardController < ApplicationController
  
  http_basic_authenticate_with name: ENV['admin_name'], password: ENV['admin_password']

  def show
    @products = Product.all.count()
    @categories = Category.all.count()
  end

end
