class AddPlaylistIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :playlist_id, :string
  end
end
