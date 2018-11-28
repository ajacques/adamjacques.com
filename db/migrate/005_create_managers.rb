class CreateManagers < ActiveRecord::Migration[5.0]
  def up
    create_table :managers do |t|
      t.integer :organization_id, null: false
      t.integer :people_id, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
    end
    remove_column :jobs, :manager
  end

  def down
    drop_table :managers

    # Can't recover managers column
    raise ActiveRecord::IrreversibleMigration
  end
end
