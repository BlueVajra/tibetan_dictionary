class AddIndexes < ActiveRecord::Migration
  def change
    add_index :glossaries, :id
    add_index :tib_terms, :wyl
    add_index :definitions, :id
  end
end
