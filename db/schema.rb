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

ActiveRecord::Schema.define(version: 20180109040504) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coordinates", force: :cascade do |t|
    t.float "x", null: false
    t.float "y", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "desks", force: :cascade do |t|
    t.bigint "grouping_id"
    t.string "name"
    t.boolean "occupied", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "coordinate_id"
    t.index ["coordinate_id"], name: "index_desks_on_coordinate_id"
    t.index ["grouping_id"], name: "index_desks_on_grouping_id"
    t.index ["occupied"], name: "index_desks_on_occupied"
  end

  create_table "groupings", force: :cascade do |t|
    t.bigint "parent_grouping_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "coordinate_id"
    t.string "background_file_name"
    t.string "background_content_type"
    t.integer "background_file_size"
    t.datetime "background_updated_at"
    t.index ["coordinate_id"], name: "index_groupings_on_coordinate_id"
    t.index ["parent_grouping_id"], name: "index_groupings_on_parent_grouping_id"
  end

end
