class CheckoutController < ApplicationController
  before_action :initialize_session

  def show
    @province_options = Array.new
    @provinces = Province.all

    @provinces.each { |e| @province_options << [e.name, e.id] }
  end

  def save_address

  end

  def initialize_session
    session[:shopping_cart] ||= []
  end
end
