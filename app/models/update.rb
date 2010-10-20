class Update
  include Mongoid::Document
  field :data_type
  field :status
  field :created_at, :type => DateTime
  embeds_many :comments
  referenced_in :stream, :inverse_of => :updates, :index => true
end
