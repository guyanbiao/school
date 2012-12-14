class Record
  include Mongoid::Document
  include Mongoid::Timestamps
  field :type
  field :items
  belongs_to :user
  has_and_belongs_to_many :cloze_children
end
