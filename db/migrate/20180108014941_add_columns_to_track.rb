class AddColumnsToTrack < ActiveRecord::Migration[5.0]
  def change
    add_column :tracks, :album_name, :string
    add_column :tracks, :album_id, :string
    add_column :tracks, :album_img_url, :string
    add_column :tracks, :preview_url, :string
    add_column :tracks, :track_number, :integer
    add_column :tracks, :release_date, :datetime
  end
end
