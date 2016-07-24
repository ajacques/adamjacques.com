class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :name, null: false
      t.string :url, null: false
      t.boolean :active, null: false, default: false
    end
  end
end
