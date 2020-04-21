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

ActiveRecord::Schema.define(version: 2020_04_21_013005) do

  create_table "area_lls", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "areacode_l"
    t.string "areaname_l"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "area_ls", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "areacode_l"
    t.string "areaname_l"
    t.bigint "pref_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pref_id"], name: "index_area_ls_on_pref_id"
  end

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "category_l_code"
    t.string "category_l_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorite_shops", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "shop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_favorite_shops_on_shop_id"
    t.index ["user_id", "shop_id"], name: "index_favorite_shops_on_user_id_and_shop_id", unique: true
    t.index ["user_id"], name: "index_favorite_shops_on_user_id"
  end

  create_table "favorites", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_favorites_on_post_id"
    t.index ["user_id", "post_id"], name: "index_favorites_on_user_id_and_post_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "posts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "image"
    t.string "title"
    t.text "content"
    t.bigint "user_id"
    t.bigint "shop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_posts_on_shop_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "prefs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "pref_code"
    t.string "pref_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shops", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.decimal "latitude", precision: 10, scale: 7
    t.decimal "longitude", precision: 10, scale: 7
    t.string "shop_url"
    t.string "image_url"
    t.string "address"
    t.string "tel"
    t.text "opentime"
    t.string "holiday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "freeword"
    t.string "shop_code"
    t.string "pr"
    t.integer "budget"
    t.integer "wifi"
    t.integer "outret"
    t.integer "takeout"
    t.string "line"
    t.string "station"
    t.string "station_exit"
    t.integer "walk"
    t.string "category_name_l"
    t.string "category_l"
    t.string "category_s"
    t.integer "customerBudget"
    t.integer "lowestBudget"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_digest"
    t.boolean "admin", default: false, null: false
  end

  add_foreign_key "area_ls", "prefs"
  add_foreign_key "favorite_shops", "shops"
  add_foreign_key "favorite_shops", "users"
  add_foreign_key "favorites", "posts"
  add_foreign_key "favorites", "users"
  add_foreign_key "posts", "shops"
  add_foreign_key "posts", "users"
end
