class AddSettingsToUser < ActiveRecord::Migration
  def change
    add_column :users, :settings, :hstore
  end
end
