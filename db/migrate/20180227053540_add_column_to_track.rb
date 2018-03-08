class AddColumnToTrack < ActiveRecord::Migration[5.0]
  def change
    add_column :tracks, :played_at, :datetime
  end
end
