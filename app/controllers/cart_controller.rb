class CartController < ApplicationController
  before_action :initialize_session

  def show
    product_ids = Array.new
    session[:shopping_cart].each { |e| product_ids << e['id'].to_i }
    @products = Product.find(product_ids)
  end

  def delete_product_from_cart
    id = params[:id].to_i
    product = session[:shopping_cart].find {|prod| prod['id'] == id}
    session[:shopping_cart].delete(product)
    flash[:notice] = "Succesfully deleted product from cart."
    redirect_back(fallback_location: show_cart_path)
  end

  def initialize_session
    session[:shopping_cart] ||= []
  end
end
