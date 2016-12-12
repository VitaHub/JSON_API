class AddressSerializer < ActiveModel::Serializer
  attributes :ip
  has_many :users, key: :login
end
