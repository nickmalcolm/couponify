class DiscountsController < ApplicationController
  
  around_filter :shopify_session
  
  def index
    @discounts = current_shop.discounts.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @discount = current_shop.discounts.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

end
