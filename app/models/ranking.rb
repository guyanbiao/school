class Ranking
  include Mongoid::Document
  field :point_id
  field :user_id
  field :score, type: Integer, default: 0
  belongs_to :point
  belongs_to :user
end
