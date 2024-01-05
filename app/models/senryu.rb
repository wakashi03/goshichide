class Senryu < ApplicationRecord
  belongs_to :user

  validates :kamigo, presence: true, length: { maximum: 10 }
  validates :nakashichi, presence: true, length: { maximum: 10 }
  validates :shimogo,  presence: true, length: { maximum: 10 }
end
