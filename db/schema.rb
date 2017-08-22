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

ActiveRecord::Schema.define(version: 20170821191820) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.string "name"
    t.integer "multiverse_id"
    t.string "layout"
    t.string "mana_cost"
    t.integer "cmc"
    t.string "rarity"
    t.string "text"
    t.string "flavor"
    t.string "artist"
    t.integer "number"
    t.string "power"
    t.string "toughness"
    t.integer "loyalty"
    t.string "variations"
    t.string "watermark"
    t.string "border"
    t.string "timeshifted"
    t.string "hand"
    t.integer "life"
    t.string "reserved"
    t.string "release_date"
    t.string "starter"
    t.string "original_text"
    t.string "original_type"
    t.string "source"
    t.string "image_url"
    t.string "set"
    t.string "set_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cards_colors", id: false, force: :cascade do |t|
    t.bigint "card_id", null: false
    t.bigint "color_id", null: false
  end

  create_table "cards_legalities", id: false, force: :cascade do |t|
    t.bigint "card_id", null: false
    t.bigint "legality_id", null: false
  end

  create_table "cards_printings", id: false, force: :cascade do |t|
    t.bigint "card_id", null: false
    t.bigint "printing_id", null: false
  end

  create_table "cards_subtypes", id: false, force: :cascade do |t|
    t.bigint "card_id", null: false
    t.bigint "subtype_id", null: false
  end

  create_table "cards_supertypes", id: false, force: :cascade do |t|
    t.bigint "card_id", null: false
    t.bigint "supertype_id", null: false
  end

  create_table "cards_types", id: false, force: :cascade do |t|
    t.bigint "card_id", null: false
    t.bigint "type_id", null: false
  end

  create_table "colors", force: :cascade do |t|
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deck_archives", force: :cascade do |t|
    t.bigint "deck_id"
    t.bigint "card_id"
    t.integer "main_count"
    t.integer "sideboard_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_deck_archives_on_card_id"
    t.index ["deck_id"], name: "index_deck_archives_on_deck_id"
  end

  create_table "decks", force: :cascade do |t|
    t.string "owner"
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "foreign_names", force: :cascade do |t|
    t.string "name"
    t.string "language"
    t.integer "multiverse_id"
    t.integer "card_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "legalities", force: :cascade do |t|
    t.string "legality"
    t.string "format"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "printings", force: :cascade do |t|
    t.string "set"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rulings", force: :cascade do |t|
    t.date "date"
    t.string "text"
    t.integer "card_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subtypes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supertypes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
