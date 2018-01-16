class CreatePlaylistProperties < ActiveRecord::Migration[5.0]
  def change
    create_table :playlist_properties do |t|
      t.integer :user_id, null: false
      t.string :style, null: false
      t.string :updown, null: false
      t.integer :key
      t.float :danceability
      t.float :energy
      t.float :speechiness
      t.float :acousticness
      t.float :instrumentalness
      t.float :liveness
      t.float :valence
      t.integer :duration_ms
      t.timestamps
    end
  end
end
