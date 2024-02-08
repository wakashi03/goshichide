class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :senryu, counter_cache: true

  validates :user_id, uniqueness: { scope: :senryu_id }
end
