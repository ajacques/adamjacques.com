class CreateInfo < ActiveRecord::Migration
  def change
    create_table :info do |t|
      t.string :key, null: false
      t.string :value, null: false
    end
  end
end
