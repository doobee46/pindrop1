class Pin < ActiveRecord::Base
  is_impressionable 
  opinio_subjectum
  include PublicActivity::Common
# tracked except: :update, owner: ->(controller, model) { controller && controller.current_user }
  attr_accessible :description, :image, :image_remote_url, :price

  validates :description, presence: true
  validates :user_id, presence: true
  validates_attachment :image, presence: true,
  							  content_type: {content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image.gif']},
  							  size:{less_than: 5.megabytes}
  belongs_to :user
  has_attached_file :image, styles: {medium: "320x240>", :thumb => "100x100>", :large => "357x443>"}

  scope :published, where("pins.created_at IS NOT NULL ")
  scope :recent, lambda{published.where("pins.created_at > ?", 1.week.ago.to_date).limit(4)}
  

  letsrate_rateable "like"

  acts_as_followable
 
  def image_remote_url=(url_value)
  	self.image = URI.parse(url_value)unless url_value.blank?
  	super	
  end
  
  def time
    time_ago_in_words(user.created_at)
    
  end

  def self.search(search)
    if search
      find(:all, :conditions => ['description LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

  def currency_display
   
  end 
  

end
