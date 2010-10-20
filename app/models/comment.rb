class Comment
  include Mongoid::Document
  field :text
  embedded_in :update, :inverse_of => :comments
end
