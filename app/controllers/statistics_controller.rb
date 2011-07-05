class StatisticsController < ApplicationController
  
  def index
    @used   = current_shop.discounts.used
    @unused  = current_shop.discounts.unused
  end
  
end
