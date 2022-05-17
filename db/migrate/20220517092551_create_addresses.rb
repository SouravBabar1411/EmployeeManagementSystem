class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.bigint :addressable_id
      t.string :addressable_type
      t.string :address_line_1, null: false
      t.string :address_line_2, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :country, null: false
      t.string :zipcode, null: false

      t.timestamps
    end
  end
end
