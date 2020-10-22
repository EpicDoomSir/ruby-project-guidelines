class CreateAsteroids < ActiveRecord::Migration[6.0]
  def change
    create_table :asteroids do |t|
      t.integer :hp
      t.integer :size

      t.timestamps
    end
  end
end
