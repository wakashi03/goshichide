class AddNameToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string

    User.find_each do |user|
      user.update(name: "#{user.first_name} #{user.last_name}")
    end
    
    remove_column :users, :first_name, :string
    remove_column :users, :last_name, :string
  end
end
