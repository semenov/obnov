class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
    
  field :text
  embedded_in :post, :inverse_of => :comments
end
