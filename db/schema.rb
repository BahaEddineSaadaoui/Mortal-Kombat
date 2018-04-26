# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180424193536) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fighters", force: :cascade do |t|
    t.string "name", null: false
    t.integer "photo_id"
    t.integer "experience", default: 0
    t.boolean "is_fighting", default: false
    t.integer "progress_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fights", force: :cascade do |t|
    t.integer "winner_id"
    t.integer "loser_id"
    t.text "log"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photos", force: :cascade do |t|
    t.string "url_file_name"
    t.string "url_content_type"
    t.integer "url_file_size"
    t.datetime "url_updated_at"
    t.integer "fighter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "progresses", force: :cascade do |t|
    t.integer "lifes"
    t.integer "damages"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "progresses_weapons", id: false, force: :cascade do |t|
    t.bigint "progress_id", null: false
    t.bigint "weapon_id", null: false
    t.index ["progress_id", "weapon_id"], name: "index_progresses_weapons_on_progress_id_and_weapon_id"
  end

  create_table "progressweapons", force: :cascade do |t|
    t.integer "progress_id"
    t.integer "weapon_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weapons", force: :cascade do |t|
    t.string "name", null: false
    t.integer "photo_id"
    t.integer "damage_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
