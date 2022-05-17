class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.string :name, null: false
      t.boolean :is_active, null: false
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
