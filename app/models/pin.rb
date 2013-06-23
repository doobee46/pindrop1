class Pin < ActiveRecord::Base
  attr_accessible :description, :image, :image_remote_url, :price, :private, :count
  letsrate_rateable "like"
  acts_as_followable
  acts_as_voteable
  is_impressionable :counter_cache => { :count => :count, :unique => true } 
  opinio_subjectum
  include PublicActivity::Common
# tracked except: :update, owner: ->(controller, model) { controller && controller.current_user }
 
  validates :description, presence: true
  validates :user_id, presence: true
  validates_attachment :image, presence: true,
  							  content_type: {content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image.gif']},
  							  size:{less_than: 5.megabytes}
  belongs_to :user
  has_attached_file :image, styles: {medium: "320x240>", :thumb => "100x100>", :large => "357x443>"}

  scope :published, where("pins.created_at IS NOT NULL ")
  scope :recent, lambda{published.where("pins.created_at > ?", 1.week.ago.to_date).limit(4)}
  scope :buy, where("pins.price IS NOT NULL")
  scope :popular ,Pin.joins(:impressions).where("pins.count < 20")
  
  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  # ensure that there no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    if line_items.count.zero?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end 
 

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

 
 

end
