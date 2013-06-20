class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      sign_in(@user)
      redirect_to pins_url, notice: 'Sign in successfull'
      set_flash_message(:notice, :success, :kind => "sign in successfuly") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end