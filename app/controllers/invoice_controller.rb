class InvoiceController < ApplicationController
  before_action :initialize_session

  def index
    product_ids = Array.new
    session[:shopping_cart].each { |e| product_ids << e['id'].to_i }
    @products = Product.find(product_ids)
    @shopping_cart = session[:shopping_cart]

    subtotal = 0
    @products.each do |product|
      quantity = @shopping_cart.find { |cart| product.id == cart['id'] }['quantity'].to_i
      subtotal += quantity * product.price
    end

    province = Province.find(params[:region].to_i)
    pst = subtotal * province.pst
    gst = subtotal * province.gst
    hst = subtotal * province.hst

    @total = currency(subtotal + pst + gst + hst)
  end

  def pay
    # Store order in database


    # Clean shopping_cart session
    session.delete(:shopping_cart)
  end

  # Format a number as currency
  def currency(amount)
    format('$%.2f', amount)
  end
  helper_method :currency

  def initialize_session
    session[:shopping_cart] ||= []
    session[:address] ||= []
  end
end
