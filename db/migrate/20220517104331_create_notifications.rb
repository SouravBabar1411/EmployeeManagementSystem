class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.string :title, null: false
      t.bigint :notificable_id, null: false
      t.string :notificable_type, null: false

      t.timestamps
    end
  end
end
