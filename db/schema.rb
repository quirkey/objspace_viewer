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

ActiveRecord::Schema.define(version: 20131110051833) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "heap_entries", force: true do |t|
    t.integer "heap_id"
    t.string  "heap_address",    limit: 20
    t.string  "entry_type",      limit: 10
    t.string  "class_address",   limit: 20
    t.string  "encoding",        limit: 20
    t.boolean "is_embedded"
    t.boolean "is_shared"
    t.boolean "is_frozen"
    t.boolean "is_associated"
    t.boolean "is_wb_protected"
    t.boolean "is_marked"
    t.boolean "is_old"
    t.text    "value"
    t.integer "bytesize"
    t.integer "size"
    t.integer "memsize"
    t.integer "capacity"
    t.integer "length"
    t.integer "fd"
    t.string  "node_type"
    t.string  "name"
    t.string  "root"
  end

  add_index "heap_entries", ["heap_id", "class_address"], name: "index_heap_entries_on_heap_id_and_class_address", using: :btree
  add_index "heap_entries", ["heap_id", "entry_type"], name: "index_heap_entries_on_heap_id_and_entry_type", using: :btree
  add_index "heap_entries", ["heap_id", "heap_address"], name: "index_heap_entries_on_heap_id_and_heap_address", unique: true, using: :btree

  create_table "heap_references", force: true do |t|
    t.integer "heap_id"
    t.string  "from_address"
    t.string  "to_address"
  end

  add_index "heap_references", ["heap_id", "from_address"], name: "index_heap_references_on_heap_id_and_from_address", using: :btree
  add_index "heap_references", ["heap_id", "to_address"], name: "index_heap_references_on_heap_id_and_to_address", using: :btree

  create_table "heaps", force: true do |t|
    t.string   "name"
    t.integer  "size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
