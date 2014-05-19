class ChangeDefinitionsTable < ActiveRecord::Migration
  def change
    change_table :definitions do |t|
      t.remove :name
      t.belongs_to :glossary
    end
  end
end
