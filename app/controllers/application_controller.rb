class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
# ...
  hide_action :current_user
  protect_from_forgery

end
