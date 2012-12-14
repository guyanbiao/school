class PoiRec
  include Mongoid::Document
  belongs_to :user
  belongs_to :point
  has_and_belongs_to_many :records, inverse_of: nil
end
