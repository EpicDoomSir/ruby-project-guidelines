class CreateAsteroids < ActiveRecord::Migration[5.1]

    def change
        create_table :asteroids do |t|
            t.integer :game_id
            t.integer :hp
            t.integer :size
        end
    end
end