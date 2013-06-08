class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  acts_as_follower
  acts_as_followable

  validates :description, :length => { :maximum => 140 }
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :acts_as_follower, :location, :description
  # attr_accessible :title, :body

  has_many :pins,  :order => "created_at Desc",
                   :dependent => :destroy 

  letsrate_rater

  def gravatar_url
	  stripped_email = email.strip
	  downcased_email = stripped_email.downcase
	  hash = Digest::MD5.hexdigest(downcased_email)

	  "http://gravatar.com/avatar/#{hash}"

  end



end
