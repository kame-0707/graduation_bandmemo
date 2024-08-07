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

ActiveRecord::Schema[7.1].define(version: 2024_08_08_021018) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
  end

  create_table "comments", force: :cascade do |t|
    t.string "content"
    t.bigint "user_id", null: false
    t.bigint "group_id"
    t.bigint "summary_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_comments_on_group_id"
    t.index ["summary_id"], name: "index_comments_on_summary_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "group_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_users_on_group_id"
    t.index ["user_id"], name: "index_group_users_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", null: false
    t.text "introduction"
    t.integer "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "group_id"
    t.bigint "summary_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_likes_on_group_id"
    t.index ["summary_id"], name: "index_likes_on_summary_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "permits", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_permits_on_group_id"
    t.index ["user_id"], name: "index_permits_on_user_id"
  end

  create_table "spots", force: :cascade do |t|
    t.string "registered_title"
    t.string "address"
    t.float "lat", null: false
    t.float "lng", null: false
    t.string "opening_hours"
    t.string "phone_number"
    t.string "website"
    t.string "place_id"
    t.bigint "user_id", null: false
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_datetime"
    t.index ["group_id"], name: "index_spots_on_group_id"
    t.index ["user_id"], name: "index_spots_on_user_id"
  end

  create_table "summaries", force: :cascade do |t|
    t.text "title", null: false
    t.text "content", null: false
    t.text "summary"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "group_id"
    t.index ["group_id"], name: "index_summaries_on_group_id"
    t.index ["user_id"], name: "index_summaries_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.string "title"
    t.string "videos_url"
    t.bigint "user_id", null: false
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_videos_on_group_id"
    t.index ["user_id"], name: "index_videos_on_user_id"
  end

  create_table "voices", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "group_id"
    t.index ["group_id"], name: "index_voices_on_group_id"
    t.index ["user_id"], name: "index_voices_on_user_id"
  end

  add_foreign_key "comments", "groups"
  add_foreign_key "comments", "summaries"
  add_foreign_key "comments", "users"
  add_foreign_key "group_users", "groups"
  add_foreign_key "group_users", "users"
  add_foreign_key "likes", "groups"
  add_foreign_key "likes", "summaries"
  add_foreign_key "likes", "users"
  add_foreign_key "permits", "groups"
  add_foreign_key "permits", "users"
  add_foreign_key "spots", "groups"
  add_foreign_key "spots", "users"
  add_foreign_key "summaries", "groups"
  add_foreign_key "summaries", "users"
  add_foreign_key "videos", "groups"
  add_foreign_key "videos", "users"
  add_foreign_key "voices", "groups"
  add_foreign_key "voices", "users"
end
