class Choice
  include Mongoid::Document
  include Mongoid::Timestamps
  field :text
  field :tips
  field :choices
  field :answer
  field :passed, :type => Boolean, :default => false
  has_many :items
  has_and_belongs_to_many :points 
  accepts_nested_attributes_for :points
end
