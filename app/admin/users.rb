ActiveAdmin.register User do
	index do
	  column :name
	  column :email
	  column "Date joinned",:created_at
	  column :location 
	  column :description
	 default_actions
	end  
  
end
