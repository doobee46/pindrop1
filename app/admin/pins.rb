ActiveAdmin.register Pin do
	index do
      column :image
	  column :description
	  column "Date Pinned",:created_at
	  column :price do |pin|
	   number_to_currency pin.price  
	  end 
	   default_actions
	end 

	index :as => :grid do |pin|
    link_to(image_tag(pin.image(:thumb)), admin_pin_path(pin))
  end 

end


