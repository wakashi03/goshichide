class AddIconToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :icon, :string
  end
end
