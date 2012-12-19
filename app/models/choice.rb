class Choice
  include Mongoid::Document
  field :text
  field :tips
  field :choices
  field :answer
  has_many :items
  has_and_belongs_to_many :points
end