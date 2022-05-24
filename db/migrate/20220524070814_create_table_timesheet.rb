class CreateTableTimesheet < ActiveRecord::Migration[5.2]
  def change
    create_table :timesheets do |t|
      t.string :time, null: false
      t.text :description, null: false
      t.boolean :is_approved, null: false,  default: false
      t.references :user, foreign_key: true, null: false
      t.references :project, foreign_key: true, null: false
      t.references :job, foreign_key: true, null: false

      t.timestamps
    end
  end
end
