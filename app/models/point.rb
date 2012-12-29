class Point
  include Mongoid::Document
  field :core
  field :type
  field :meaning
  field :wiki
  has_and_belongs_to_many :cloze_children, :dependent => :destroy
  has_many :rankings
  has_many :poi_recs
  has_and_belongs_to_many :choices
end
