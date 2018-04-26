class CreateProgressweapons < ActiveRecord::Migration[5.1]
  def change
    create_table :progressweapons do |t|
      t.integer :progress_id
      t.integer :weapon_id

      t.timestamps
    end
  end
end
