class CreateDefinitions < ActiveRecord::Migration
  def change
    create_table :definitions do |t|
      t.string :entry, null: false
      t.string :name, null: false
      t.belongs_to :tib_term
      t.timestamps
    end
  end
end
