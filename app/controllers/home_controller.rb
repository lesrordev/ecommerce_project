class HomeController < ApplicationController
  before_action :initialize_session

  def index
    search_param = params[:search]

    if search_param
      @products = Product.search(search_param).order(:name).page params[:page]
    else
      @products = Product.order(:name).page params[:page]
    end
  end

  def add_product_to_cart
    product = {id: params[:id].to_i, quantity: 1}
    session[:shopping_cart] << product unless session[:shopping_cart].include?(product)
    flash[:notice] = 'Successfully added to shopping cart.'
    redirect_back(fallback_location: root_path)
  end

  def initialize_session
    session[:shopping_cart] ||= []
  end
end
