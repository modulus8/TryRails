class CreateTracks < ActiveRecord::Migration[5.0]
  def change
    create_table :tracks do |t|
      t.string :name, null: false
      t.string :t_id, null: false, uniq: true
      t.string :artist_name

      t.timestamps
    end
  end
end
