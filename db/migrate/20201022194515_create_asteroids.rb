class CreateAsteroids < ActiveRecord::Migration[6.0]
  def change
    create_table :asteroids do |t|
      t.integer :hp
      t.integer :size
      t.column :rock, 'blob'
      t.integer :rock_x
      t.integer :rock_y
      t.boolean :reached_end
      t.boolean :collided
      t.timestamps
    end
  end
end
