class CreateGlossaries < ActiveRecord::Migration
  def change
    create_table :glossaries do |t|
      t.string :name, null: false
      t.string :description
      t.belongs_to :user
      t.timestamps
    end
  end
end
