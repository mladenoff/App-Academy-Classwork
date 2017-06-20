class CreateArtworks < ActiveRecord::Migration
  def change
    create_table :artworks do |t|
      t.string :title, null: false
      t.string :image_url, null: false
      t.integer :artist_id, null: false

      t.timestamps null: false
    end

    add_index :artworks, [:title, :artist_id], unique: true

  end
end
