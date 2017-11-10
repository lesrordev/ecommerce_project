class ProductController < ApplicationController
  def show
    # @product = Product.find(params[:id])
    @product = Product.where(id: params[:id]).first
  end
end
