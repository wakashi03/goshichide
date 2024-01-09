class CreateSenryus < ActiveRecord::Migration[7.1]
  def change
    create_table :senryus do |t|
      t.string :kamigo, null: false
      t.string :nakashichi, null: false
      t.string :shimogo, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
