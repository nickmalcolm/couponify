class Customer < ActiveRecord::Base
  
  validates :email, :presence => true
  
  def matches?(dt)
    true
  end
  
end
