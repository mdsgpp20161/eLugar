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

ActiveRecord::Schema.define(version: 20160615232841) do

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.integer  "population"
    t.float    "demographic_density"
    t.float    "area"
    t.float    "fleet"
    t.float    "idh"
    t.float    "gini"
    t.float    "health"
    t.float    "violence"
    t.boolean  "uber"
    t.string   "image"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string   "commenter"
    t.text     "body"
    t.integer  "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["city_id"], name: "index_comments_on_city_id"

  create_table "profile_quizzes", force: :cascade do |t|
    t.integer  "answer1"
    t.integer  "answer2"
    t.integer  "answer3"
    t.integer  "answer4"
    t.integer  "user_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "users_id"
    t.integer  "uber"
    t.integer  "demographic_density"
    t.integer  "area"
    t.integer  "population"
  end

  add_index "profile_quizzes", ["user_id"], name: "index_profile_quizzes_on_user_id"
  add_index "profile_quizzes", ["users_id"], name: "index_profile_quizzes_on_users_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.integer  "profileQuiz_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["profileQuiz_id"], name: "index_users_on_profileQuiz_id"

end
