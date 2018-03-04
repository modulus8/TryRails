class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.string :user_name, default: "anonym"
      t.string :feeling, default: "none"
      t.integer :track_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
