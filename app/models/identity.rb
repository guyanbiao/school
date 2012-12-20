class Identity
  include Mongoid::Document
  include OmniAuth::Identity::Models::Mongoid
  validates_presence_of :name
  field :email, type: String
    field :name, type: String
      field :password_digest
end
