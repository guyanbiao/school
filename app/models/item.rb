class Item
  include Mongoid::Document
  field :type
  field :answer
  field :correct
  field :point_ids
  belongs_to :record
  belongs_to :user
  belongs_to :cloze_child 
  belongs_to :choice
end
