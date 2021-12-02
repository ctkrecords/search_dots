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

ActiveRecord::Schema.define(version: 2016_02_01_041109) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_types", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.text "description"
    t.boolean "is_deleted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admins", id: :serial, force: :cascade do |t|
    t.string "firstname", limit: 255
    t.string "lastname", limit: 255
    t.integer "country_id"
    t.integer "admin_type_id"
    t.boolean "is_deleted", default: false
    t.string "email", limit: 255, null: false
    t.string "encrypted_password", limit: 255, null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "company_id"
    t.boolean "is_verified", default: false
    t.string "token", limit: 255
    t.boolean "is_active", default: false
    t.string "photo", limit: 255
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "companies", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "country_id"
    t.string "website", limit: 255
    t.string "slogan", limit: 255
    t.string "logo_url", limit: 255
    t.string "contact_name", limit: 255
    t.string "contact_lastname", limit: 255
    t.string "phones", limit: 255
    t.string "email", limit: 255
    t.boolean "is_verified", default: false
    t.string "verify_token", limit: 255
    t.string "recovery_token", limit: 255
    t.datetime "recovery_token_sent_at"
    t.boolean "is_approved", default: false
    t.integer "approved_by"
    t.boolean "is_deleted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "logo_file_name", limit: 255
    t.string "logo_content_type", limit: 255
    t.integer "logo_file_size"
    t.datetime "logo_updated_at"
    t.index ["country_id"], name: "index_companies_on_country_id"
  end

  create_table "companies_countries", id: :serial, force: :cascade do |t|
    t.integer "company_id"
    t.integer "country_id"
    t.boolean "is_deleted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_companies_countries_on_company_id"
    t.index ["country_id"], name: "index_companies_countries_on_country_id"
  end

  create_table "countries", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "shortname", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries_dots", id: :serial, force: :cascade do |t|
    t.integer "dot_id"
    t.boolean "is_deleted", default: false
    t.integer "assigned_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "companies_country_id"
    t.index ["dot_id"], name: "index_countries_dots_on_dot_id"
  end

  create_table "country_dot_reports", id: :serial, force: :cascade do |t|
    t.integer "dot_id"
    t.integer "total"
    t.integer "spected"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "work_timeframe_id"
    t.integer "country_id"
    t.index ["dot_id"], name: "index_country_dot_reports_on_dot_id"
  end

  create_table "delayed_jobs", id: :serial, force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by", limit: 255
    t.string "queue", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "dot_reports", id: :serial, force: :cascade do |t|
    t.integer "dot_id"
    t.integer "total"
    t.integer "spected"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "work_timeframe_id"
    t.index ["dot_id"], name: "index_dot_reports_on_dot_id"
  end

  create_table "dots", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.text "description"
    t.integer "company_id"
    t.boolean "is_required"
    t.boolean "is_universal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_deleted", default: false
    t.string "color", limit: 255
  end

  create_table "dots_results", id: :serial, force: :cascade do |t|
    t.integer "talent_hunter_dot_id"
    t.integer "dot_made", default: 0
    t.float "result"
    t.integer "week"
    t.integer "month"
    t.integer "year"
    t.string "period_type", limit: 255
    t.date "start_period_at"
    t.date "end_period_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["talent_hunter_dot_id"], name: "index_dots_results_on_talent_hunter_dot_id"
  end

  create_table "dots_scoreds", id: :serial, force: :cascade do |t|
    t.integer "talent_hunters_dot_id"
    t.integer "work_timeframe_id"
    t.integer "total", default: 0
    t.decimal "scored_percentage", precision: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["talent_hunters_dot_id"], name: "index_dots_scoreds_on_talent_hunters_dot_id"
    t.index ["work_timeframe_id"], name: "index_dots_scoreds_on_work_timeframe_id"
  end

  create_table "talent_hunter_dot_reports", id: :serial, force: :cascade do |t|
    t.integer "dot_id"
    t.integer "talent_hunter_id"
    t.integer "total"
    t.integer "spected"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "work_timeframe_id"
    t.index ["dot_id"], name: "index_talent_hunter_dot_reports_on_dot_id"
  end

  create_table "talent_hunters", id: :serial, force: :cascade do |t|
    t.string "firstname", limit: 255
    t.string "lastname", limit: 255
    t.string "email", limit: 255
    t.integer "country_id"
    t.integer "company_id"
    t.boolean "is_active", default: true
    t.boolean "is_deleted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo_file_name", limit: 255
    t.string "photo_content_type", limit: 255
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
    t.string "encrypted_password", limit: 255, null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.string "photo", limit: 255
    t.boolean "include_in_reports", default: true
    t.index ["country_id"], name: "index_talent_hunters_on_country_id"
    t.index ["email"], name: "index_talent_hunters_on_email", unique: true
    t.index ["reset_password_token"], name: "index_talent_hunters_on_reset_password_token", unique: true
  end

  create_table "talent_hunters_dots", id: :serial, force: :cascade do |t|
    t.integer "created_by"
    t.integer "talent_hunter_id"
    t.integer "dot_id"
    t.integer "goal"
    t.boolean "is_deleted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "work_calendar_id"
    t.index ["dot_id"], name: "index_talent_hunters_dots_on_dot_id"
    t.index ["talent_hunter_id"], name: "index_talent_hunters_dots_on_talent_hunter_id"
  end

  create_table "work_calendars", id: :serial, force: :cascade do |t|
    t.integer "company_id"
    t.integer "country_id"
    t.string "title", limit: 255
    t.string "year", limit: 255
    t.string "timeframe_type", limit: 255
    t.boolean "is_deleted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_work_calendars_on_country_id"
  end

  create_table "work_timeframes", id: :serial, force: :cascade do |t|
    t.integer "work_calendar_id"
    t.integer "n_number"
    t.boolean "is_disabled", default: false
    t.boolean "is_deleted", default: false
    t.date "starts_at"
    t.date "ends_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "month", default: 0
    t.integer "quarter", default: 0
    t.index ["work_calendar_id"], name: "index_work_timeframes_on_work_calendar_id"
  end

end
