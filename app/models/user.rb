class User
  include Mongoid::Document
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  field :name
  references_many :owned_streams, :class_name => "Stream"
  references_many :posts
  references_many :comments
  references_many :streams, :class_name => "Stream", :stored_as => :array, :inverse_of => :streams
end
