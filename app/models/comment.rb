class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
    
  field :content
  embedded_in :post, :inverse_of => :comments
end
