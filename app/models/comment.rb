class Comment
  include Mongoid::Document
  field :text
  embedded_in :post, :inverse_of => :comments
end
