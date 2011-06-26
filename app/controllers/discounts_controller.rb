class DiscountsController < ApplicationController
  
  around_filter :shopify_session
  
  def index
    @discounts = Discount.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @discount = Discount.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

end
