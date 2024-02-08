class AddFavoritesCountToSenryus < ActiveRecord::Migration[7.1]
  def change
    add_column :senryus, :favorites_count, :integer, default: 0
  end
end
