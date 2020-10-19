class CreateShips < ActiveRecord::Migration[5.1]

    def change
        create_table :ships do |t|
            t.integer :user_id
            t.integer :game_id 
            t.integer :hp
            t.integer :scores
        end
    end
end