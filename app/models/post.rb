class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :content
  embeds_many :comments
  referenced_in :stream, :inverse_of => :posts, :index => true
  referenced_in :user
  scope :activity, :order_by => [:created_at, :desc]
end
