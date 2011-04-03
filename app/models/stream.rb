class Stream
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name
  field :slug
  referenced_in :user
  references_many :members, :class_name => "User", :stored_as => :array, :inverse_of => :streams
  references_many :posts
  after_create :add_owner_to_members
  
  validates_format_of :slug, :with => /[A-Za-z0-9-]/
  validates_uniqueness_of :slug
  
  def to_param
    self.slug
  end
  
  def self.find_by_slug(slug)
    find(:first, :conditions => { :slug => slug })
  end
  
  protected
  
  def add_owner_to_members
    self.members << self.user
  end
  
end
