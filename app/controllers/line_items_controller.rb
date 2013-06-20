class LineItemsController < InheritedResources::Base
	
	def create
		@cart = current_cart
		pin   = Pin.find_by_id(params[:pin_id])
		@line_item = @cart.add_pin(pin.id)
	   respond_to do |format|
	   	if @line_item.save
	   	format.html {redirect_to(@line_item.cart)}
        else 
        format.html { render :action =>" new"}
          end
       end
    end





end
