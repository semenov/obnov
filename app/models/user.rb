class User
  include Mongoid::Document
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  field :name
  references_many :owned_streams, :class_name => "Stream", :inverse_of => :user
  references_many :posts
  references_and_referenced_in_many :streams, :class_name => "Stream", :inverse_of => :members
  references_and_referenced_in_many :pending_streams, :class_name => 'Stream', :inverse_of => :applicants
end
