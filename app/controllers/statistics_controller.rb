class StatisticsController < ApplicationController
  
  def index
    @used   = current_shop.discounts.used
    @unused  = current_shop.discounts.unused
    arr = []
    Order.sum(:total_price, :group => "DATE(created_at)", :conditions => "discount_code IS NOT NULL").each {|k,v| arr << ["#{k.strftime("%d-%b-%y")}", v.to_f]}
    @sales_value = arr
    arr = []
    Order.count(:group => "DATE(created_at)", :conditions => "discount_code IS NOT NULL").each {|k,v| arr << ["#{k.strftime("%d-%b-%y")}", v.to_i]}
    @sales_count = arr
  end
  
end
