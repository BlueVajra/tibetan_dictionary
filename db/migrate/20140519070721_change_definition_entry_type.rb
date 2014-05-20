class ChangeDefinitionEntryType < ActiveRecord::Migration
  def change
    change_column(:definitions, :entry, :text)
  end
end
