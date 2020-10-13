class AddForeignKeys < ActiveRecord::Migration[4.2]
  def change
    add_foreign_key :degrees, :educations
    add_foreign_key :educations, :organizations
    add_foreign_key :jobs, :locations
    add_foreign_key :jobs, :organizations
    add_foreign_key :jobs, :people, column: :manager
    add_foreign_key :pay_rates, :jobs, on_delete: :cascade
    add_foreign_key :descriptions, :jobs, on_delete: :cascade
    add_foreign_key :employee_id, :jobs, on_delete: :cascade
    add_foreign_key :key_points, :key_points, column: :parent_id, on_delete: :cascade
    add_foreign_key :people, :organizations
    add_foreign_key :projects, :organizations
    add_foreign_key :references, :people
    add_foreign_key :references, :jobs
  end
end
