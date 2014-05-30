class AddPrivateToGlossaries < ActiveRecord::Migration
  def change
    add_column :glossaries, :private, :boolean, default: false
  end
end
