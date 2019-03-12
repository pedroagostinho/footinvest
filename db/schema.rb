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

ActiveRecord::Schema.define(version: 2019_03_12_114708) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clubs", force: :cascade do |t|
    t.string "name"
    t.string "logo"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "competitions", force: :cascade do |t|
    t.string "name"
    t.string "logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "market_values", force: :cascade do |t|
    t.datetime "date_time"
    t.integer "market_value"
    t.bigint "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_market_values_on_player_id"
  end

  create_table "news", force: :cascade do |t|
    t.datetime "date_time"
    t.string "tag"
    t.string "title"
    t.string "summary"
    t.text "content"
    t.bigint "club_id"
    t.bigint "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo"
    t.index ["club_id"], name: "index_news_on_club_id"
    t.index ["player_id"], name: "index_news_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "photo"
    t.integer "age"
    t.integer "height"
    t.string "nationality"
    t.string "position"
    t.string "social_url"
    t.bigint "club_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_id"], name: "index_players_on_club_id"
  end

  create_table "portfolios", force: :cascade do |t|
    t.integer "value"
    t.bigint "user_id"
    t.datetime "date_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_portfolios_on_user_id"
  end

  create_table "results", force: :cascade do |t|
    t.datetime "date_time"
    t.bigint "competition_id"
    t.integer "home_club_goals"
    t.integer "away_club_goals"
    t.bigint "home_club_id"
    t.bigint "away_club_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["away_club_id"], name: "index_results_on_away_club_id"
    t.index ["competition_id"], name: "index_results_on_competition_id"
    t.index ["home_club_id"], name: "index_results_on_home_club_id"
  end

  create_table "stats", force: :cascade do |t|
    t.integer "games"
    t.integer "goals"
    t.integer "assists"
    t.integer "minutes_played"
    t.string "form"
    t.bigint "player_id"
    t.bigint "competition_id"
    t.integer "yellow_card"
    t.integer "red_card"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["competition_id"], name: "index_stats_on_competition_id"
    t.index ["player_id"], name: "index_stats_on_player_id"
  end

  create_table "tokens", force: :cascade do |t|
    t.boolean "on_sale"
    t.integer "last_price"
    t.bigint "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "owner"
    t.index ["player_id"], name: "index_tokens_on_player_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.datetime "date_time"
    t.integer "price"
    t.bigint "token_id"
    t.bigint "buying_user_id"
    t.bigint "selling_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buying_user_id"], name: "index_transactions_on_buying_user_id"
    t.index ["selling_user_id"], name: "index_transactions_on_selling_user_id"
    t.index ["token_id"], name: "index_transactions_on_token_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
    t.string "postcode"
    t.datetime "birthday"
    t.string "first_name"
    t.string "last_name"
    t.integer "balance"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "market_values", "players"
  add_foreign_key "news", "clubs"
  add_foreign_key "news", "players"
  add_foreign_key "players", "clubs"
  add_foreign_key "portfolios", "users"
  add_foreign_key "results", "competitions"
  add_foreign_key "stats", "competitions"
  add_foreign_key "stats", "players"
  add_foreign_key "tokens", "players"
  add_foreign_key "transactions", "tokens"
end
