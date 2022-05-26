class CreateLeaveTrackers < ActiveRecord::Migration[5.2]
  def change
    create_table :leave_trackers do |t|
      t.date :from_date, null: false
      t.date :to_date, null: false
      t.text :reason, null: false
      t.boolean :is_approved, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end