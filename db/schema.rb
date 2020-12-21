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

ActiveRecord::Schema.define(version: 2020_12_08_230520) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "beach_sensors", force: :cascade do |t|
    t.integer "sensor_type"
    t.geometry "location", limit: {:srid=>4326, :type=>"st_point"}
    t.integer "random_ceil"
    t.integer "random_floor"
    t.integer "random_seed"
    t.integer "random_std_dev"
    t.boolean "alive"
    t.boolean "fixed"
    t.integer "fixed_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "service_group_id", null: false
    t.integer "beach_id"
    t.integer "period"
    t.index ["service_group_id"], name: "index_beach_sensors_on_service_group_id"
  end

  create_table "bus_sensors", force: :cascade do |t|
    t.string "line"
    t.string "subline"
    t.string "direction"
    t.boolean "alive"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "service_group_id", null: false
    t.integer "location_index"
    t.index ["service_group_id"], name: "index_bus_sensors_on_service_group_id"
  end

  create_table "detours", force: :cascade do |t|
    t.string "line"
    t.string "subline"
    t.string "direction"
    t.integer "location_index"
    t.geometry "location", limit: {:srid=>4326, :type=>"st_point"}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "service_groups", force: :cascade do |t|
    t.string "apikey"
    t.boolean "is_beach"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "simulator_processes", force: :cascade do |t|
    t.string "job_id"
    t.boolean "is_beach"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "beach_sensors", "service_groups"
  add_foreign_key "bus_sensors", "service_groups"
end
