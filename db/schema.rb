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

ActiveRecord::Schema[7.0].define(version: 2023_05_31_113058) do
  create_table "games", force: :cascade do |t|
    t.boolean "is_active"
    t.string "question"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "question_id"
    t.integer "hints_count"
    t.index ["question_id"], name: "index_games_on_question_id"
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "hints", force: :cascade do |t|
    t.string "text"
    t.integer "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_hints_on_game_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "text"
    t.integer "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "answer"
    t.string "string"
    t.index ["game_id"], name: "index_questions_on_game_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "telegram_id", null: false
    t.string "first_name", null: false
    t.string "username"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "games", "questions"
  add_foreign_key "games", "users"
  add_foreign_key "hints", "games"
  add_foreign_key "questions", "games"
end
