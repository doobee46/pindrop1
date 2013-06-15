class RegistrationsController < Devise::RegistrationsController

  def create
    super
    UserMailer.registration_confirmation(@user).deliver
  end

end