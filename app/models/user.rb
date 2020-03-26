class User < ApplicationRecord
  validates :name, {presence: true}
  validates :mail, {presence: true}
  validates :passwd, {presence: true}

  has_many :posts, dependent: :destroy #ユーザ削除すると関係する投稿を削除
  has_many :likes, dependent: :destroy

end
