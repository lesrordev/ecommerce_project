class HomeController < ApplicationController
  def index
    search_param = params[:search]

    if search_param
      @products = Product.search(search_param).order(:name).page params[:page]
    else
      @products = Product.order(:name).page params[:page]
    end
  end
end
