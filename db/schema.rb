# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_22_225954) do

  create_table "asteroids", force: :cascade do |t|
    t.integer "hp"
    t.integer "size"
    t.integer "rock"
    t.integer "rock_x"
    t.integer "rock_y"
    t.boolean "reached_end"
    t.boolean "collided"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "games", force: :cascade do |t|
    t.string "difficulty"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "players"
    t.integer "start_timer"
    t.boolean "started"
    t.integer "finish_flag"
  end

  create_table "ships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "game_id"
    t.integer "hp"
    t.integer "scores"
    t.integer "position_x"
    t.integer "position_y"
    t.string "direction"
    t.integer "start_time"
    t.integer "player_option"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email_address"
    t.string "password"
    t.integer "high_score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
