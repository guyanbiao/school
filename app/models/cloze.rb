class Cloze
  include Mongoid::Document
  include Mongoid::Timestamps
  field :html
  field :grade, type: Integer
  field :passed, type: Boolean, :default => false 
  has_many :cloze_children, :dependent => :destroy, :order => 'position ASC'
  accepts_nested_attributes_for :cloze_children
end
