class CartController < ApplicationController
  before_action :initialize_session

  def show
    @products = Product.find(session[:shopping_cart])
  end

  def delete_product_from_cart
    id = params[:id].to_i
    session[:shopping_cart].delete(id)
    flash[:notice] = "Succesfully deleted product from cart."
    redirect_back(fallback_location: show_cart_path)
  end

  def initialize_session
    session[:shopping_cart] ||= []
  end
end
