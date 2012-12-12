class Cloze
  include Mongoid::Document
  field :file
  field :text, type: String
  field :questions, type: Array
  field :grade, type: Integer
end
