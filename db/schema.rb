# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140927184158) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_school_documents", id: false, force: true do |t|
    t.integer "category_id"
    t.integer "school_document_id"
  end

  create_table "formats", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "school_documents", force: true do |t|
    t.string   "name"
    t.integer  "subject_id"
    t.integer  "student_id"
    t.integer  "year"
    t.integer  "term"
    t.integer  "grade"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "school_id"
    t.string   "file"
    t.string   "file_location"
    t.integer  "format_id"
  end

  add_index "school_documents", ["format_id"], name: "index_school_documents_on_format_id"
  add_index "school_documents", ["school_id"], name: "index_school_documents_on_school_id"

  create_table "schools", force: true do |t|
    t.string   "english_name"
    t.string   "chinese_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subjects", force: true do |t|
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
