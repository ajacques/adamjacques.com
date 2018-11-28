class AddForeignKeys < ActiveRecord::Migration[4.2]
  def change
    add_foreign_key :degrees, :education
    add_foreign_key :educations, :organization
    add_foreign_key :jobs, :location
    add_foreign_key :jobs, :organization
    add_foreign_key :jobs, :people, column: :manager
    add_foreign_key :pay_rates, :job, on_delete: :cascade
    add_foreign_key :descriptions, :job, on_delete: :cascade
    add_foreign_key :employee_ids, :job, on_delete: :cascade
    add_foreign_key :key_points, :key_points, column: :parent_id, on_delete: :cascade
    add_foreign_key :people, :organization
    add_foreign_key :projects, :organization
    add_foreign_key :references, :people
    add_foreign_key :references, :job
  end
end
