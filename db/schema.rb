# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2024_12_18_174627) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "match_histories", force: :cascade do |t|
    t.bigint "first_player_id"
    t.bigint "second_player_id"
    t.integer "first_player_points"
    t.integer "second_player_points"
    t.integer "first_player_elo"
    t.integer "second_player_elo"
    t.integer "elo_change"
    t.bigint "winner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["first_player_id"], name: "index_match_histories_on_first_player_id"
    t.index ["second_player_id"], name: "index_match_histories_on_second_player_id"
    t.index ["winner_id"], name: "index_match_histories_on_winner_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.integer "elo"
    t.integer "win_streak"
    t.integer "total_match"
    t.integer "total_win_match"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_users_on_name", unique: true
  end

  add_foreign_key "match_histories", "users", column: "first_player_id"
  add_foreign_key "match_histories", "users", column: "second_player_id"
  add_foreign_key "match_histories", "users", column: "winner_id"
end
