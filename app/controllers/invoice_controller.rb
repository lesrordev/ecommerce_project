class InvoiceController < ApplicationController
  before_action :initialize_session

  def index
    check_address_inputs
    @shopping_cart = session[:shopping_cart]
    @total = calculate_total_before_taxes(@shopping_cart)
    @total = calculate_total_after_taxes(@total, params[:region])
    @description = 'Enter your card information'
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
      # stripe_customer_id = @customer.id

      # Clean shopping_cart session
      session.delete(:shopping_cart)

      flash[:notice] = 'Order payment completed.'
    else
      flash[:notice] = 'Payment not completed.'
    end

    redirect_to root_path
  rescue Stripe::CardError => e
    flash[:notice] = e.message
    redirect_to invoice_index_path
  end

  def initialize_session
    session[:shopping_cart] ||= []
    session[:address] ||= []
  end

  def check_address_inputs
    return unless params[:address].blank? || params[:city].blank? || params[:postal_code].blank?
    flash[:notice] = 'Error in the address.'
    redirect_to show_checkout_path
  end

  def create_address_session
    session[:address] = { address: params[:address],
                          city: params[:city],
                          region: params[:region],
                          postal_code: params[:postal_code] }
  end

  def calculate_total_before_taxes(shopping_cart)
    total = 0

    shopping_cart.each do |cart|
      total += cart['quantity'].to_i * Product.find(cart['id']).price
    end

    total
  end

  def calculate_total_after_taxes(total, selected_province)
    province = Province.find(selected_province.to_i)
    total * (1 + province.pst + province.gst + province.hst)
  end
end
