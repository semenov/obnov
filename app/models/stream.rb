class Stream
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name
  field :slug
  referenced_in :user, :inverse_of => :owned_streams
  references_and_referenced_in_many :members, :class_name => 'User', :inverse_of => :streams
  references_and_referenced_in_many :applicants, :class_name => 'User', :inverse_of => :pending_streams
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
  
  def is_applicant?(user)
    self.applicants.include? user
  end
  
  def accept_application(user)
    self.applicants.delete user
    self.members.push user
    self.save
  end
  
  def decline_application(user)
    self.applicants.delete user
    self.save
  end
  
  protected
  
  def add_owner_to_members
    self.members.push self.user
    self.save
  end
  
end
