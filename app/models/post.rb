class Post < ApplicationRecord
  belongs_to :user
  has_many :marks
  belongs_to :address
end
