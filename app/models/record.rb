class Record
  include Mongoid::Document
  include Mongoid::Timestamps
  has_many :items
  belongs_to :user
end
