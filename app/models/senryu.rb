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
end
