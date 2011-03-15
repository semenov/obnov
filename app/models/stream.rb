class Stream
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name
  references_many :posts
end
