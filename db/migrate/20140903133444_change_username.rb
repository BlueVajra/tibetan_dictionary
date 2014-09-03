class ChangeUsername < ActiveRecord::Migration
  def change
    change_column :users, :username, :string, null: false, unique: true
  end
end
