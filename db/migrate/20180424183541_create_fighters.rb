class CreateFighters < ActiveRecord::Migration[5.1]
  def change
    create_table :fighters do |t|

      t.string :name, null: false
      t.integer :photo_id
      t.integer :experience, default: 0
      t.boolean :is_fighting, default: false
      t.integer :progress_id

      t.timestamps
    end
  end
end
