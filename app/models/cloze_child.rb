class ClozeChild
  include Mongoid::Document
  field :position
  field :choices
  field :answer
  field :tips
  belongs_to :cloze
  has_and_belongs_to_many :points
  has_and_belongs_to_many :records
end
