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

ActiveRecord::Schema.define(version: 2) do

  create_table "conferences", force: :cascade do |t|
    t.string  "name",        limit: 32, null: false
    t.integer "location_id",            null: false
    t.date    "start_date",             null: false
    t.date    "end_date",               null: false
  end

  add_index "conferences", ["location_id"], name: "index_conferences_on_location_id"

  create_table "degrees", force: :cascade do |t|
    t.integer "education_id",            null: false
    t.string  "name",         limit: 64, null: false
    t.string  "category",                null: false
  end

  add_index "degrees", ["education_id"], name: "index_degrees_on_education_id"

  create_table "descriptions", force: :cascade do |t|
    t.integer "job_id", null: false
    t.text    "text",   null: false
  end

  add_index "descriptions", ["job_id"], name: "index_descriptions_on_job_id"

  create_table "educations", force: :cascade do |t|
    t.boolean "active",                    null: false
    t.integer "location_id",     limit: 2, null: false
    t.integer "organization_id", limit: 2, null: false
    t.date    "start_date",                null: false
    t.date    "end_date"
  end

  add_index "educations", ["location_id"], name: "index_educations_on_location_id"
  add_index "educations", ["organization_id"], name: "index_educations_on_organization_id"

  create_table "employee_id", force: :cascade do |t|
    t.integer "job_id", limit: 2,  null: false
    t.string  "type",   limit: 16, null: false
    t.string  "value",  limit: 64, null: false
  end

  add_index "employee_id", ["job_id"], name: "index_employee_id_on_job_id"

  create_table "housing", force: :cascade do |t|
    t.date    "start_date",             null: false
    t.date    "end_date"
    t.string  "address",    limit: 128, null: false
    t.string  "suite",      limit: 8
    t.integer "city_id",    limit: 2,   null: false
    t.integer "point"
    t.string  "pay_type",   limit: 12,  null: false
  end

  add_index "housing", ["city_id"], name: "index_housing_on_city_id"

  create_table "jobs", force: :cascade do |t|
    t.boolean "active",                    default: false, null: false
    t.date    "start_date",                                null: false
    t.date    "end_date"
    t.string  "position",                                  null: false
    t.integer "organization_id", limit: 2,                 null: false
    t.integer "manager",         limit: 2
    t.integer "recruiter",       limit: 2
    t.string  "department"
    t.integer "location_id",     limit: 2,                 null: false
    t.string  "exit_reason",     limit: 9
  end

  add_index "jobs", ["location_id"], name: "index_jobs_on_location_id"
  add_index "jobs", ["manager"], name: "index_jobs_on_manager"
  add_index "jobs", ["organization_id"], name: "index_jobs_on_organization_id"
  add_index "jobs", ["recruiter"], name: "index_jobs_on_recruiter"

  create_table "key_points", force: :cascade do |t|
    t.integer "parent_id", limit: 2
    t.integer "sort",      limit: 3, null: false
    t.boolean "active",              null: false
    t.string  "value",               null: false
  end

  add_index "key_points", ["parent_id"], name: "index_key_points_on_parent_id"

  create_table "links", force: :cascade do |t|
    t.string  "name",                   null: false
    t.string  "url",                    null: false
    t.boolean "active", default: false, null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string  "city",                   null: false
    t.string  "admin_level1",           null: false
    t.string  "country",      limit: 2, null: false
    t.integer "point",                  null: false
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name",     null: false
    t.string "web_page", null: false
  end

  create_table "pay_rates", force: :cascade do |t|
    t.integer "job_id",     limit: 2,                         null: false
    t.date    "start_date",                                   null: false
    t.date    "end_date"
    t.string  "pay_type",   limit: 6,                         null: false
    t.decimal "pay_amount",           precision: 8, scale: 2, null: false
    t.string  "pay_scale",  limit: 7,                         null: false
  end

  add_index "pay_rates", ["job_id"], name: "index_pay_rates_on_job_id"

  create_table "people", force: :cascade do |t|
    t.string  "name",                      null: false
    t.integer "organization_id", limit: 2, null: false
    t.string  "position",                  null: false
    t.string  "department"
    t.string  "email_address"
    t.string  "work_phone"
  end

  add_index "people", ["organization_id"], name: "index_people_on_organization_id"

  create_table "projects", force: :cascade do |t|
    t.string  "title",           limit: 64, null: false
    t.integer "organization_id", limit: 2,  null: false
    t.date    "start_date",                 null: false
    t.date    "end_date"
  end

  add_index "projects", ["organization_id"], name: "index_projects_on_organization_id"

  create_table "references", force: :cascade do |t|
    t.integer "people_id", limit: 2, null: false
    t.integer "job_id",    limit: 2, null: false
  end

  add_index "references", ["job_id"], name: "index_references_on_job_id"
  add_index "references", ["people_id"], name: "index_references_on_people_id"

end
