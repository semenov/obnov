class User
  include Mongoid::Document
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
  
  validates_presence_of :name
  validates_presence_of :password, :on => :create
  validates :email,   
    :presence => true,   
    :uniqueness => true,   
    :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }  
  
  field :name
  references_many :owned_streams, :class_name => "Stream", :inverse_of => :user
  references_many :posts
  references_and_referenced_in_many :streams, :class_name => "Stream", :inverse_of => :members
  references_and_referenced_in_many :pending_streams, :class_name => 'Stream', :inverse_of => :applicants
end
