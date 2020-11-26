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

ActiveRecord::Schema.define(version: 2020_11_26_220443) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "pgrouting"
  enable_extension "plpgsql"
  enable_extension "postgis"
  enable_extension "postgis_raster"
  enable_extension "postgis_topology"

  create_table "beach_sensors", force: :cascade do |t|
    t.geometry "location", limit: {:srid=>0, :type=>"st_point"}
    t.string "device_id"
    t.string "entity_name"
    t.string "entity_type"
    t.integer "random_ceil"
    t.integer "random_floor"
    t.integer "random_seed"
    t.integer "random_std_dev"
    t.boolean "alive"
    t.boolean "fixed"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "bus_sensors", force: :cascade do |t|
    t.string "line"
    t.string "subline"
    t.string "direction"
    t.geometry "location", limit: {:srid=>0, :type=>"st_point"}
    t.string "device_id"
    t.string "entity_name"
    t.string "entity_type"
    t.boolean "alive"
    t.boolean "fixed"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "desvios", id: :serial, force: :cascade do |t|
    t.text "device_id", null: false
    t.text "linea", null: false
    t.text "sublinea", null: false
    t.text "sentido", null: false
    t.geometry "geom", limit: {:srid=>0, :type=>"geometry"}, null: false
    t.text "timestamp", null: false
  end

  create_table "paradas_recorridos", primary_key: "gid", id: :integer, default: -> { "nextval('paradas_gid_seq'::regclass)" }, force: :cascade do |t|
    t.decimal "cod_ubic_p"
    t.string "desc_linea", limit: 50
    t.float "cod_varian"
    t.integer "ordinal"
    t.string "calle", limit: 35
    t.string "esquina", limit: 36
    t.float "cod_calle1"
    t.float "cod_calle2"
    t.decimal "x"
    t.decimal "y"
    t.geometry "geom", limit: {:srid=>4326, :type=>"st_point"}
  end

  create_table "paradas_sublineas", id: :bigint, default: nil, force: :cascade do |t|
    t.geometry "geom", limit: {:srid=>0, :type=>"geometry"}, null: false
    t.text "linea", null: false
    t.text "cod_sublinea", null: false
    t.text "desc_sublinea", null: false
    t.text "sentido", null: false
    t.text "cod_ubic_p", null: false
  end

  create_table "playas", primary_key: "gid", id: :serial, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "nombre", limit: 80, null: false
    t.geometry "geom", limit: {:srid=>4326, :type=>"multi_polygon"}, null: false
    t.integer "puntaje"
  end

  create_table "recorridos", primary_key: "gid", id: :serial, force: :cascade do |t|
    t.decimal "__gid"
    t.float "cod_linea"
    t.string "desc_linea", limit: 50
    t.float "ordinal_su"
    t.float "cod_sublin"
    t.string "desc_subli", limit: 50
    t.float "cod_varian"
    t.string "desc_varia", limit: 1
    t.geometry "geom", limit: {:srid=>4326, :type=>"multi_line_string"}
  end

  create_table "sensores_agua", primary_key: "gid", id: :serial, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "id_playa", null: false
    t.geometry "geom", limit: {:srid=>4326, :type=>"st_point"}, null: false
    t.boolean "valor"
  end

  create_table "sensores_banderas", primary_key: "gid", id: :serial, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "id_playa", null: false
    t.geometry "geom", limit: {:srid=>4326, :type=>"st_point"}, null: false
    t.text "valor"
  end

  create_table "sensores_personas", primary_key: "gid", id: :serial, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "id_playa", null: false
    t.geometry "geom", limit: {:srid=>4326, :type=>"st_point"}, null: false
    t.integer "valor", default: 0
  end

  create_table "sensores_uv", primary_key: "gid", id: :serial, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "id_playa", null: false
    t.geometry "geom", limit: {:srid=>4326, :type=>"st_point"}, null: false
    t.integer "valor"
  end

end
