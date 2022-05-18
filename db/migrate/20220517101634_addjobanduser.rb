class Addjobanduser < ActiveRecord::Migration[5.2]
  def change
    create_table :job_users do |t|
      t.references :job, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
