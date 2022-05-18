class CreateContactInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_infos do |t|
      t.integer :phone_number, null: false
      t.bigint :contactable_id
      t.string :contactable_type

      t.timestamps
    end
  end
end
