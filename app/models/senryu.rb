class Senryu < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :kamigo, presence: true, length: { maximum: 10 }
  validates :nakashichi, presence: true, length: { maximum: 10 }
  validates :shimogo, presence: true, length: { maximum: 10 }

  def self.ranked_by_favorites
    all.select { |senryu| senryu.favorites_count > 0 }
       .group_by(&:favorites_count)
       .sort_by { |favorites_count, _senryus| -favorites_count }
       .flat_map.with_index(1) do |(_favorites_count, senryus), index|
      senryus.map { |senryu| [index, senryu] }
    end
  end
end
