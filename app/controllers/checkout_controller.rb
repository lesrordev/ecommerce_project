class CheckoutController < ApplicationController
  before_action :initialize_session

  def show

  end

  def save_address

  end

  def initialize_session
    session[:shopping_cart] ||= []
  end
end
