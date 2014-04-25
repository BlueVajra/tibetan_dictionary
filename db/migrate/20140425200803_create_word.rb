class CreateWord < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :tib, null: false, unique: true
      t.string :wyl, null: false, unique: true
      t.string :sort
    end
  end
end
