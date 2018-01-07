class AddSpoIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :spo_id, :string
  end
end
