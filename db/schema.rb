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

ActiveRecord::Schema.define(version: 2020_03_09_131103) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exams", force: :cascade do |t|
    t.string "name"
    t.string "patient"
    t.string "subsample_label"
    t.bigint "fish_slice_id", null: false
    t.date "start_date"
    t.integer "genomico_exam_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["fish_slice_id"], name: "index_exams_on_fish_slice_id"
  end

  create_table "slices", force: :cascade do |t|
    t.integer "responsible_id"
    t.string "responsible_login"
    t.date "date"
    t.integer "subsample_id"
    t.string "subsample_label"
    t.integer "probe"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "genomico_exam_id"
  end

  add_foreign_key "exams", "slices", column: "fish_slice_id"
end
