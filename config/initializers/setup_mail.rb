ActionMailer::Base.smtp_settings = {
  :address              => "smtp.mandrillapp.com",
  :port                 => 587,
  :domain               => "mandrillapp.com",
  :user_name            => MANDRILL_CONFIG['username'],
  :password             => MANDRILL_CONFIG['api_key']
}