class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :pin_id, :pin, :quantity
  belongs_to :pin
  belongs_to :cart

  def total_price
  	pin.price*quantity
  end
  
end
