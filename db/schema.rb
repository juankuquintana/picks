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

ActiveRecord::Schema[7.1].define(version: 2024_08_02_195519) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", comment: "This table stores account information associated with users", force: :cascade do |t|
    t.string "email", limit: 255, null: false, comment: "Email address associated with the user"
    t.string "name", limit: 255, comment: "Name associated with the account"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_accounts_on_email", unique: true
  end

  create_table "activity_logs", comment: "This table stores a log of relevant activities performed to/by our users, on their accounts and models", force: :cascade do |t|
    t.bigint "user_id", comment: "Reference to the user associated with this activity log"
    t.bigint "account_id", comment: "Reference to the account associated with this activity log"
    t.string "name", limit: 255, null: false, comment: "Name used to identify the type of activity log"
    t.string "actor", limit: 255, null: false, comment: "Actor that caused the activity log"
    t.jsonb "identifiers", comment: "Associated models relevant to the activity log"
    t.jsonb "data", comment: "Associated data relevant to the activity log"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_activity_logs_on_account_id"
    t.index ["user_id"], name: "index_activity_logs_on_user_id"
  end

  create_table "bets", comment: "This table stores the bets or prediction information", force: :cascade do |t|
    t.integer "home_team_score", null: false, comment: "Score for the home team"
    t.integer "away_team_score", null: false, comment: "Score for the away team"
    t.integer "points", comment: "Points obtained for the bet"
    t.bigint "fixture_id", null: false, comment: "Fixture associated to this bet"
    t.bigint "pool_id", null: false, comment: "Pool associated to this bet"
    t.bigint "user_id", null: false, comment: "User that placed the bet"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fixture_id", "pool_id", "user_id"], name: "index_bets_on_fixture_id_and_pool_id_and_user_id", unique: true
    t.index ["fixture_id"], name: "index_bets_on_fixture_id"
    t.index ["pool_id"], name: "index_bets_on_pool_id"
    t.index ["user_id"], name: "index_bets_on_user_id"
  end

  create_table "countries", comment: "This table stores countries related information", force: :cascade do |t|
    t.string "name", limit: 255, null: false, comment: "The country name"
    t.string "code", limit: 2, comment: "The country ISO 3166-1 alpha-2"
    t.text "flag", comment: "URL of the country flag image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fixtures", comment: "This table stores a fixture or match information", force: :cascade do |t|
    t.datetime "datetime", comment: "The date time a match is played"
    t.integer "home_team_score", comment: "The home team score"
    t.integer "away_team_score", comment: "The away team score"
    t.jsonb "adapters", null: false, comment: "Stores the reference IDs of the fixture from our different providers"
    t.bigint "home_team_id", null: false, comment: "References the home team associated to this fixture"
    t.bigint "away_team_id", null: false, comment: "References the away team associated to this fixture"
    t.bigint "round_id", null: false, comment: "References the round associated to this fixture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "score", comment: "Stores a detailed summary of a fixture scores"
    t.string "state", default: "finished", null: false, comment: "Status of a fixture"
    t.index ["away_team_id"], name: "index_fixtures_on_away_team_id"
    t.index ["home_team_id"], name: "index_fixtures_on_home_team_id"
    t.index ["round_id", "home_team_id", "away_team_id"], name: "index_fixtures_on_round_id_and_home_team_id_and_away_team_id", unique: true
    t.index ["round_id"], name: "index_fixtures_on_round_id"
  end

  create_table "flipper_features", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_flipper_features_on_key", unique: true
  end

  create_table "flipper_gates", force: :cascade do |t|
    t.string "feature_key", null: false
    t.string "key", null: false
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feature_key", "key", "value"], name: "index_flipper_gates_on_feature_key_and_key_and_value", unique: true
  end

  create_table "item_events", comment: "This table stores item events related information", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false, comment: "References the model associated to this record"
    t.string "actor", limit: 255, null: false, comment: "Holds the actor of the event"
    t.string "event_type", limit: 255, null: false, comment: "Holds the type of the event"
    t.jsonb "data", comment: "Holds any additional data of the event"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_type", "item_id"], name: "index_item_events_on_item"
  end

  create_table "leagues", comment: "This table stores leagues related information", force: :cascade do |t|
    t.string "name", limit: 255, null: false, comment: "The league name"
    t.text "logo", null: false, comment: "URL of the league logo image"
    t.jsonb "adapters", null: false, comment: "Stores the reference IDs of the league from our different providers"
    t.bigint "country_id", null: false, comment: "References the country associated to this league"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "state", default: "active", null: false, comment: "State (status) of a league"
    t.date "season_start", comment: "Date the upcoming or last season starts for a league"
    t.date "season_end", comment: "Date the upcoming or last season ends for a league"
    t.index ["country_id"], name: "index_leagues_on_country_id"
  end

  create_table "memberships", comment: "This table stores memberships which associates users and accounts", force: :cascade do |t|
    t.bigint "user_id", null: false, comment: "Reference to the user associated with this membership"
    t.bigint "account_id", null: false, comment: "Reference to the account associated with this membership"
    t.boolean "primary", default: false, null: false, comment: "Identifies the primary account of a user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_memberships_on_account_id"
    t.index ["user_id", "account_id"], name: "index_memberships_on_user_id_and_account_id", unique: true
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "order_items", comment: "This table stores order items related information", force: :cascade do |t|
    t.bigint "order_id", null: false, comment: "Reference to the parent order associated with this order item"
    t.string "order_item_type", null: false
    t.bigint "order_item_id", null: false, comment: "References the model associated to this order item"
    t.string "state", limit: 255, null: false, comment: "Holds the state of the order item"
    t.text "failure_description", comment: "Holds the description of the order item error"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["order_item_type", "order_item_id"], name: "index_order_items_on_order_item"
  end

  create_table "orders", comment: "This table stores orders related information", force: :cascade do |t|
    t.bigint "user_id", null: false, comment: "Reference to the user associated with this order"
    t.bigint "account_id", null: false, comment: "Reference to the account associated with this order"
    t.string "state", limit: 255, null: false, comment: "Holds the state of the order"
    t.datetime "last_processed_at", comment: "Holds the time the order was last processed"
    t.integer "runs", null: false, comment: "Holds the amount of times the order has been ran"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_orders_on_account_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "pool_users", comment: "This table stores the relation between pool and users", force: :cascade do |t|
    t.string "role", limit: 255, null: false, comment: "Role of the user and the pool"
    t.bigint "pool_id", null: false, comment: "Pool associated to a user"
    t.bigint "user_id", null: false, comment: "User associated to a pool"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pool_id"], name: "index_pool_users_on_pool_id"
    t.index ["user_id"], name: "index_pool_users_on_user_id"
  end

  create_table "pools", comment: "This table stores a pool information", force: :cascade do |t|
    t.string "name", limit: 255, null: false, comment: "Name of the pool"
    t.string "code", limit: 20, null: false, comment: "Unique code of the pool for invitations"
    t.bigint "league_id", null: false, comment: "References the league associated to this pool"
    t.bigint "round_id", null: false, comment: "Initial round of the league associated to this pool"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_pools_on_code", unique: true
    t.index ["league_id"], name: "index_pools_on_league_id"
    t.index ["round_id"], name: "index_pools_on_round_id"
  end

  create_table "rounds", comment: "This table stores the name of the rounds (jornadas) or matchdays of a season", force: :cascade do |t|
    t.string "name", limit: 255, null: false, comment: "The round name"
    t.integer "order", null: false, comment: "The round order within a season"
    t.string "season", null: false, comment: "The season / year (YYYY) of the round"
    t.integer "group", comment: "Group to which the round belongs to, helpful when leagues have multiple seasons per year"
    t.bigint "league_id", null: false, comment: "References the league associated to this round"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_rounds_on_league_id"
    t.index ["name", "season", "league_id"], name: "index_rounds_on_name_and_season_and_league_id", unique: true
  end

  create_table "teams", comment: "This table stores a team information", force: :cascade do |t|
    t.string "name", limit: 255, null: false, comment: "The team name"
    t.string "code", comment: "The 3 letter code for a team"
    t.text "logo", comment: "The logo or flag of a team"
    t.jsonb "adapters", null: false, comment: "Stores the reference IDs of the team from our different providers"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_identities", comment: "This table stores the user identity providers associated to a user for authentication", force: :cascade do |t|
    t.bigint "user_id", null: false, comment: "Reference to the user associated with this identity"
    t.string "email", limit: 255, null: false, comment: "Email address associated with this identity"
    t.string "name", limit: 255, null: false, comment: "Name associated with this identity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_identities_on_user_id"
  end

  create_table "users", comment: "This table stores user authentication-related data", force: :cascade do |t|
    t.string "email", limit: 255, null: false, comment: "Email address associated with the user"
    t.string "session_token", limit: 255, null: false, comment: "Unique session token used for authentication"
    t.boolean "passwordless", default: false, null: false, comment: "Indicates if the user has enabled passwordless authentication"
    t.datetime "admin_at", comment: "Indicates when the user was granted admin privileges"
    t.datetime "last_login_at", comment: "Indicates the time when the user last logged in"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["session_token"], name: "index_users_on_session_token", unique: true
  end

  add_foreign_key "activity_logs", "accounts"
  add_foreign_key "activity_logs", "users"
  add_foreign_key "bets", "fixtures"
  add_foreign_key "bets", "pools"
  add_foreign_key "bets", "users"
  add_foreign_key "fixtures", "rounds"
  add_foreign_key "fixtures", "teams", column: "away_team_id"
  add_foreign_key "fixtures", "teams", column: "home_team_id"
  add_foreign_key "leagues", "countries"
  add_foreign_key "memberships", "accounts"
  add_foreign_key "memberships", "users"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "accounts"
  add_foreign_key "orders", "users"
  add_foreign_key "pool_users", "pools"
  add_foreign_key "pool_users", "users"
  add_foreign_key "pools", "leagues"
  add_foreign_key "pools", "rounds"
  add_foreign_key "rounds", "leagues"
  add_foreign_key "user_identities", "users"
end
