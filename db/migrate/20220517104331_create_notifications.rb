class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.string :title, null: true
      t.bigint :notificable_id, null: true
      t.string :notificable_type, null: true

      t.timestamps
    end
  end
end
