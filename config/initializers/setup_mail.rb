ActionMailer::Base.smtp_settings = {
  :address              => "smtp.mandrillapp.com",
  :port                 => 587,
  :domain               => "mandrillapp.com",
  :user_name            => ENV["USERNAME"],
  :password             => ENV["API_KEY"]
}