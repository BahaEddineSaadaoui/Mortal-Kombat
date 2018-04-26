class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
      t.attachment :url
      t.integer :fighter_id
      t.integer :weapon_id
      
      t.timestamps
    end
  end
end
