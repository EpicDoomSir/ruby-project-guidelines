class CreateShips < ActiveRecord::Migration[5.1]

    def change
        create_table :ships do |t|
            t.integer :user_id
            t.integer :game_id 
            t.string :hp
            t.integer :shield
            t.integer :scores
        end
    end
end