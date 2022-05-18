class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.date :start_date, null: false
      t.date :end_date
      t.boolean :is_active, default: true
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
