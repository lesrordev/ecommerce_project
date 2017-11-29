class InvoiceController < ApplicationController
  before_action :initialize_session

  def index
    @products = Array.new

    if (params[:address] == nil || params[:address] == "" || params[:city] == nil || params[:city] == "" || params[:postal_code] == nil || params[:postal_code] == "")
      flash[:error] = "Error in the address."
      redirect_to show_checkout_path
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

      @total = subtotal + pst + gst + hst

      @description = 'Enter your card information'
    end
  end

  def pay
    amount = params[:total].to_f * 100
    amount = amount.to_i

    @customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )

    @charge = Stripe::Charge.create(
      customer: @customer.id,
      amount: amount,
      description: 'Rails Stripe customer',
      currency: 'cad'
    )

    if @charge.paid && @charge.amount == amount
      province = Province.find(session[:address]['region'].to_i)

      # Store order in database
      Order.create(status: 'paid', pst: province.pst, gst: province.gst,
                    hst: province.hst, customer_id: 1)

      order_id = Order.last.id

      session[:shopping_cart].each do |item|
        product_id = item['id'].to_i
        quantity = item['quantity'].to_i
        product = Product.find(product_id)

        OrderItem.create(quantity: quantity, price: product.price,
                          product_id: product_id, order_id: order_id)
      end

      # TO DO: Save stripe customer id
      stripe_customer_id = @customer.id

      # Clean shopping_cart session
      session.delete(:shopping_cart)

      flash[:notice] = "Order payment completed."
    else
      flash[:error] = "Payment not completed."
    end

    redirect_to root_path

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to invoice_index_path
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
