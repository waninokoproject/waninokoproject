class Post < ApplicationRecord
  validates :tweet, {presence: true, length: {maximum: 140}}

  #DBのアソシエーション(関連付け)
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
end
