class Stream
  include Mongoid::Document
  field :name
  references_many :posts
end
