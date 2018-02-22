class AddColumnToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :spo_hash, :text
  end
end
