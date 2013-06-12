class FollowsController < ApplicationController

	def show_follower
		@user =User.find(params[:user_id])
		current_user.all_follows(@user)
		respond_to do |format|
	     format.html # index.html.erb
	    end
	end
 
	def create
		@user = User.find(params[:user_id])
		current_user.follow(@user)
		respond_to do |format|
		format.js { render 'shared/ajax-progress' } 
      end  	
	end
	 
	def destroy
		@user = User.find(params[:user_id])
		current_user.stop_following(@user)
		respond_to do |format|
		format.js { render 'shared/ajax-progress' }
      end  	
	end

end