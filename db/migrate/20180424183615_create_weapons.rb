class CreateWeapons < ActiveRecord::Migration[5.1]
  def change
    create_table :weapons do |t|
      t.string :name, null: false
      t.integer :photo_id
      t.integer :damage_level
      
      t.timestamps
    end
  end
end
