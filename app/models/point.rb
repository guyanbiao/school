class Point
  include Mongoid::Document
  field :core
  field :type
  field :meaning
  has_and_belongs_to_many :cloze_children
  has_many :rankings
  has_many :poi_recs
end
