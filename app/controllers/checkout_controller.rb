class CheckoutController < ApplicationController
  before_action :initialize_session

  def show
    @province_options = []
    @provinces = Province.all

    @provinces.each { |e| @province_options << [e.name, e.id] }
  end

  def initialize_session
    session[:shopping_cart] ||= []
  end
end
