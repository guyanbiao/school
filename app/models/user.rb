class User
  include Mongoid::Document
  field :email
  field :name
  validates_presence_of :email
  validates_presence_of :name
  has_many :records
  has_many :rankings
  has_many :poi_recs
  has_many :items
  def self.create_from_omniauth(auth)
    create! do |user|
      user.name = auth['info']['nickname']
      user.email = auth['info']['email']
    end
  end
end
