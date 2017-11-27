class InvoiceController < ApplicationController
  before_action :initialize_session

  def index
    if params[:address] == nil || params[:address] == ""
      flash[:notice] = "Test."
      redirect_back(fallback_location: root_path)
    else
      session[:address] = { address: params[:address],
                            city: params[:city],
                            region: params[:region],
                            postal_code: params[:postal_code] }

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
  end

  def pay
    province = Province.find(session[:address]['region'].to_i)

    # Store order in database
    Order.create(status: 'new', pst: province.pst, gst: province.gst,
                  hst: province.hst, customer_id: 1)

    order_id = Order.last.id

    session[:shopping_cart].each do |item|
      product_id = item['id'].to_i
      quantity = item['quantity'].to_i
      product = Product.find(product_id)

      OrderItem.create(quantity: quantity, price: product.price,
                        product_id: product_id, order_id: order_id)
    end

    # Clean shopping_cart session
    session.delete(:shopping_cart)

    flash[:notice] = "Order registered."
    redirect_back(fallback_location: root_path)
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
