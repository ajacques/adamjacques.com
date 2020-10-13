# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 5) do

  create_table "conferences", force: :cascade do |t|
    t.string "name", limit: 32, null: false
    t.integer "location_id", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.index ["location_id"], name: "index_conferences_on_location_id"
  end

  create_table "degrees", force: :cascade do |t|
    t.integer "education_id", null: false
    t.string "name", limit: 64, null: false
    t.string "category", null: false
    t.index ["education_id"], name: "index_degrees_on_education_id"
  end

  create_table "descriptions", force: :cascade do |t|
    t.integer "job_id", null: false
    t.text "text", null: false
    t.index ["job_id"], name: "index_descriptions_on_job_id"
  end

  create_table "educations", force: :cascade do |t|
    t.boolean "active", null: false
    t.integer "location_id", limit: 2, null: false
    t.integer "organization_id", limit: 2, null: false
    t.date "start_date", null: false
    t.date "end_date"
    t.index ["location_id"], name: "index_educations_on_location_id"
    t.index ["organization_id"], name: "index_educations_on_organization_id"
  end

  create_table "employee_id", force: :cascade do |t|
    t.integer "job_id", limit: 2, null: false
    t.string "type", limit: 16, null: false
    t.string "value", limit: 64, null: false
    t.index ["job_id"], name: "index_employee_id_on_job_id"
  end

  create_table "housing", force: :cascade do |t|
    t.date "start_date", null: false
    t.date "end_date"
    t.string "address", limit: 128, null: false
    t.string "suite", limit: 8
    t.integer "city_id", limit: 2, null: false
    t.integer "point"
    t.string "pay_type", limit: 12, null: false
    t.index ["city_id"], name: "index_housing_on_city_id"
  end

  create_table "info", force: :cascade do |t|
    t.string "key", null: false
    t.string "value", null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.boolean "active", default: false, null: false
    t.date "start_date", null: false
    t.date "end_date"
    t.string "position", null: false
    t.integer "organization_id", limit: 2, null: false
    t.integer "recruiter", limit: 2
    t.string "department"
    t.integer "location_id", limit: 2, null: false
    t.string "exit_reason", limit: 9
    t.index ["location_id"], name: "index_jobs_on_location_id"
    t.index ["organization_id"], name: "index_jobs_on_organization_id"
    t.index ["recruiter"], name: "index_jobs_on_recruiter"
  end

  create_table "key_points", force: :cascade do |t|
    t.integer "parent_id", limit: 2
    t.integer "sort", limit: 3, null: false
    t.boolean "active", null: false
    t.string "value", null: false
    t.index ["parent_id"], name: "index_key_points_on_parent_id"
  end

  create_table "links", force: :cascade do |t|
    t.string "name", null: false
    t.string "url", null: false
    t.boolean "active", default: false, null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "city", null: false
    t.string "admin_level1", null: false
    t.string "country", limit: 2, null: false
    t.integer "point", null: false
  end

  create_table "managers", force: :cascade do |t|
    t.integer "organization_id", null: false
    t.integer "person_id", null: false
    t.date "start_date", null: false
    t.date "end_date"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.string "web_page", null: false
  end

  create_table "pay_rates", force: :cascade do |t|
    t.integer "job_id", limit: 2, null: false
    t.date "start_date", null: false
    t.date "end_date"
    t.string "pay_type", limit: 6, null: false
    t.decimal "pay_amount", precision: 8, scale: 2, null: false
    t.string "pay_scale", limit: 7, null: false
    t.index ["job_id"], name: "index_pay_rates_on_job_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "name", null: false
    t.integer "organization_id", limit: 2, null: false
    t.string "position", null: false
    t.string "department"
    t.string "email_address"
    t.string "work_phone"
    t.index ["organization_id"], name: "index_people_on_organization_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title", limit: 64, null: false
    t.integer "organization_id", limit: 2, null: false
    t.date "start_date", null: false
    t.date "end_date"
    t.index ["organization_id"], name: "index_projects_on_organization_id"
  end

  create_table "references", force: :cascade do |t|
    t.integer "person_id", limit: 2, null: false
    t.integer "job_id", limit: 2, null: false
    t.index ["person_id"], name: "index_references_on_people_id"
    t.index ["job_id"], name: "index_references_on_job_id"
  end

  add_foreign_key "degrees", "educations"
  add_foreign_key "descriptions", "jobs", on_delete: :cascade
  add_foreign_key "educations", "organizations"
  add_foreign_key "employee_id", "jobs", on_delete: :cascade
  add_foreign_key "jobs", "locations"
  add_foreign_key "jobs", "organizations"
  add_foreign_key "key_points", "key_points", column: "parent_id", on_delete: :cascade
  add_foreign_key "managers", "organizations"
  add_foreign_key "managers", "people"
  add_foreign_key "pay_rates", "jobs", on_delete: :cascade
  add_foreign_key "people", "organizations"
  add_foreign_key "projects", "organizations"
  add_foreign_key "references", "jobs"
  add_foreign_key "references", "people"
end
