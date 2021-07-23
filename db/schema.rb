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

ActiveRecord::Schema.define(version: 2021_07_22_235409) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "file_lines", force: :cascade do |t|
    t.integer "new_line_number"
    t.integer "old_line_number"
    t.string "line_origin"
    t.text "content"
    t.bigint "git_file_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["git_file_id"], name: "index_file_lines_on_git_file_id"
  end

  create_table "file_notes", force: :cascade do |t|
    t.integer "first_line"
    t.integer "last_line"
    t.text "comment"
    t.bigint "git_note_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "git_file_id", null: false
    t.index ["git_file_id"], name: "index_file_notes_on_git_file_id"
    t.index ["git_note_id"], name: "index_file_notes_on_git_note_id"
  end

  create_table "git_commits", force: :cascade do |t|
    t.bigint "git_repository_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "object_hash", default: "", null: false
    t.index ["git_repository_id"], name: "index_git_commits_on_git_repository_id"
    t.index ["object_hash"], name: "index_git_commits_on_object_hash", unique: true
  end

  create_table "git_files", force: :cascade do |t|
    t.string "filename"
    t.bigint "git_commit_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["filename", "git_commit_id"], name: "index_git_files_on_filename_and_git_commit_id", unique: true
    t.index ["git_commit_id"], name: "index_git_files_on_git_commit_id"
  end

  create_table "git_notes", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "git_commit_id", null: false
    t.index ["git_commit_id"], name: "index_git_notes_on_git_commit_id"
  end

  create_table "git_repositories", force: :cascade do |t|
    t.string "path"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "file_lines", "git_files"
  add_foreign_key "file_notes", "git_files"
  add_foreign_key "file_notes", "git_notes"
  add_foreign_key "git_commits", "git_repositories"
  add_foreign_key "git_files", "git_commits"
  add_foreign_key "git_notes", "git_commits"
end
