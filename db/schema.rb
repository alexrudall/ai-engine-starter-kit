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

ActiveRecord::Schema[7.1].define(version: 2024_06_26_112101) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "ai_engine_assistant_threads", force: :cascade do |t|
    t.string "remote_id"
    t.string "threadable_type"
    t.bigint "threadable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["threadable_type", "threadable_id"], name: "index_ai_engine_assistant_threads_on_threadable"
  end

  create_table "ai_engine_assistants", force: :cascade do |t|
    t.string "remote_id"
    t.string "assistable_type"
    t.bigint "assistable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assistable_type", "assistable_id", "remote_id"], name: "idx_on_assistable_type_assistable_id_remote_id_bea46cd0e4", unique: true
    t.index ["assistable_type", "assistable_id"], name: "index_ai_engine_assistants_on_assistable"
  end

  create_table "ai_engine_chats", force: :cascade do |t|
    t.string "chattable_type"
    t.bigint "chattable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chattable_type", "chattable_id"], name: "index_ai_engine_chats_on_chattable"
  end

  create_table "ai_engine_messages", force: :cascade do |t|
    t.string "remote_id"
    t.bigint "ai_engine_run_id"
    t.string "messageable_type"
    t.bigint "messageable_id"
    t.integer "role", default: 0, null: false
    t.string "content", null: false
    t.string "model"
    t.integer "prompt_token_usage"
    t.integer "completion_token_usage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ai_engine_run_id"], name: "index_ai_engine_messages_on_ai_engine_run_id"
    t.index ["messageable_type", "messageable_id"], name: "index_ai_engine_messages_on_messageable"
  end

  create_table "ai_engine_runs", force: :cascade do |t|
    t.string "remote_id"
    t.bigint "ai_engine_assistant_id"
    t.bigint "ai_engine_assistant_thread_id"
    t.integer "prompt_token_usage"
    t.integer "completion_token_usage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ai_engine_assistant_id"], name: "index_ai_engine_runs_on_ai_engine_assistant_id"
    t.index ["ai_engine_assistant_thread_id"], name: "index_ai_engine_runs_on_ai_engine_assistant_thread_id"
  end

  create_table "storytellers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.string "model", null: false
    t.string "instructions", null: false
    t.text "description", null: false
    t.integer "max_prompt_tokens", null: false
    t.integer "max_completion_tokens", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_storytellers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name"
    t.string "remote_id"
    t.string "avatar_url"
    t.string "provider"
    t.citext "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "ai_engine_messages", "ai_engine_runs"
  add_foreign_key "ai_engine_runs", "ai_engine_assistant_threads"
  add_foreign_key "ai_engine_runs", "ai_engine_assistants"
  add_foreign_key "storytellers", "users"
end
