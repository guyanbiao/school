class ClozeChild
  include Mongoid::Document
  field :position
  field :choices
  field :answer
  field :tips
  belongs_to :cloze
  has_many :items, :dependent => :destroy
  has_and_belongs_to_many :points
  accepts_nested_attributes_for :points
end
