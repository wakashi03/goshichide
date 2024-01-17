class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :senryu

  validates :user_id, uniqueness: { scope: :senryu_id }
end
