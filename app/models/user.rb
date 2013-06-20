class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :acts_as_follower, :location, :description, :provider, :uid
  #after_create :send_welcome_email
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  acts_as_voter
  acts_as_follower
  acts_as_followable
  letsrate_rater

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:facebook]

  validates :description, :length => { :maximum => 140 }

  has_many :pins,  :order => "created_at Desc",
                   :dependent => :destroy 

  def gravatar_url
	  stripped_email = email.strip
	  downcased_email = stripped_email.downcase
	  hash = Digest::MD5.hexdigest(downcased_email)

	  "http://gravatar.com/avatar/#{hash}"

  end

def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
  user = User.where(:provider => auth.provider, :uid => auth.uid).first
  unless user
    user = User.create(name:auth.extra.raw_info.name,
                         provider:auth.provider,
                         uid:auth.uid,
                         email:auth.info.email,
                         password:Devise.friendly_token[0,20]
                         )
  end
  user
end

def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
end


  
protected
  def confirmation_required?
    false
  end





end