class Cloze
  include Mongoid::Document
  field :file
  field :text, type: String
  field :questions, type: Array
  field :grade, type: Integer
  has_many :cloze_children
end
