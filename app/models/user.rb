class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :icon, IconUploader

  has_many :senryus, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_senryus, through: :favorites, source: :senryu
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true, presence: true
  validates :name, presence: true, length: { maximum: 255 }

  def own?(object)
    id == object.user_id
  end

  def favorite(senryu)
    favorite_senryus << senryu
  end

  def unfavorite(senryu)
    favorite_senryus.destroy(senryu)
  end

  def favorite?(senryu)
    favorite_senryus.include?(senryu)
  end
end
