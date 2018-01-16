class CreateTrackAnalyzes < ActiveRecord::Migration[5.0]
  def change
    create_table :track_analyzes do |t|
      t.integer :track_id, null: false
      t.integer :key
      t.float :danceability
      t.float :energy
      t.float :speechiness
      t.float :acousticness
      t.float :instrumentalness
      t.float :liveness
      t.float :valence
      t.integer :duration_ms
    end
  end
end
