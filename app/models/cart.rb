class Cart < ActiveRecord::Base
 
  has_many :line_items, :dependent => :destroy

   def add_pin(pin_id)
	   	current_item = line_items.where(:pin_id => pin_id).first
	   	if current_item
	   		current_item.quantity += 1
	   	else
	   	  current_item =line_items.build(:pin_id => pin_id)
	   	end
	   	current_item   	
   end
   
   def total_price
     line_items.to_a.sum {|item| item.total_price}
   end
   
end
