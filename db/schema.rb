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

ActiveRecord::Schema.define(version: 2018_10_21_073916) do

  create_table "feedbacks", force: :cascade do |t|
    t.text "content"
    t.integer "rating"
    t.integer "priority_value"
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "feedback_type"
    t.string "status", default: "private"
    t.index ["post_id", "created_at"], name: "index_feedbacks_on_post_id_and_created_at"
    t.index ["post_id", "feedback_type", "created_at"], name: "feedbacks_created_at_index", order: { created_at: :desc }
    t.index ["post_id", "feedback_type", "priority_value"], name: "feedbacks_priority_index", order: { priority_value: :desc }
    t.index ["post_id", "feedback_type", "rating"], name: "feedbacks_rating_index", order: { rating: :desc }
    t.index ["post_id", "rating"], name: "index_feedbacks_on_post_id_and_rating", order: { rating: :desc }
    t.index ["post_id"], name: "index_feedbacks_on_post_id"
    t.index ["user_id"], name: "index_feedbacks_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "user_id"
    t.string "post_id"
    t.boolean "unread"
    t.string "notification_type"
    t.string "feedback_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_notifications_on_user_id_and_created_at", order: { created_at: :desc }
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.string "url"
    t.string "image"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "rating"
    t.integer "rating_count"
    t.integer "review_count"
    t.integer "new_feedback_count"
    t.index ["created_at"], name: "index_posts_on_created_at", order: :desc
    t.index ["rating"], name: "index_posts_on_rating", order: :desc
    t.index ["user_id", "created_at"], name: "index_posts_on_user_id_and_created_at", order: { created_at: :desc }
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.integer "point", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
