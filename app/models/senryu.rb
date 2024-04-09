class Senryu < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :kamigo, presence: true, length: { maximum: 10 }
  validates :nakashichi, presence: true, length: { maximum: 10 }
  validates :shimogo, presence: true, length: { maximum: 10 }

  include PgSearch::Model
  pg_search_scope :search_by_all_parts,
                  against: %i[kamigo nakashichi shimogo],
                  using: {
                    tsearch: { prefix: true }
                  }

  # お気に入りの数に基づいて川柳をランキングするクラスメソッド
  def self.ranked_by_favorites
    all_senryus = where('favorites_count > 0').order(favorites_count: :desc)
    rank = 0
    ranked_senryus = all_senryus.chunk { |senryu| senryu.favorites_count }
                                .flat_map do |favorites_count, senryus|
                                  rank += 1
                                  senryus.map { |senryu| [rank, senryu] }
                                end
    ranked_senryus.take_while { |rank, _senryu| rank <= 3 }
  end
end
