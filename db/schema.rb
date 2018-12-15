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

ActiveRecord::Schema.define(version: 2018_12_12_085852) do

  create_table "accounts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "acc_id", limit: 20, null: false
    t.string "name", limit: 20, null: false
    t.string "grade", limit: 5, null: false
    t.string "university", limit: 20, null: false
    t.string "faculty", limit: 20, null: false
    t.string "department", limit: 20, null: false
    t.string "introduction", limit: 1000, default: "", null: false
    t.index ["acc_id"], name: "index_accounts_on_acc_id", unique: true
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
  end

  create_table "chat_comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "chat_id"
    t.string "acc_id"
    t.date "time"
    t.string "comment"
    t.integer "file_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "acc_id", limit: 20, null: false
    t.integer "p_com_id", null: false
    t.string "message", limit: 1000, null: false
    t.integer "file_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["p_com_id"], name: "index_comments_on_p_com_id"
  end

  create_table "entry_chats", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "chat_id"
    t.string "acc_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recruitments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "acc_id", limit: 20
    t.string "re_id"
    t.string "chat_id"
    t.string "resolved"
    t.string "title", limit: 100
    t.string "detail", limit: 1000
    t.string "ans_com_id"
    t.string "answer", limit: 1000
    t.string "file_id"
    t.string "chat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taghistories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "acc_id", null: false
    t.string "univtag", limit: 30
    t.string "faculty", limit: 30
    t.string "department", limit: 30
    t.string "tag1", limit: 30
    t.string "tag2", limit: 30
    t.string "tag3", limit: 30
    t.string "tag4", limit: 30
    t.string "tag5", limit: 30
    t.string "tag6", limit: 30
    t.string "tag7", limit: 30
    t.string "display", limit: 300
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tagmaps", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "com_id"
    t.integer "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", primary_key: "tag_id", id: :integer, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.boolean "tag_type", null: false
    t.string "tag_name", limit: 30, null: false
    t.integer "com_count", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "univinfos", id: :integer, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "p_id"
    t.integer "stat", null: false
    t.string "name", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
