class CartsController < InheritedResources::Base
	include Current_Cart
	before_action :set_cart, only: [:new, :create] 

	def index
		@pin=Pin.all
    end 

   def show
    begin
    	@cart = Cart.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_to pin_url, :notice => 'invalid cart'
    else
      respond_to do |format|
      	format.html #show.html.erb
      end 
    end
   end 

   def destroy
   	@cart = current_cart
   	@cart.destroy
   	session[:cart_id]= nil
   	respond_to do |format|
   		format.html {redirect_to(pin_url, notice => 'Your cart is currently empty')}
   	end
   end
end
