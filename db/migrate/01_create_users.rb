class CreateUsers < ActiveRecord::Migration[5.1]

    def change
        create_table :users do |t|
            t.string :username
            t.string :email_address
            t.string :password
            t.integer :high_score
        end
    end
end