class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :title
      t.text :body, null: false
      t.belongs_to :user, null: false
      t.belongs_to :tib_term, null: false
      t.index :user_id
      t.index :tib_term_id
      t.timestamps
    end
  end
end
