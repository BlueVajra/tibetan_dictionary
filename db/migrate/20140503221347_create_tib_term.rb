class CreateTibTerm < ActiveRecord::Migration
  def change
      create_table :tib_terms do |t|
      t.string :tib, unique: true
      t.string :wyl, null: false, unique: true
    end
  end
end
