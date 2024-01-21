class Senryu < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :kamigo, presence: true, length: { maximum: 10 }
  validates :nakashichi, presence: true, length: { maximum: 10 }
  validates :shimogo, presence: true, length: { maximum: 10 }

  scope :ranked_by_favorites, lambda {
    select('senryus.*, COUNT(favorites.id) AS favorites_count')
      .joins(:favorites)
      .group('senryus.id')
      .order('favorites_count DESC')
  }
end
