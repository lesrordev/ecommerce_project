class HomeController < ApplicationController
  def index
    if params[:search]
      @products = Product.search(params[:search]).order(:name).page params[:page]
    else
      @products = Product.order(:name).page params[:page]
    end
  end
end
