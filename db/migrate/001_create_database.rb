class CreateDatabase < ActiveRecord::Migration[4.2]
  def self.up
    create_table 'conferences', force: true do |t|
      t.string  'name', limit: 32, null: false
      t.integer 'location_id', null: false
      t.date    'start_date', null: false
      t.date    'end_date', null: false
    end

    add_index 'conferences', ['location_id']

    create_table 'degrees', force: true do |t|
      t.integer 'education_id', null: false
      t.string  'name', limit: 64, null: false
      t.string  'category', null: false
    end

    add_index 'degrees', ['education_id']

    create_table 'descriptions', force: true do |t|
      t.integer 'job_id', null: false
      t.text    'text',   null: false
    end

    add_index 'descriptions', ['job_id']

    create_table 'educations', force: true do |t|
      t.boolean 'active',                    null: false
      t.integer 'location_id',     limit: 2, null: false
      t.integer 'organization_id', limit: 2, null: false
      t.date    'start_date',                null: false
      t.date    'end_date'
    end

    add_index 'educations', ['location_id']
    add_index 'educations', ['organization_id']

    create_table 'employee_id', force: true do |t|
      t.integer 'job_id', limit: 2,  null: false
      t.string  'type',   limit: 16, null: false
      t.string  'value',  limit: 64, null: false
    end

    add_index 'employee_id', ['job_id']

    create_table 'housing', force: true do |t|
      t.date    'start_date', null: false
      t.date    'end_date'
      t.string  'address',    limit: 128, null: false
      t.string  'suite',      limit: 8
      t.integer 'city_id',    limit: 2, null: false
      t.integer 'point',      limit: nil
      t.string  'pay_type',   limit: 12, null: false
    end

    add_index 'housing', ['city_id']

    create_table 'jobs', force: true do |t|
      t.boolean 'active', default: false, null: false
      t.date    'start_date', null: false
      t.date    'end_date'
      t.string  'position',                                  null: false
      t.integer 'organization_id', limit: 2,                 null: false
      t.integer 'manager',         limit: 2
      t.integer 'recruiter',       limit: 2
      t.string  'department'
      t.integer 'location_id',     limit: 2, null: false
      t.string  'exit_reason',     limit: 9
    end

    add_index 'jobs', ['location_id']
    add_index 'jobs', ['manager']
    add_index 'jobs', ['organization_id']
    add_index 'jobs', ['recruiter']

    create_table 'key_points', force: true do |t|
      t.integer 'parent_id', limit: 2
      t.integer 'sort',      limit: 3, null: false
      t.boolean 'active',              null: false
      t.string  'value',               null: false
    end

    add_index 'key_points', ['parent_id']

    create_table 'locations', force: true do |t|
      t.string  'city',                     null: false
      t.string  'admin_level1',             null: false
      t.string  'country',      limit: 2,   null: false
      t.integer 'point',        limit: nil, null: false
    end

    create_table 'organizations', force: true do |t|
      t.string 'name',     null: false
      t.string 'web_page', null: false
    end

    create_table 'pay_rates', force: true do |t|
      t.integer 'job_id',     limit: 2,                         null: false
      t.date    'start_date',                                   null: false
      t.date    'end_date'
      t.string  'pay_type', limit: 6, null: false
      t.decimal 'pay_amount', precision: 8, scale: 2, null: false
      t.string  'pay_scale', limit: 7, null: false
    end

    add_index 'pay_rates', ['job_id']

    create_table 'people', force: true do |t|
      t.string  'name',                      null: false
      t.integer 'organization_id', limit: 2, null: false
      t.string  'position',                  null: false
      t.string  'department'
      t.string  'email_address'
      t.string  'work_phone'
    end

    add_index 'people', ['organization_id']

    create_table 'projects', force: true do |t|
      t.string  'title',           limit: 64, null: false
      t.integer 'organization_id', limit: 2,  null: false
      t.date    'start_date',                 null: false
      t.date    'end_date'
    end

    add_index 'projects', ['organization_id']

    create_table 'references', force: true do |t|
      t.integer 'person_id', limit: 2, null: false
      t.integer 'job_id',    limit: 2, null: false
    end

    add_index 'references', ['job_id']
    add_index 'references', ['person_id']
  end
end
