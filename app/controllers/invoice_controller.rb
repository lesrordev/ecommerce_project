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
    amount = params[:total].to_i

    @customer = create_stripe_customer
    @charge = create_stripe_charge(amount)

    verify_payment(@charge, amount)

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
    return unless params[:address].blank? || params[:city].blank? ||
                  params[:postal_code].blank?
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

  def create_stripe_customer
    Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )
  end

  def create_stripe_charge(amount)
    Stripe::Charge.create(
      customer: @customer.id,
      amount: amount,
      description: 'Rails Stripe customer',
      currency: 'cad'
    )
  end

  def verify_payment(charge, amount)
    message = 'Payment not completed.'

    if charge.paid && charge.amount == amount
      save_order

      # TO DO: Save stripe customer id
      # stripe_customer_id = @customer.id

      # Clean shopping_cart session
      session.delete(:shopping_cart)

      message = 'Order payment completed.'
    end

    flash[:notice] = message
  end

  def save_order
    province = Province.find(session[:address]['region'].to_i)

    # Store order in database
    Order.create(status: 'paid', pst: province.pst, gst: province.gst,
                 hst: province.hst, customer_id: 1)

    save_order_items(Order.last.id)
  end

  def save_order_items(order_id)
    session[:shopping_cart].each do |cart|
      product = Product.find(cart['id'].to_i)

      OrderItem.create(quantity: cart['quantity'].to_i, price: product.price,
                       product_id: product.id, order_id: order_id)
    end
  end
end
