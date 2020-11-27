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

ActiveRecord::Schema.define(version: 2020_11_26_220354) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "beach_sensors", force: :cascade do |t|
    t.integer "type"
    t.geometry "location", limit: {:srid=>4326, :type=>"st_point"}
    t.string "ngsi_device_id"
    t.string "ngsi_entity_name"
    t.string "ngsi_entity_type"
    t.integer "random_ceil"
    t.integer "random_floor"
    t.integer "random_seed"
    t.integer "random_std_dev"
    t.boolean "alive"
    t.boolean "fixed"
    t.integer "fixed_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "bus_sensors", force: :cascade do |t|
    t.string "line"
    t.string "subline"
    t.string "direction"
    t.geometry "location", limit: {:srid=>4326, :type=>"st_point"}
    t.string "ngsi_device_id"
    t.string "ngsi_entity_name"
    t.string "ngsi_entity_type"
    t.boolean "alive"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
