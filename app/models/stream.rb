class Stream
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name
  referenced_in :user
  references_many :members, :class_name => "User", :stored_as => :array, :inverse_of => :streams
  references_many :posts
  after_create :add_owner_to_members
  
  protected
  
  def add_owner_to_members
    self.members << self.user
  end
end
